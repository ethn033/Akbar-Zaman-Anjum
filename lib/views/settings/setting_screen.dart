// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScrreen extends StatelessWidget {
  SettingScrreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  static const key_custom_theme = 'key_custom_theme';
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: SettingsList(
        physics: BouncingScrollPhysics(),
        sections: [
          SettingsSection(
            title: Text('General Info'),
            tiles: [
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {
                  settingController.swithTheme = value;
                },
                initialValue: settingController.swithTheme,
                leading: Icon(Icons.format_paint),
                title: Text('Dark Mode'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
