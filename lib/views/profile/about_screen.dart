// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';

class BioScreen extends StatelessWidget {
  BioScreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Container(
                height: size.height / 3,
                margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Stack(
                  children: [
                    //cover photo
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ShowFullScreenImage(
                                tag: "coverImage",
                                url: settingController.userModel.value.cover ??
                                    "",
                              ),
                            );
                          },
                          child: Hero(
                            tag: "coverImage",
                            child: Obx(
                              () => CachedNetworkImage(
                                height: size.height / 4,
                                width: size.width,
                                fit: BoxFit.cover,
                                imageUrl:
                                    settingController.userModel.value.cover ??
                                        "",
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
                      ],
                    ),
                    // image photo
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: size.height / 5,
                              width: size.height / 5,
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
                                      url: settingController
                                              .userModel.value.image ??
                                          "",
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "profileImage",
                                  child: Obx(
                                    () => CachedNetworkImage(
                                      imageUrl: settingController
                                              .userModel.value.image ??
                                          "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
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
                                      errorWidget: (context, url, error) =>
                                          Container(
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Text(
                  settingController.userModel.value.name ?? Constants.name,
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(' :پته'),
                    Text(
                      '${settingController.userModel.value.address ?? 'no record'}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 3,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(' :تلیفون شمیره'),
                    Text(
                      '${settingController.userModel.value.phone ?? 'no record'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text(
                  settingController.userModel.value.about ?? '',
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
