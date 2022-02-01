// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/poetry_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/models/poetry_model.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_hashtag.dart';

class CreatePoetryScreen extends StatelessWidget {
  CreatePoetryScreen({Key? key}) : super(key: key);
  PoetryController poetryController = Get.find();
  HelperController helperController = Get.find();
  WidgetController widgetController = Get.find();
  TextEditingController poetryTextController = new TextEditingController();
  TextEditingController hashtagTextController = new TextEditingController();

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
                  controller: poetryTextController,
                  minLines: 6,
                  maxLines: 8,
                  onChanged: (value) => {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "دلته شعر وليکئ",
                    alignLabelWithHint: true,
                    hintText: 'خپل شعر ولیکئ',
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: poetryController.can_copy_poetry.value,
                          onChanged: (checked) {
                            poetryController.can_copy_poetry.value = checked!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('کاروونکي کولی شي کاپي کړي'),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Obx(
                      () => SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: poetryController.can_share_poetry.value,
                          onChanged: (checked) {
                            poetryController.can_share_poetry.value = checked!;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('کاروونکي کولی شي شریک کړي'),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ':مهرباني وکړئ د دې شعر/غزل لپاره هشټاګونه غوره کړئ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(
                  () => poetryController.no_hashtags.value
                      ? Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.only(right: 5),
                          child: Row(
                            children: [
                              Text('.هیڅ هشټاګ ونه موندل شو',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              Icon(Icons.info)
                            ],
                          ))
                      : poetryController.hashTags.length == 0
                          ? CircularProgressIndicator()
                          : Wrap(
                              alignment: WrapAlignment.start,
                              runSpacing: -5,
                              spacing: 5,
                              children:
                                  poetryController.hashTags.map((hashtag) {
                                return ActionChip(
                                  onPressed: () {
                                    poetryController.addHatshTag(hashtag.tag!);
                                  },
                                  label: Text(
                                    hashtag.tag!,
                                  ),
                                  elevation: 0,
                                  backgroundColor: poetryController
                                          .selectedHashTags
                                          .contains(hashtag.tag!)
                                      ? Colors.green
                                      : null,
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
                TextButton(
                    onPressed: () {
                      Get.to(() => CreateHashtagScreen());
                    },
                    child: Text('نوي هشټاګونه اضافه کړئ')),
                SizedBox(
                  height: 5,
                ),
                Obx(
                  () => widgetController.buttonWithIcon(
                    onPressed: () async {
                      if (poetryController.uploading.value) {
                        return;
                      }
                      poetryController.uploading.value = true;
                      await savePoetry();
                      poetryController.uploading.value = false;
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> savePoetry() async {
    if (poetryTextController.text.isEmpty) {
      helperController.showToast(
        title: "Error, Please write poetry.",
        color: Colors.red,
      );
      return;
    }

    PoetryModel pm = new PoetryModel();
    pm.poetry_text = poetryTextController.text.trim();
    pm.date_created = DateTime.now().millisecondsSinceEpoch;
    pm.is_deleted = false;
    pm.image_url = "";
    pm.can_copy = poetryController.can_copy_poetry.value;
    pm.can_share = poetryController.can_share_poetry.value;
    pm.likes = 0;
    pm.cat_id = "";
    pm.tags = poetryController.selectedHashTags;

    await poetryController.savePoetry(pm).then((value) {
      pm.id = value.id;
      poetryTextController.text = '';
      helperController.showToast(
        title: "Successfully created!",
        color: Colors.green,
      );

      poetryController.can_copy_poetry.value = true;
      poetryController.can_share_poetry.value = true;

      poetryController.poetries.insert(0, pm);
      poetryController.selectedHashTags.clear();
    }, onError: (error) {
      helperController.showToast(
        title: "Some error occured. Please try again.",
        color: Colors.green,
      );
    });
  }
}
