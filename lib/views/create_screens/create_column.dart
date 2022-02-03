// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/columns_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/models/column_model.dart';

class CreateColumnScreen extends StatelessWidget {
  CreateColumnScreen({Key? key}) : super(key: key);

  SettingController settingController = Get.find();
  quill.QuillController quillController = quill.QuillController.basic();
  HelperController helperController = Get.find();
  ColumnsController columnsController = Get.find();
  WidgetController widgetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('مقالې، لیکنې پوسټ کړئ'),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Container(
              height: 400,
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
            Obx(
              () => CheckboxListTile(
                value: columnsController.can_copy_column.value,
                onChanged: (val) {
                  columnsController.can_copy_column.value = val!;
                },
                title: Text('کاروونکي کولی شي کاپي کړي'),
              ),
            ),
            Obx(
              () => CheckboxListTile(
                value: columnsController.can_share_column.value,
                onChanged: (val) {
                  columnsController.can_share_column.value = val!;
                },
                title: Text('کاروونکي کولی شي شریک کړي'),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: widgetController.buttonWithIcon(
                onPressed: () async {
                  if (columnsController.uploading.value) {
                    return;
                  }
                  String columnText =
                      jsonEncode(quillController.document.toDelta().toJson());
                  if (columnText.isEmpty || columnText.length < 50) {
                    helperController.showToast(
                        title: 'Please write your article.');
                    return;
                  }
                  columnsController.uploading.value = true;

                  ColumnModel cm = new ColumnModel();

                  cm.can_copy = columnsController.can_copy_column.value;
                  cm.can_share = columnsController.can_share_column.value;
                  cm.column_text = columnText;
                  cm.image_url = '';
                  cm.is_deleted = false;
                  cm.reads = 0;
                  cm.likes = 0;
                  cm.date_created = DateTime.now().millisecondsSinceEpoch;
                  await columnsController.saveColumn(cm).then((value) {
                    print(value);
                    helperController.showToast(title: 'Saved successfully.');
                  }).catchError((error) {
                    helperController.showToast(title: 'Error occured : $error');
                  });
                  columnsController.uploading.value = false;
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
                label: 'Post Article',
                width: double.infinity,
              ),
            )
          ],
        ),
      ),
    );
  }
}
