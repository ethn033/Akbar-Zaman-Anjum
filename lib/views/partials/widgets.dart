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
      elevation: 0.3,
      color: color.withOpacity(0.3),
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
          icon: Image.asset('assets/images/facebook_icon.png'),
          onPressed: () async {
            await helperController.launchUrl(Constants.devFbUrl);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Image.asset('assets/images/whatsapp_icon.png'),
          onPressed: () async {
            await helperController.launchWhatsapp(
                Constants.devPhone, Constants.devMessage);
          },
          iconSize: 40,
        ),
        IconButton(
          icon: Image.asset('assets/images/message_icon.png'),
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
  SocialContact({Key? key, required this.helperController}) : super(key: key);

  HelperController helperController;
  final SettingController settingController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(spacing: 8, runSpacing: 8, children: <Widget>[
          IconButton(
            icon: Image.asset('assets/images/facebook_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.facebook == null ||
                  settingController.userModel.value.facebook!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, author Facebook link is not found.",
                    color: Colors.red);
                return;
              }
              await helperController
                  .launchUrl(settingController.userModel.value.facebook!);
            },
            iconSize: 40,
          ),
          IconButton(
            icon: Image.asset('assets/images/youtube_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.youtube == null ||
                  settingController.userModel.value.youtube!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's Youtube link is not found.",
                    color: Colors.red);
                return;
              }
              await helperController
                  .launchUrl(settingController.userModel.value.youtube!);
            },
            iconSize: 40,
          ),
          IconButton(
            icon: Image.asset('assets/images/twitter_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.twitter == null ||
                  settingController.userModel.value.twitter!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's Twitter link is not found.",
                    color: Colors.red);
                return;
              }
              await helperController
                  .launchUrl(settingController.userModel.value.twitter!);
            },
            iconSize: 40,
          ),
          IconButton(
            icon: Image.asset('assets/images/whatsapp_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.phone == null ||
                  settingController.userModel.value.phone!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's Whatsapp is not found.",
                    color: Colors.red);
                return;
              }
              await helperController.launchWhatsapp(
                  settingController.userModel.value.phone!,
                  Constants.devMessage);
            },
            iconSize: 40,
          ),
          IconButton(
            icon: Image.asset('assets/images/message_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.phone == null ||
                  settingController.userModel.value.phone!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's number is not found.",
                    color: Colors.red);
                return;
              }
              await helperController.launchSms(
                  settingController.userModel.value.phone!,
                  Constants.devMessage);
            },
            iconSize: 35,
          ),
          IconButton(
            icon: Image.asset('assets/images/telegram_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.telegram == null ||
                  settingController.userModel.value.telegram!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's Telegram is not found.",
                    color: Colors.red);
                return;
              }
              await helperController
                  .launchUrl(settingController.userModel.value.telegram!);
            },
            iconSize: 35,
          ),
          IconButton(
            icon: Image.asset('assets/images/instagram_icon.png'),
            onPressed: () async {
              if (settingController.userModel.value.instagram == null ||
                  settingController.userModel.value.instagram!.isEmpty) {
                helperController.showToast(
                    title: "Sorry, Author's Instagram link is not found.",
                    color: Colors.red);
                return;
              }
              await helperController
                  .launchUrl(settingController.userModel.value.instagram!);
            },
            iconSize: 40,
          ),
          IconButton(
              icon: Image.asset('assets/images/tiktok_icon.png'),
              onPressed: () async {
                if (settingController.userModel.value.tiktok == null ||
                    settingController.userModel.value.tiktok!.isEmpty) {
                  helperController.showToast(
                      title: "Sorry, Author's Tiktok link is not found.",
                      color: Colors.red);
                  return;
                }
                await helperController
                    .launchUrl(settingController.userModel.value.tiktok!);
              },
              iconSize: 40)
        ])
      ],
    );
  }
}
