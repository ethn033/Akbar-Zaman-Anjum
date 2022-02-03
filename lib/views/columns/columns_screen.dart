// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/columns_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/models/column_model.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_column.dart';

class ColumnScreen extends StatelessWidget {
  String? categoryId;
  ColumnScreen({Key? key, this.categoryId}) : super(key: key);
  ColumnsController columnsController = Get.put(ColumnsController());
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("کالمونه/ لیکنې"),
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
                      textDirection: TextDirection.rtl,
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
                                  settingController.userModel.value.image ?? "",
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
                                Get.to(() => CreateColumnScreen());
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  right: 30,
                                ),
                                height: size.height / 13,
                                width: double.infinity,
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'خپل کالمونه/لیکنې پوسټ کړئ',
                                  textDirection: TextDirection.rtl,
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
              () => columnsController.no_columns.value
                  ? Center(
                      child: Text('No records..'),
                    )
                  : columnsController.columns.length > 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: columnsController.columns.length,
                          itemBuilder: (context, index) {
                            final DateTime dateTime =
                                DateTime.fromMicrosecondsSinceEpoch(
                                    columnsController
                                            .columns[index].date_created! *
                                        1000);
                            final postDate =
                                helperController.getCustomFormattedDateTime(
                                    timeStamp: dateTime);
                            return Container(
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  textDirection: TextDirection.rtl,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: PopupMenuButton(
                                            onSelected: (String option) =>
                                                onOptionSelect(
                                                    option,
                                                    columnsController
                                                        .columns[index]),
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
                                        authController.currentUser.value != null
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Directionality(
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    child: Text(
                                                      '$postDate',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    )),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                    Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: quill.QuillEditor.basic(
                                        readOnly: true,
                                        controller: new quill.QuillController(
                                            document: quill.Document.fromJson(
                                              jsonDecode(columnsController
                                                  .columns[index].column_text!),
                                            ),
                                            selection: TextSelection.collapsed(
                                                offset: 0)),
                                      ),
                                    ),
                                    SizedBox(height: 15),
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
                                                helperController.copyText(
                                                    '${columnsController.columns[index].column_text!}');
                                              },
                                              icon: Icon(
                                                Icons.copy,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                helperController.shareText(
                                                  columnsController
                                                          .columns[index]
                                                          .column_text ??
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
                                                    await columnsController
                                                        .likeColumn(index)
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
                                                columnsController.columns[index]
                                                            .likes ==
                                                        null
                                                    ? Text('0')
                                                    : Text(columnsController
                                                        .columns[index].likes
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
                                                columnsController.columns[index]
                                                            .reads ==
                                                        null
                                                    ? Text('0')
                                                    : Text(columnsController
                                                        .columns[index].reads
                                                        .toString()),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(color: Colors.grey),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: authController.currentUser.value != null
          ? FloatingActionButton(
              onPressed: () => {
                    Get.to(() => CreateColumnScreen()),
                  },
              child: Icon(Icons.add))
          : null,
    );
  }

  onOptionSelect(String option, ColumnModel columnModel) async {
    if (option == 'delete') {
      if (columnsController.deleting.value) {
        return null;
      } else {
        await helperController.showDialog(
            title: 'Delete Category',
            middleText: 'Are you sure to delete?',
            onPressedConfirm: () async {
              columnsController.deleting.value = true;
              helperController.hideLoadingDialog();
              await columnsController
                  .deleteColumn(columnId: columnModel.id!)
                  .then((_) {
                if (columnsController.columns.contains(columnModel)) {
                  columnsController.columns.remove(columnModel);
                  if (columnsController.columns.length == 0) {
                    columnsController.no_columns.value = true;
                  }
                }

                helperController.showToast(title: 'Deleted successfully!');
              });
              columnsController.deleting.value = false;
            });
      }
    } else {}
  }
}
