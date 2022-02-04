import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';

class CoverWidget extends StatelessWidget {
  const CoverWidget(
      {Key? key,
      required this.settingController,
      required this.authController,
      required this.helperController,
      required this.size})
      : super(key: key);

  final AuthController authController;
  final SettingController settingController;
  final HelperController helperController;
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.to(
              () => ShowFullScreenImage(
                tag: "coverImage",
                url: settingController.userModel.value.cover ?? "",
              ),
            );
          },
          child: Hero(
            tag: "coverImage",
            child: Obx(
              () => CachedNetworkImage(
                height: size.height / 3.9,
                width: size.width,
                imageUrl: settingController.userModel.value.cover ?? "",
                imageBuilder: (context, image) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    shape: BoxShape.rectangle,
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/no_image_found.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Obx(
          () => authController.currentUser.value != null
              ? Positioned(
                  right: -10,
                  bottom: 5,
                  child: MaterialButton(
                    onPressed: () {
                      showBottomsheet('cover');
                    },
                    color: Colors.white10.withOpacity(0.7),
                    textColor: Colors.white,
                    child: Icon(
                      Icons.edit,
                      size: 19,
                      color: Colors.black,
                    ),
                    shape: CircleBorder(),
                    elevation: 0.5,
                  ),
                )
              : SizedBox(),
        ),
      ],
    );
  }

  showBottomsheet(String type) async {
    await Get.bottomSheet(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Camera'),
            onTap: () async {
              Get.back();
              File file =
                  await helperController.pickFile(ImageSource.camera) as File;
              file = await helperController.cropImage(img: file);
              helperController.showLoadingDialog(title: 'Uploading Image..');
              String url = await helperController.uploadFile(
                  file: file, storageReffernece: 'profile_images/');
              await settingController.updateUser(
                  helperController: helperController, data: {'cover': url});
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.image,
            ),
            title: Text('Gallery'),
            onTap: () async {
              Get.back();
              File file =
                  await helperController.pickFile(ImageSource.gallery) as File;
              file = await helperController.cropImage(img: file);
              helperController.showLoadingDialog(title: 'Uploading Image..');
              String url = await helperController.uploadFile(
                  file: file, storageReffernece: 'profile_images');
              await settingController.updateUser(
                  helperController: helperController, data: {'cover': url});
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(
              Icons.delete_outline,
            ),
            title: Text('Remove Image'),
            onTap: () async {
              Get.back();
              await settingController.updateUser(
                  helperController: helperController, data: {'cover': ''});
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      isScrollControlled: true,
      isDismissible: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      ignoreSafeArea: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
