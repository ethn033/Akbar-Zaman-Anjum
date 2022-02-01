// ignore_for_file: unnecessary_statements

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mula_jan_shayeri/controllers/books_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/models/book_model.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';

class CreateBook extends StatefulWidget {
  const CreateBook({Key? key}) : super(key: key);

  @override
  _CreateBookState createState() => _CreateBookState();
}

class _CreateBookState extends State<CreateBook> {
  var _controller = new TextEditingController();
  File? pickedBook;
  HelperController helperController = Get.find();
  BooksController booksController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (uploadTask != null) {
      uploadTask!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                double.infinity,
                35.0,
              ),
              primary: Colors.grey[300],
            ),
            onPressed: () async {
              await _pickBook(context);
            },
            child: Text(
              pickedBook == null ? "Choose Book" : "Replace Book",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          pickedBook != null
              ? Text(pickedBook != null ? pickedBook!.path.split('/').last : "")
              : SizedBox(),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter book title",
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 16),
              minimumSize: Size(double.infinity, 35),
            ),
            onPressed: () {
              uploading ? null : _saveBook();
            },
            child: Text(uploading ? "Saving.." : "Save"),
          ),
        ],
      ),
    );
  }

  bool uploading = false;
  UploadTask? uploadTask;
  Future<String> uploadBook() async {
    setState(() {
      uploading = true;
    });

    String fileNaame = new Random().nextInt(5000).toString() +
        '${pickedBook!.path.split('/').last}.pdf';
    uploadTask = FirebaseStorage.instance
        .ref()
        .child(Constants.STORAGE_BOOKS)
        .child(fileNaame)
        .putFile(pickedBook!);
    TaskSnapshot? snapshot = await uploadTask;
    final url = await snapshot!.ref.getDownloadURL();
    setState(() {
      uploading = false;
    });
    return Future.value(url);
  }

  Future<void> _saveBook() async {
    if (_controller.text == "") {
      helperController.showToast(
        title: "Error, Please write book title.",
        color: Colors.red,
      );
      return;
    }

    BookModel bm = new BookModel();
    bm.reads = 0;
    bm.thumbnail = Constants.categoryThumbnail;
    bm.name = _controller.text;
    bm.date_created = DateTime.now().millisecondsSinceEpoch;
    bm.is_deleted = false;

    bm.url = await uploadBook();

    await FirebaseFirestore.instance.collection('books').add(bm.toMap()).then(
        (value) {
      helperController.showToast(
        title: "Successfully created!",
        color: Colors.green,
      );
    }, onError: (error) {
      helperController.showToast(
        title: "Some error occured. Please try again. $error",
        color: Colors.green,
      );
    });

    booksController.getBooks();
  }

  Future<void> _pickBook(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        pickedBook = new File(result.files.first.path!);
        _controller.text = pickedBook!.path.split('/').last;
      });
    }
  }
}
