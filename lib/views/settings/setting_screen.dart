// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/about/about_screen.dart';
import 'package:mula_jan_shayeri/views/auth/login_screen.dart';
import 'package:mula_jan_shayeri/views/create_screens/create_about.dart';
import 'package:mula_jan_shayeri/views/references/asset_reference.dart';

class SettingScrreen extends StatelessWidget {
  SettingScrreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();
  late quill.QuillController quillController;
  TextEditingController bioTextController = new TextEditingController();
  TextEditingController facebookTextController = new TextEditingController();
  TextEditingController twitterTextController = new TextEditingController();
  TextEditingController youtubeTextController = new TextEditingController();
  TextEditingController tiktokTextController = new TextEditingController();
  TextEditingController instagramTextController = new TextEditingController();
  TextEditingController telegramTextController = new TextEditingController();
  TextEditingController phoneTextController = new TextEditingController();

  static const keyName = 'name-key';
  static const keyPhone = 'phone-key';
  static const keyAddress = 'address-key';
  static const keyAbout = 'about-key';
  static const keyFeebdack = 'feedback-key';
  static const keyIdFeebdack = 'feedback-id-key';
  static const keyDarkMode = 'dark-mode-key';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: ListView(
          padding: EdgeInsets.only(
            left: 15,
            right: 18,
          ),
          children: [
            Obx(() => authController.currentUser.value != null
                ? SettingsGroup(title: 'Genral Settings', children: [
                    SimpleSettingsTile(
                      title: 'Account Settings',
                      subtitle: 'Name, Status message, About',
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          settingController.userModel.value.image ?? "",
                        ),
                      ),
                      child: SettingsScreen(
                        title: 'Account Settings',
                        children: [
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Account name',
                              settingKey: keyName,
                              keyboardType: TextInputType.name,
                              initialValue:
                                  settingController.userModel.value.name ?? '',
                              onChange: (val) async {
                                await settingController.updateUser(
                                    data: {'name': val},
                                    helperController: helperController);
                              },
                            ),
                          ),
                          Divider(),
                          ListTile(
                            onTap: () async =>
                                await helperController.showDialog(
                              title: 'Status message',
                              middleText: 'Update status message',
                              content: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextFormField(
                                  enabled: true,
                                  onChanged: (val) {
                                    bioTextController.text = val;
                                  },
                                  maxLines: 3,
                                  autofocus: true,
                                  initialValue:
                                      settingController.userModel.value.bio ??
                                          '',
                                  decoration: InputDecoration(
                                    hintText: 'Enter status message',
                                    border: OutlineInputBorder(),
                                    labelText: "Enter email",
                                  ),
                                ),
                              ),
                              onPressedConfirm: () async {
                                Get.back();
                                await helperController.showLoadingDialog(
                                    title: 'Saving..');
                                await settingController.updateUser(
                                    helperController: helperController,
                                    data: {
                                      'bio': bioTextController.text.trim()
                                    });
                                Get.back();
                              },
                            ),
                            title: Text(
                              'Status Text',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Obx(() => Text(
                                  settingController.userModel.value.bio ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          Divider(),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Phone Number',
                              settingKey: keyPhone,
                              keyboardType: TextInputType.phone,
                              initialValue:
                                  settingController.userModel.value.phone ?? '',
                              onChange: (val) async {
                                await settingController.updateUser(
                                    data: {'phone': val},
                                    helperController: helperController);
                              },
                            ),
                          ),
                          Divider(),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Address',
                              settingKey: keyAddress,
                              keyboardType: TextInputType.text,
                              initialValue:
                                  settingController.userModel.value.address ??
                                      '',
                              onChange: (val) async {
                                await settingController.updateUser(
                                    data: {'address': val},
                                    helperController: helperController);
                              },
                            ),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'About',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            subtitle: Obx(() {
                              if (settingController.userModel.value.about !=
                                      null &&
                                  settingController.userModel.value.about !=
                                      '') {
                                quillController = new quill.QuillController(
                                  document: quill.Document.fromJson(
                                    jsonDecode(settingController
                                        .userModel.value.about!),
                                  ),
                                  selection: TextSelection.collapsed(offset: 0),
                                );
                              } else {
                                quillController =
                                    new quill.QuillController.basic();
                              }

                              return Text(
                                  quillController.document.toPlainText(),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis);
                            }),
                            onTap: () {
                              Get.to(() => CreateAboutScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                    Obx(() => authController.currentUser.value != null
                        ? SimpleSettingsTile(
                            title: 'Social Links',
                            subtitle: 'Add your social links',
                            leading: CircleAvatar(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                    'assets/images/social_icon.png'),
                              ),
                              backgroundColor: Colors.amber,
                            ),
                            child: SettingsScreen(
                              title: 'Social links',
                              children: [
                                ListTile(
                                  title: Text('Whatsapp Number'),
                                  leading: CircleAvatar(
                                    child: Image.asset(
                                        'assets/images/whatsapp_icon.png'),
                                    backgroundColor: Colors.white,
                                  ),
                                  subtitle: Obx(() =>
                                      settingController.userModel.value.phone !=
                                                  null &&
                                              settingController
                                                      .userModel.value.phone !=
                                                  ''
                                          ? Text(settingController
                                              .userModel.value.phone!)
                                          : Text('No whatsapp provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Whatsapp number',
                                    middleText: 'Update Whatsapp number',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        phoneTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.phone ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter whatsapp number',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Whatsapp number",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'phone':
                                                phoneTextController.text.trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Facebook Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                          'assets/images/facebook_icon.png'),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.facebook !=
                                              null &&
                                          settingController
                                                  .userModel.value.facebook !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.facebook!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Facebook link',
                                    middleText: 'Update Facebook link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        facebookTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.facebook ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter facebook link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Facebook link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'facebook': facebookTextController
                                                .text
                                                .trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Twitter Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                          'assets/images/twitter_icon.png'),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.twitter !=
                                              null &&
                                          settingController
                                                  .userModel.value.twitter !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.twitter!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Twitter link',
                                    middleText: 'Update Twitter link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        twitterTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.twitter ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter twitter link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Twitter link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'twitter': twitterTextController
                                                .text
                                                .trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Telegram Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                          'assets/images/telegram_icon.png'),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.telegram !=
                                              null &&
                                          settingController
                                                  .userModel.value.telegram !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.telegram!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Telegram link',
                                    middleText: 'Update Telegram link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        telegramTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.telegram ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter telegram link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Telegram link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'telegram': twitterTextController
                                                .text
                                                .trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Instagram Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                          'assets/images/instagram_icon.png'),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.instagram !=
                                              null &&
                                          settingController
                                                  .userModel.value.instagram !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.instagram!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Instagram link',
                                    middleText: 'Update Instagram link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        instagramTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.instagram ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter instagram link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Intstagram link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'instagram': instagramTextController
                                                .text
                                                .trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Youtube Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                        'assets/images/youtube_icon.png',
                                      ),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.youtube !=
                                              null &&
                                          settingController
                                                  .userModel.value.youtube !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.youtube!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Youtube link',
                                    middleText: 'Update Youtube link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        youtubeTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.youtube ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter youtube link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Youtube link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'youtube': youtubeTextController
                                                .text
                                                .trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: Text('Tiktok Link'),
                                  leading: CircleAvatar(
                                      child: Image.asset(
                                          'assets/images/tiktok_icon.png'),
                                      backgroundColor: Colors.white),
                                  subtitle: Obx(() => settingController
                                                  .userModel.value.tiktok !=
                                              null &&
                                          settingController
                                                  .userModel.value.tiktok !=
                                              ''
                                      ? Text(settingController
                                          .userModel.value.tiktok!)
                                      : Text('No link provided.')),
                                  onTap: () async =>
                                      await helperController.showDialog(
                                    title: 'Tiktok link',
                                    middleText: 'Update Tiktok link',
                                    content: TextFormField(
                                      enabled: true,
                                      onChanged: (val) {
                                        tiktokTextController.text = val;
                                      },
                                      maxLines: 1,
                                      autofocus: false,
                                      initialValue: settingController
                                              .userModel.value.tiktok ??
                                          '',
                                      decoration: InputDecoration(
                                        hintText: 'Enter tiktok link',
                                        border: OutlineInputBorder(),
                                        labelText: "Enter Tiktok link",
                                      ),
                                    ),
                                    onPressedConfirm: () async {
                                      Get.back();
                                      await helperController.showLoadingDialog(
                                          title: 'Saving..');
                                      await settingController.updateUser(
                                          helperController: helperController,
                                          data: {
                                            'tiktok':
                                                tiktokTextController.text.trim()
                                          });
                                      Get.back();
                                    },
                                  ),
                                ),
                                IconReferences(
                                    helperController: helperController)
                              ],
                            ),
                          )
                        : SizedBox()),
                  ])
                : SizedBox()),
            SettingsGroup(
              title: 'Application Theme',
              children: [
                SwitchSettingsTile(
                  title: 'Dark Mode',
                  settingKey: keyDarkMode,
                  leading: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                      )),
                  enabledLabel: 'Enabled',
                  disabledLabel: 'Disabled',
                )
              ],
            ),
            SettingsGroup(title: 'Communication', children: [
              SimpleSettingsTile(
                title: 'Contact Us',
                subtitle: 'Reach us using our social accounts',
                leading: Container(
                  padding: EdgeInsets.all(9),
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.lime),
                  child: Icon(Icons.contact_page, color: Colors.white),
                ),
                onTap: () => Get.to(() => AboutScreen()),
              ),
              SimpleSettingsTile(
                title: 'Feedback',
                subtitle: 'Send us your valueable feedback.',
                leading: Container(
                  padding: EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: Icon(Icons.feedback, color: Colors.white),
                ),
                child: SettingsScreen(
                  title: 'Feedback',
                  children: [
                    TextInputSettingsTile(
                      keyboardType: TextInputType.text,
                      title: 'Write your feedback here',
                      validator: (val) {
                        if (val != null && val.length > 20) {
                          return null;
                        }
                        return "Please write a proper feedback.";
                      },
                      borderColor: Colors.blueAccent,
                      errorColor: Colors.deepOrangeAccent,
                      settingKey: keyFeebdack,
                      initialValue: 'Your feedback appears here.',
                      onChange: (feedback) async {
                        String feedbackId =
                            Settings.getValue<String>(keyIdFeebdack, '');

                        print('key = $feedbackId');
                        if (feedbackId != '') {
                          await settingController
                              .updateFeedback(feedbackId, feedback)
                              .then((_) {
                            helperController.showToast(
                                title: 'Feedback updated successfully.',
                                color: Colors.green);
                          });
                          return;
                        }
                        String? key =
                            await settingController.saveFeedback(feedback);
                        if (key != '') {
                          await Settings.setValue<String>(keyIdFeebdack, key);
                          helperController.showToast(
                              title: 'Feedback saved successfully.',
                              color: Colors.green);
                        }
                      },
                    )
                  ],
                ),
              ),
            ]),
            SettingsGroup(title: 'Account', children: [
              Obx(() => SimpleSettingsTile(
                  title: authController.currentUser.value != null
                      ? 'Logout'
                      : 'Login',
                  subtitle: authController.currentUser.value != null
                      ? 'Logout of your account'
                      : 'Login to Your account',
                  leading: Container(
                      padding: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: authController.currentUser.value != null
                              ? Colors.red
                              : Colors.green),
                      child: Icon(Icons.logout, color: Colors.white)),
                  onTap: () async {
                    if (authController.currentUser.value != null) {
                      await helperController.showLoadingDialog(
                          title: 'Logging out..');
                      await logoutUser();
                      helperController.hideLoadingDialog();
                    } else {
                      Get.to(() => LoginScreen());
                    }
                  }))
            ])
          ]),
    );
  }

  Future logoutUser() async {
    await authController.logoutUser().then((value) {
      helperController.showToast(
          title: "Account logged out successfully.", color: Colors.green);
    }).catchError((error) {
      helperController.showToast(
          title: "Some error occured $error.", color: Colors.red);
    });
  }
}
