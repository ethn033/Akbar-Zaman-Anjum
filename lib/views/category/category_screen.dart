// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/categories_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_screen.dart';
import 'package:mula_jan_shayeri/views/poetry/poetry_screen.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  CategoryController categoryController = Get.put(CategoryController());

  WidgetController widgetController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    categoryController.getCategories();
    return Scaffold(
      appBar: AppBar(
        title: Text("Poetry Screen"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Container(
        child: Obx(
          () => categoryController.no_cats.value
              ? Center(
                  child: Text('No records..'),
                )
              : categoryController.categories.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: categoryController.categories.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: 300,
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => PoetryScreen(
                                  categoryId:
                                      categoryController.categories[index].id,
                                ),
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.only(top: 20),
                              elevation: 0,
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                    flex: 6,
                                    child: Container(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: categoryController
                                            .categories[index].thumbnail!,
                                        imageBuilder: (context, image) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.grey[400],
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) {
                                          return Image.asset(
                                            "assets/images/no_image_found.png",
                                            fit: BoxFit.contain,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: Text(
                                          categoryController
                                              .categories[index].name!,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: widgetController.buttonWithIcon(
                                        backgroundColor: Colors.red,
                                        label:
                                            categoryController.uploading.value
                                                ? "Deleting.."
                                                : "Delete",
                                        width: double.minPositive,
                                        onPressed: () async {
                                          if (categoryController
                                              .deleting.value) {
                                            return null;
                                          } else {
                                            await helperController.showDialog(
                                                title: 'Delete Category',
                                                middleText:
                                                    'Are you sure to delete ${categoryController.categories[index].name}?',
                                                onPressedConfirm: () async {
                                                  categoryController
                                                      .deleting.value = true;
                                                  helperController
                                                      .hideLoadingDialog();
                                                  await categoryController
                                                      .deleteCategory(
                                                          categoryId:
                                                              categoryController
                                                                  .categories[
                                                                      index]
                                                                  .id!)
                                                      .then((_) {
                                                    helperController.showToast(
                                                        title:
                                                            'Deleted successfully!',
                                                        color: Colors.green);
                                                  });
                                                  categoryController
                                                      .deleting.value = false;
                                                  categoryController
                                                      .getCategories();
                                                });
                                          }
                                        },
                                        icon: categoryController.deleting.value
                                            ? SizedBox(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                                height: 10.0,
                                                width: 10.0,
                                              )
                                            : Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
      floatingActionButton: authController.currentUser.value != null
          ? FloatingActionButton(
              onPressed: () => {
                Get.to(
                  () => CreateScreen(type: "category"),
                ),
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
