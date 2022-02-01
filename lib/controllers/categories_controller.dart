// ignore_for_file: unnecessary_cast, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mula_jan_shayeri/models/category_model.dart';

class CategoryController extends GetxController {
  CollectionReference refCategories =
      FirebaseFirestore.instance.collection("categories");

  List<CategoryModel> categories =
      List<CategoryModel>.empty(growable: true).obs;
  RxBool uploading = false.obs;
  RxBool deleting = false.obs;
  Rx<File?> pickedFile = (null as File?).obs;
  RxBool no_cats = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> getCategories() async {
    QuerySnapshot querySnapshot = await refCategories
        .where('is_deleted', isEqualTo: false)
        .orderBy("date_created", descending: true)
        .get();

    if (categories.length > 0) {
      categories.clear();
    }

    querySnapshot.docs.forEach((doc) {
      categories.add(
        CategoryModel.Create(
          id: doc.id,
          name: doc.get("name"),
          thumbnail: doc.get("thumbnail"),
          is_deleted: doc.get("is_deleted"),
          date_created: doc.get("date_created"),
        ),
      );
    });

    if (categories.length == 0) {
      no_cats.value = true;
    }
  }

  Future<void> deleteCategory({
    required String categoryId,
  }) async {
    return await refCategories.doc(categoryId).update(
      {
        'is_deleted': true,
      },
    );
  }

  Future<DocumentReference> saveCategory(CategoryModel cm) async {
    return await refCategories.add(cm.toMap());
  }
}
