// ignore_for_file: unnecessary_cast, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/models/book_model.dart';
import 'package:path_provider/path_provider.dart';

class BooksController extends GetxController {
  CollectionReference refBooks = FirebaseFirestore.instance.collection("books");
  List<BookModel> books = List<BookModel>.empty(growable: true).obs;
  RxBool no_books = false.obs;
  HelperController helperController = Get.find();
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> getBooks() async {
    var bks = await refBooks.orderBy("date_created", descending: true).get();
    if (books.length > 0) {
      books.clear();
    }
    bks.docs.forEach((book) {
      books.add(
        BookModel.Create(
          id: book.id,
          name: book.get("name"),
          thumbnail: book.get("thumbnail"),
          url: book.get("url"),
          reads: book.get("reads"),
          date_created: book.get("date_created"),
        ),
      );
    });

    if (books.length == 0) {
      no_books.value = true;
    }
  }

  Rx<File?> file = (null as File?).obs;
  Future<void> downloadPdf(String url, String bookName) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      File f = await File('${appDocDir.path}/$bookName').create();
      Uint8List? bytes =
          await FirebaseStorage.instance.refFromURL(url).getData();
      f.writeAsBytesSync(bytes!);
      file.value = f;
    } on FirebaseException catch (e) {
      print('error occured: $e');
      print(e.message);
    }
  }

  Future<void> deleteBooks(BookModel bookModel) async {
    await FirebaseStorage.instance
        .refFromURL(bookModel.url!)
        .delete()
        .then((value) async {
      helperController.showToast(
          title: 'Book thumbnail deleted.', color: Colors.green);
      await refBooks.doc(bookModel.id).delete().then((_) {
        helperController.showToast(
            title: 'Book thumbnail deleted.', color: Colors.green);

        getBooks();
      }).catchError((onError) {
        helperController.showToast(
            title: 'Error occured: $onError.', color: Colors.red);
      });
    }).catchError((error) async {
      helperController.showToast(
          title: 'error occured: $error', color: Colors.red);
      await refBooks.doc(bookModel.id).delete().then((_) {
        helperController.showToast(
            title: 'Book thumbnail deleted.', color: Colors.green);
        getBooks();
      }).catchError((onError) {
        helperController.showToast(
            title: 'Error occured: $onError.', color: Colors.red);
      });
    });
  }
}
