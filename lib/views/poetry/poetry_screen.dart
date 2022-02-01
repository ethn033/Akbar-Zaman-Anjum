// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/poetry_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/models/poetry_model.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_poetry.dart';

class PoetryScreen extends StatelessWidget {
  String? categoryId;
  PoetryScreen({Key? key, this.categoryId}) : super(key: key);
  PoetryController poetryController = Get.put(PoetryController());
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("شاعري"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              authController.currentUser.value != null
                  ? Container(
                      color: Colors.white,
                      height: size.height / 7,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: 30,
                            ),
                            child: Obx(
                              () => CachedNetworkImage(
                                height: size.height / 17,
                                width: size.height / 17,
                                imageUrl:
                                    settingController.userModel.value.image ??
                                        "",
                                imageBuilder: (context, image) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: image,
                                      fit: BoxFit.fill,
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
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(
                                right: 10,
                                left: 30,
                              ),
                              alignment: Alignment.center,
                              height: size.height / 17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: Colors.grey[200]!,
                                  width: 2,
                                ),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => CreatePoetryScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    right: 30,
                                  ),
                                  height: size.height / 13,
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'خپل شعر پوسټ کړئ',
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(),
              Divider(
                thickness: 0.1,
              ),
              Obx(
                () => poetryController.no_poetry.value
                    ? Center(
                        child: Text('No records..'),
                      )
                    : poetryController.poetries.length > 0
                        ? ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: poetryController.poetries.length,
                            itemBuilder: (context, index) {
                              final DateTime dateTime =
                                  DateTime.fromMicrosecondsSinceEpoch(
                                      poetryController
                                              .poetries[index].date_created! *
                                          1000);
                              final postDate =
                                  helperController.getCustomFormattedDateTime(
                                      timeStamp: dateTime);
                              return Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    authController.currentUser.value != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                child: PopupMenuButton(
                                                  onSelected: (String option) =>
                                                      onOptionSelect(
                                                          option,
                                                          poetryController
                                                              .poetries[index]),
                                                  itemBuilder: (context) => [
                                                    PopupMenuItem(
                                                      value: 'delete',
                                                      child: Text(
                                                        'Delete',
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'edit',
                                                      child: Text(
                                                        'Edit',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16.0),
                                                child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: Text(
                                                      '$postDate',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )),
                                              )
                                            ],
                                          )
                                        : SizedBox(),
                                    InteractiveViewer(
                                      minScale: 0.5,
                                      maxScale: 3.0,
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: FittedBox(
                                          alignment: Alignment.center,
                                          fit: BoxFit.cover,
                                          child: Text(
                                              poetryController
                                                  .poetries[index].poetry_text!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    poetryController
                                                .poetries[index].tags!.length >
                                            0
                                        ? Container(
                                            padding: EdgeInsets.only(
                                                left: 30,
                                                right: 30,
                                                top: 0,
                                                bottom: 0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'هشټاګونه:',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 0, bottom: 0),
                                                    child: Wrap(
                                                      spacing: 5,
                                                      runSpacing: -5,
                                                      children: poetryController
                                                          .poetries[index].tags!
                                                          .map(
                                                            (tag) => ActionChip(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              onPressed: () {},
                                                              label: Text(tag,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blue)),
                                                              elevation: 0,
                                                              labelPadding:
                                                                  EdgeInsets
                                                                      .only(
                                                                left: 3,
                                                                right: 8,
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ))
                                        : SizedBox(),
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 30,
                                        ),
                                        child: ButtonBar(
                                          alignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          buttonPadding: EdgeInsets.zero,
                                          children: [
                                            IconButton(
                                              tooltip: 'Copy',
                                              onPressed: () {
                                                if (!poetryController
                                                    .poetries[index]
                                                    .can_copy!) {
                                                  helperController.showToast(
                                                      title:
                                                          'Sorry, the author does not allow copying of the contents.');
                                                  return;
                                                }

                                                helperController.copyText(
                                                    '${poetryController.poetries[index].poetry_text!}');
                                              },
                                              icon: Icon(
                                                Icons.copy,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                if (!poetryController
                                                    .poetries[index]
                                                    .can_copy!) {
                                                  helperController.shareApp();
                                                  return;
                                                }
                                                helperController.shareText(
                                                  poetryController
                                                          .poetries[index]
                                                          .poetry_text ??
                                                      "",
                                                );
                                              },
                                              icon: Icon(
                                                Icons.share,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () async {
                                                    await poetryController
                                                        .likePoetry(index)
                                                        .then((_) {
                                                      helperController
                                                          .showToast(
                                                              title: "Liked!");
                                                    }).catchError((onError) {
                                                      helperController.showToast(
                                                          title:
                                                              "Some error occured.");
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.thumb_up,
                                                  ),
                                                ),
                                                poetryController.poetries[index]
                                                            .likes ==
                                                        null
                                                    ? Text('0')
                                                    : Text(poetryController
                                                        .poetries[index].likes
                                                        .toString()),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.remove_red_eye,
                                                  ),
                                                ),
                                                poetryController.poetries[index]
                                                            .reads ==
                                                        null
                                                    ? Text('0')
                                                    : Text(poetryController
                                                        .poetries[index].reads
                                                        .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                      child: Container(
                                        color: Colors.grey[50],
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child:
                                CircularProgressIndicator(color: Colors.grey),
                          ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: authController.currentUser.value != null
          ? FloatingActionButton(
              onPressed: () => {
                    Get.to(() => CreatePoetryScreen()),
                  },
              child: Icon(Icons.add))
          : null,
    );
  }

  onOptionSelect(String option, PoetryModel poetryModel) async {
    if (option == 'delete') {
      if (poetryController.deleting.value) {
        return null;
      } else {
        await helperController.showDialog(
            title: 'Delete Category',
            middleText: 'Are you sure to delete?',
            onPressedConfirm: () async {
              poetryController.deleting.value = true;
              helperController.hideLoadingDialog();
              await poetryController
                  .deletePOetry(poetryId: poetryModel.id!)
                  .then((_) {
                if (poetryController.poetries.contains(poetryModel)) {
                  poetryController.poetries.remove(poetryModel);
                  if (poetryController.poetries.length == 0) {
                    poetryController.no_poetry.value = true;
                  }
                }

                helperController.showToast(title: 'Deleted successfully!');
              });
              poetryController.deleting.value = false;
            });
      }
    } else {}
  }
}
