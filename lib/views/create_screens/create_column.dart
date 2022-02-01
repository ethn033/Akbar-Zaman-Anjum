// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';

class CreateColumnScreen extends StatelessWidget {
  CreateColumnScreen({Key? key}) : super(key: key);

  HelperController helperController = Get.find();
  WidgetController widgetController = Get.find();
  TextEditingController colTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('کالمونه/ لیکنې'),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Center(
            child: Text('ژر راځي ... موږ لاهم په دې کار کوو!'),
          ),
        ),
      ),
    );
  }
}
