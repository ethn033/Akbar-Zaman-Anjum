// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';

class BioScreen extends StatelessWidget {
  BioScreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  late quill.QuillController _controller;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _controller = new quill.QuillController(
        document: quill.Document.fromJson(
            jsonDecode(settingController.userModel.value.about!)),
        selection: TextSelection.collapsed(offset: 0));
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            physics: PageScrollPhysics(),
            child: Column(
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
                                  url:
                                      settingController.userModel.value.cover ??
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
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
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
                    settingController.userModel.value.name ?? '',
                    style: TextStyle(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            'تلیفون: ${settingController.userModel.value.phone ?? ''}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            'پته: ${settingController.userModel.value.address ?? ''}',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ]),
                ),
                Container(
                  child: quill.QuillEditor(
                    padding: EdgeInsets.all(15),
                    expands: false,
                    controller: _controller,
                    readOnly: true,
                    autoFocus: false,
                    focusNode: new FocusNode(
                      canRequestFocus: false,
                    ),
                    scrollController: new ScrollController(),
                    scrollable: true,
                    scrollPhysics: BouncingScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
