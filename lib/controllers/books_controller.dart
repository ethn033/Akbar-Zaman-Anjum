// ignore_for_file: unnecessary_cast, non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mula_jan_shayeri/models/book_model.dart';
import 'package:path_provider/path_provider.dart';

class BooksController extends GetxController {
  CollectionReference refBooks = FirebaseFirestore.instance.collection("books");
  List<BookModel> books = List<BookModel>.empty(growable: true).obs;
  RxBool no_books = false.obs;
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
    return await FirebaseStorage.instance
        .refFromURL(bookModel.url!)
        .delete()
        .then((value) {
      refBooks.doc(bookModel.id).delete();
    });
  }
}
