// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/books_controller.dart';

class ReadPdfScreen extends StatefulWidget {
  String url, bookName;
  ReadPdfScreen({Key? key, required this.url, required this.bookName})
      : super(key: key);

  @override
  _ReadPdfScreenState createState() => _ReadPdfScreenState();
}

class _ReadPdfScreenState extends State<ReadPdfScreen> {
  BooksController controller = Get.find();

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int totalPages = 0;
  @override
  void initState() {
    super.initState();
    controller.downloadPdf(widget.url, widget.bookName);
  }

  @override
  void dispose() {
    super.dispose();
    controller.file.value = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Obx(
          () => controller.file.value == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : PDFView(
                  filePath: controller.file.value!.path,
                  pageFling: true,
                  defaultPage: 0,
                  fitPolicy: FitPolicy.BOTH,
                  onRender: (pages) {
                    totalPages = pages!;
                  },
                  onError: (error) {
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                  },
                ),
        ),
      ),
    );
  }
}
