import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Widget buttonWithIcon({
    required Function() onPressed,
    required Widget icon,
    required String label,
    Color? backgroundColor,
    Color? color,
    required double width,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(label),
      style: OutlinedButton.styleFrom(
          primary: color,
          backgroundColor: backgroundColor,
          minimumSize: Size(width, 40.0)),
    );
  }

  Widget button({
    required Function() onPressed,
    required String label,
    Color? backgroundColor,
    Color? color,
    required double width,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        primary: color,
        backgroundColor: backgroundColor,
        minimumSize: Size(width, 40.0),
      ),
      child: Text(label),
    );
  }
}
