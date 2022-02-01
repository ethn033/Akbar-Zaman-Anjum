// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mula_jan_shayeri/views/poetry/poetry_screen.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_book.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_category.dart';

class CreateScreen extends StatefulWidget {
  String type;
  CreateScreen({Key? key, required this.type}) : super(key: key);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create ${widget.type}"),
      ),
      body: widget.type == "category"
          ? CreateCategory()
          : widget.type == "poetry"
              ? PoetryScreen()
              : widget.type == "book"
                  ? CreateBook()
                  : Center(
                      child: Text('No option selected'),
                    ),
    );
  }
}
