// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';
import 'package:mula_jan_shayeri/views/partials/widgets.dart';

class SocialScreen extends StatelessWidget {
  SocialScreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('اړیکې'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            height: size.height / 6,
            child: Container(
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
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
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
          ),
          Obx(
            () => Column(
              children: [
                Text(
                  settingController.userModel.value.name ?? 'Loding..',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SocialContact(),
              ],
            ),
          ),

          // General Info
        ],
      ),
    );
  }
}
