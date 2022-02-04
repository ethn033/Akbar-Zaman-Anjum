import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
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
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              height: size.height / 4.6,
              width: size.height / 4.6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => ShowFullScreenImage(
                      tag: "profileImage",
                      url: settingController.userModel.value.image ?? "",
                    ),
                  );
                },
                child: Hero(
                  tag: "profileImage",
                  child: Obx(
                    () => CachedNetworkImage(
                      imageUrl: settingController.userModel.value.image ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/no_image.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () => authController.currentUser.value != null
                  ? Positioned(
                      right: size.height / 5 / 2 - 5,
                      bottom: 0,
                      child: MaterialButton(
                        onPressed: () {
                          showBottomsheet('image');
                        },
                        color: Colors.white10.withOpacity(0.9),
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
        ),
      ),
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
                  helperController: helperController, data: {'image': url});
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
                  helperController: helperController, data: {'image': url});
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
                  helperController: helperController, data: {'image': ''});
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
