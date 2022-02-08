import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/poetry_controller.dart';
import 'package:mula_jan_shayeri/models/poetry_model.dart';

class Search extends SearchDelegate {
  var results;
  var controller;
  Search({required String type}) {
    if (type == 'poetry') {
      controller = Get.find<PoetryController>();
      results = List<PoetryModel>.empty(growable: true);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length > 3) {
      results = controller.search(query);
    }
    return Padding(
      child: Text('building results..'),
      padding: EdgeInsets.only(top: 5, left: 8),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
