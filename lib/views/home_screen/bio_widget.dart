import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({
    Key? key,
    required this.settingController,
  }) : super(key: key);

  final SettingController settingController;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Flexible(
          child: Text(
            settingController.userModel.value.bio ?? '..Loding',
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
            ),
          ),
        ),
      ),
    );
  }
}
