// ignore_for_file: must_be_immutable
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';

class HomeCard extends StatelessWidget {
  String title;
  IconData icon;
  HomeCard({required this.title, required this.icon});
  Color color = Constants.colors[new Random().nextInt(Constants.colors.length)];

  @override
  Widget build(BuildContext context) {
    return Card(
      // clipBehavior: Clip.none,
      elevation: 0.3,
      color: color.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.all(5),
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContactUs extends StatelessWidget {
  ContactUs({
    Key? key,
  }) : super(key: key);

  final HelperController helperController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.facebook,
            color: Colors.blue,
          ),
          onPressed: () async {
            await helperController.launchUrl(Constants.devFbUrl);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Image.asset('assets/images/whtsapp_icon.png'),
          onPressed: () async {
            await helperController.launchWhatsapp(
                Constants.devPhone, Constants.devMessage);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Icon(
            Icons.message_rounded,
            color: Colors.blue,
          ),
          onPressed: () async {
            await helperController.launchSms(
                Constants.devPhone, Constants.devMessage);
          },
          iconSize: 35,
        ),
        IconButton(
          icon: Image.asset('assets/images/telegram_icon.png'),
          onPressed: () async {
            await helperController.launchUrl(Constants.devTeliUrl);
          },
          iconSize: 35,
        ),
      ],
    );
  }
}

class SocialContact extends StatelessWidget {
  SocialContact({
    Key? key,
  }) : super(key: key);

  final HelperController helperController = Get.find();
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.facebook,
            color: Colors.blue,
          ),
          onPressed: () async {
            if (settingController.userModel.value.facebook!.isEmpty) {
              helperController.showToast(
                  title: "Sorry, author Facebook is not found.",
                  color: Colors.red);
              return;
            }
            await helperController
                .launchUrl(settingController.userModel.value.facebook!);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Image.asset('assets/images/whtsapp_icon.png'),
          onPressed: () async {
            if (settingController.userModel.value.phone!.isEmpty) {
              helperController.showToast(
                  title: "Sorry, author number is not found.",
                  color: Colors.red);
              return;
            }
            await helperController.launchWhatsapp(
                settingController.userModel.value.phone!, Constants.devMessage);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Icon(
            Icons.message_rounded,
            color: Colors.blue,
          ),
          onPressed: () async {
            if (settingController.userModel.value.phone!.isEmpty) {
              helperController.showToast(
                  title: "Sorry, author number is not found.",
                  color: Colors.red);
              return;
            }
            await helperController.launchSms(
                settingController.userModel.value.phone!, Constants.devMessage);
          },
          iconSize: 35,
        ),
        IconButton(
          icon: Image.asset('assets/images/telegram_icon.png'),
          onPressed: () async {
            if (settingController.userModel.value.telegram!.isEmpty) {
              helperController.showToast(
                  title: "Sorry, author number is not found.",
                  color: Colors.red);
              return;
            }
            await helperController
                .launchUrl(settingController.userModel.value.telegram!);
          },
          iconSize: 35,
        ),
      ],
    );
  }
}
