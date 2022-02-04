// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/columns_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';

class CreateAboutScreen extends StatelessWidget {
  CreateAboutScreen({Key? key}) : super(key: key);

  SettingController settingController = Get.find();
  late quill.QuillController quillController;
  HelperController helperController = Get.find();

  WidgetController widgetController = Get.find();

  @override
  Widget build(BuildContext context) {
    quillController = quill.QuillController(
        document: quill.Document.fromJson(
            jsonDecode(settingController.userModel.value.about ?? '')),
        selection: new TextSelection(baseOffset: 0, extentOffset: 0));
    return Scaffold(
      appBar: AppBar(
        title: Text('د خپل ځان په اړه ولیکئ'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[100],
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: quill.QuillToolbar.basic(
              showBackgroundColorButton: true,
              toolbarIconAlignment: WrapAlignment.center,
              controller: quillController,
              multiRowsDisplay: true,
              showCameraButton: false,
              showAlignmentButtons: true,
              showIndent: true,
              showImageButton: false,
              showVideoButton: false,
              showStrikeThrough: false,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.3,
                    blurRadius: 3,
                    offset: Offset(
                      2,
                      0.4,
                    ), // changes position of shadow
                  ),
                ],
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: quill.QuillEditor.basic(
                  controller: quillController,
                  readOnly: false,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: widgetController.buttonWithIcon(
              onPressed: () async {
                if (settingController.isAboutUpdate.value) {
                  return;
                }
                String columnText =
                    jsonEncode(quillController.document.toDelta().toJson());
                if (columnText.isEmpty || columnText.length < 50) {
                  helperController.showToast(
                      title:
                          'Please write some detailed descriptions about yourself.',
                      color: Colors.red);
                  return;
                }
                settingController.isAboutUpdate.value = true;

                await settingController.updateUser(
                    data: {'about': columnText},
                    helperController: helperController);
                settingController.isAboutUpdate.value = false;
              },
              icon: Obx(
                () => !settingController.isAboutUpdate.value
                    ? Icon(Icons.post_add)
                    : SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        height: 10.0,
                        width: 10.0,
                      ),
              ),
              label: 'Save About',
              width: double.infinity,
            ),
          )
        ],
      ),
    );
  }
}
