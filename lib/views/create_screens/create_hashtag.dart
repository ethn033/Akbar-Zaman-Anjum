// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/poetry_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';

class CreateHashtagScreen extends StatelessWidget {
  CreateHashtagScreen({Key? key}) : super(key: key);
  PoetryController poetryController = Get.find();
  HelperController helperController = Get.find();
  TextEditingController hashtagTextController = new TextEditingController();
  WidgetController widgetController = Get.find();
  @override
  Widget build(BuildContext context) {
    poetryController.getHashTags();
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Poetry"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'خپل شعر ولیکئ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  textAlign: TextAlign.start,
                  controller: hashtagTextController,
                  maxLines: 1,
                  onChanged: (value) => {print},
                  onSubmitted: (val) async {
                    await saveHashtag();
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'هشټاګ ولیکئ',
                      alignLabelWithHint: true,
                      hintTextDirection: TextDirection.rtl,
                      hintText: 'هشټاګ',
                      prefixText: '#',
                      prefixStyle: TextStyle(
                          textBaseline: TextBaseline.alphabetic,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54)),
                ),
                SizedBox(height: 10),
                Obx(
                  () => widgetController.buttonWithIcon(
                    onPressed: () async {
                      await saveHashtag();
                    },
                    icon: poetryController.uploading.value
                        ? SizedBox(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            height: 10.0,
                            width: 10.0,
                          )
                        : Icon(Icons.upload_outlined),
                    label:
                        poetryController.uploading.value ? "Saving.." : "Save",
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'هشټاګونه:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Obx(
                  () => poetryController.no_hashtags.value
                      ? Center(
                          child: Text('No record found',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        )
                      : poetryController.hashTags.length == 0
                          ? CircularProgressIndicator()
                          : Wrap(
                              alignment: WrapAlignment.start,
                              runSpacing: -5,
                              spacing: 5,
                              children:
                                  poetryController.hashTags.map((hashtag) {
                                return Chip(
                                  onDeleted: () async {
                                    await helperController.showLoadingDialog(
                                        title: 'Deleting..');
                                    await poetryController
                                        .deleteHashtag(hashtag);
                                    await helperController.hideLoadingDialog();
                                  },
                                  deleteIcon: Icon(Icons.delete),
                                  label: Text(
                                    hashtag.tag!,
                                  ),
                                  elevation: 0,
                                  labelPadding: EdgeInsets.only(
                                    left: 3,
                                    right: 8,
                                  ),
                                  avatar: CircleAvatar(
                                    child: Text(
                                      hashtag.tag!.substring(1, 2),
                                    ),
                                  ),
                                  padding: poetryController.selectedHashTags
                                          .contains(hashtag.tag!)
                                      ? EdgeInsets.all(3)
                                      : null,
                                );
                              }).toList(),
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveHashtag() async {
    if (poetryController.uploading.value) {
      return;
    }

    if (hashtagTextController.text.trim().toLowerCase().isEmpty) {
      helperController.showToast(title: 'Please write a tag to save.');
      return;
    }
    String tag = '#' + hashtagTextController.text.trim().toLowerCase();

    if (await poetryController.isTagExists(tag)) {
      helperController.showToast(title: 'Tag already exists.');
      return;
    }

    poetryController.uploading.value = true;
    await poetryController.saveHashTag(tag).then((_) async {
      helperController.showToast(title: 'Saved Successfully.');
      hashtagTextController.text = '';
    }).catchError((onError) {
      helperController.showToast(
          title: 'Error occured while saving hashtag $onError.');
    });
    poetryController.uploading.value = false;
  }
}
