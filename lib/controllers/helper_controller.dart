import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';
import 'package:intl/intl.dart';

class HelperController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> showDialog({
    required String title,
    required String middleText,
    Widget? content,
    Color? buttonColor,
    required Function() onPressedConfirm,
  }) async {
    await Get.defaultDialog(
      title: title,
      middleText: middleText,
      textConfirm: "Confirm",
      textCancel: "Cancel",
      barrierDismissible: false,
      content: content,
      confirm: OutlinedButton(
        onPressed: onPressedConfirm,
        child: Text("Confirm"),
        style: ButtonStyle(
          backgroundColor: buttonColor == null
              ? MaterialStateProperty.all<Color>(Colors.red)
              : MaterialStateProperty.all<Color>(Colors.blue),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Get.back(),
        child: Text("Cancel"),
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
    );
  }

  showLoadingDialog({
    required String title,
  }) {
    Get.defaultDialog(
      title: title,
      barrierDismissible: false,
      content: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
        ),
        child: Row(
          children: [
            CircularProgressIndicator(
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text("Loading.."),
            ),
          ],
        ),
      ),
      onCancel: null,
    );
  }

  Future<void> hideLoadingDialog() async {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  // late Rx<File> pickedImage;
  UploadTask? uploadTask;
  Future<String> uploadFile({
    required File file,
    required String storageReffernece,
  }) async {
    String fileName =
        new Random().nextInt(5000).toString() + '${file.path.split('/').last}';
    uploadTask = FirebaseStorage.instance
        .ref()
        .child(storageReffernece)
        .child(fileName)
        .putFile(file);
    TaskSnapshot? snapshot = await uploadTask;
    final url = await snapshot!.ref.getDownloadURL();
    return Future.value(url);
  }

  ImagePicker picker = new ImagePicker();
  Future<File?> pickFile(ImageSource src) async {
    var file = await picker.pickImage(source: src);
    if (file == null) {
      return null;
    }
    return File(file.path);
  }

  Future<File> cropImage({
    required File img,
  }) async {
    File? image = await ImageCropper.cropImage(
      sourcePath: img.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Your Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        title: 'Crop your Image',
      ),
    );
    return Future<File>.value(image);
  }

  void showToast({
    required String title,
    required Color color,
  }) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> deleteDocument({
    required String collectionName,
    required String id,
  }) async {
    return FirebaseFirestore.instance
        .collection(collectionName)
        .doc(id)
        .update({
      'is_deleted': true,
    }).then(
      (_) {
        showToast(
          title: "Deleted successfully.",
          color: Colors.green,
        );
      },
    ).catchError(
      (error) {
        showToast(
          title: "Error occured while deleting the recorrd. $error",
          color: Colors.green,
        );
      },
    );
  }

  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch';
    }
  }

  Future<void> launchWhatsapp(String phone, String message) async {
    String uri = "https://wa.me/$phone/?text=${Uri.parse(message)}";

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch';
    }
  }

  Future<void> launchSms(String phone, String message) async {
    Uri uri = Uri(
      scheme: 'sms',
      path: '$phone',
      query: encodeQueryParameters(<String, String>{'body': message}),
    );

    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Future<PackageInfo?> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  Future<void> shareApp() async {
    PackageInfo? pck = await getPackageInfo();

    if (pck != null) {
      await shareText(
        '',
      );
    } else {
      throw 'package info is null';
    }
  }

  shareText(String text) async {
    var pckgInfo = await getPackageInfo();
    await Share.share(
        '$text\nhttps://play.google.com/store/apps/details?id=${pckgInfo!.packageName}');
  }

  Future<void> downloadFile(String path) async {
    try {
      String name = FirebaseStorage.instance.refFromURL(path).name;
      Directory? appDocDir = await getExternalStorageDirectory();
      File f = await File('${appDocDir?.path}/$name').create();
      Uint8List? bytes =
          await FirebaseStorage.instance.refFromURL(path).getData();
      f.writeAsBytesSync(bytes!);
      showToast(title: "Saved to: ${f.path}", color: Colors.green);
    } on FirebaseException catch (e) {
      showToast(title: e.message.toString(), color: Colors.red);
    }
  }

  getCustomFormattedDateTime({required DateTime timeStamp}) {
    return DateFormat('dd MMMM yyyy hh:mm a').format(timeStamp);
  }

  copyText(String text) async {
    var pckgInfo = await getPackageInfo();
    await FlutterClipboard.copy(
            '$text\nhttps://play.google.com/store/apps/details?id=${pckgInfo!.packageName}')
        .then(
      (value) => showToast(title: 'Copied to Clipbord!', color: Colors.green),
    );
  }

  getcolor() {
    return Constants.colors[new Random().nextInt(Constants.colors.length)];
  }
}
