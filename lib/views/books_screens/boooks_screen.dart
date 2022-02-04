// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/books_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/views/books_screens/read_pdf_screen.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_screen.dart';

class BooksScreen extends StatelessWidget {
  BooksScreen({Key? key}) : super(key: key);
  BooksController booksController = Get.put(BooksController());
  WidgetController widgetsController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    booksController.getBooks();
    return Scaffold(
      appBar: AppBar(
        title: Text("کتابونه"),
      ),
      body: Container(
        child: Obx(
          () => booksController.no_books.value
              ? Center(
                  child: Text('No records..'),
                )
              : booksController.books.length == 0
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 4.0,
                      children: booksController.books.map((bookModel) {
                        return GridTile(
                          child: InkWell(
                            onTap: () {
                              Get.to(
                                () => ReadPdfScreen(
                                  url: bookModel.url ?? "",
                                  bookName: bookModel.name ?? "",
                                ),
                              );
                            },
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Column(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: Container(
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: bookModel.thumbnail!,
                                        imageBuilder: (context, image) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.contain,
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
                                          bookModel.name ?? "Book Name",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  authController.currentUser.value != null
                                      ? Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: widgetsController
                                                .buttonWithIcon(
                                              onPressed: () async {
                                                helperController.showDialog(
                                                    title: "Delete Book",
                                                    middleText:
                                                        'Are you sure to delete ${bookModel.name}',
                                                    onPressedConfirm: () async {
                                                      await booksController
                                                          .deleteBooks(
                                                              bookModel)
                                                          .then((value) {
                                                        helperController.showToast(
                                                            title:
                                                                'Deleted successfully!',
                                                            color:
                                                                Colors.green);
                                                        booksController
                                                            .getBooks();
                                                      }).catchError((onError) {
                                                        helperController.showToast(
                                                            title:
                                                                'Some error occured $onError',
                                                            color: Colors.red);
                                                      });
                                                    });
                                              },
                                              icon: Icon(Icons.delete),
                                              label: "Delete Book",
                                              width: double.minPositive,
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
        ),
      ),
      floatingActionButton: authController.currentUser.value != null
          ? FloatingActionButton(
              onPressed: () => {
                Get.to(
                  () => CreateScreen(type: "book"),
                )
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
