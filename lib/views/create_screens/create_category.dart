// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mula_jan_shayeri/controllers/categories_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/models/category_model.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';

class CreateCategory extends StatelessWidget {
  CreateCategory({Key? key}) : super(key: key);
  CategoryController categoryController = Get.find();
  TextEditingController textEditingController = new TextEditingController();
  WidgetController widgetController = Get.find();
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () {
                return categoryController.pickedFile.value == null
                    ? Image.asset(
                        "assets/images/no_image_found.png",
                        height: 300,
                      )
                    : Image.file(
                        categoryController.pickedFile.value!,
                        height: 300,
                      );
              },
            ),
            widgetController.buttonWithIcon(
              label: categoryController.pickedFile.value == null
                  ? "Choose image"
                  : "Replace image",
              icon: Icon(Icons.image),
              width: double.infinity,
              onPressed: () async {
                categoryController.pickedFile.value =
                    await helperController.pickFile(ImageSource.gallery);
                categoryController.pickedFile.value = await helperController
                    .cropImage(img: categoryController.pickedFile.value!);
              },
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Enter category name",
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Obx(
              () => widgetController.buttonWithIcon(
                label: categoryController.uploading.value ? "Saving.." : "Save",
                width: double.infinity,
                onPressed: () async {
                  if (categoryController.uploading.value) {
                    return null;
                  } else {
                    categoryController.uploading.value =
                        !categoryController.uploading.value;
                    await _saveCategory();
                    categoryController.uploading.value =
                        !categoryController.uploading.value;
                    categoryController.getCategories();
                  }
                },
                icon: categoryController.uploading.value
                    ? SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                        height: 10.0,
                        width: 10.0,
                      )
                    : Icon(Icons.upload_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveCategory() async {
    if (textEditingController.text.isEmpty) {
      helperController.showToast(
        title: "Error, Please write category name.",
        color: Colors.red,
      );
      return;
    }

    CategoryModel cm = new CategoryModel();
    cm.name = textEditingController.text.trim();
    cm.date_created = DateTime.now().millisecondsSinceEpoch;
    cm.is_deleted = false;
    categoryController.pickedFile.value != null
        ? cm.thumbnail = await helperController.uploadFile(
            file: categoryController.pickedFile.value!,
            storageReffernece: Constants.STORAGE_CATEGORY_IMAGES)
        : cm.thumbnail = "";

    await categoryController.saveCategory(cm).then((value) {
      helperController.showToast(
        title: "Successfully created!",
        color: Colors.green,
      );
    }, onError: (error) {
      helperController.showToast(
        title: "Some error occured. Please try again.",
        color: Colors.green,
      );
    });
    categoryController.pickedFile.value = null;
  }
}
