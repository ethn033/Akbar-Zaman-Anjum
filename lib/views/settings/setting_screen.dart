// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/about/about_screen.dart';
import 'package:mula_jan_shayeri/views/auth/login_screen.dart';

class SettingScrreen extends StatelessWidget {
  SettingScrreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  AuthController authController = Get.find();

  static const keyName = 'name-key';
  static const keyBio = 'bio-key';
  static const keyPhone = 'phone-key';
  static const keyAddress = 'address-key';
  static const keyAbout = 'about-key';
  static const keyFeebdack = 'feedback-key';
  static const keyIdFeebdack = 'feedback-id-key';
  static const keyDarkMode = 'dark-mode-key';

  //social media enabled keys
  static const keyEnableFacebook = 'enable-facebook-key';
  static const keyEnableInstagram = 'enable-instagram-key';
  static const keyEnableTelegram = 'enable-telegram-key';
  static const keyEnableTiktok = 'enable-tiktok-key';
  static const keyEnableYoutube = 'enable-youtube-key';
  static const keyEnableTwitter = 'enable-twitter-key';

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
                            settingController.userModel.value.image ?? ""),
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
                                await settingController
                                    .saveUpdateName(val)
                                    .then(
                                      (value) => helperController.showToast(
                                          title: 'Saved sucessfully.'),
                                    );
                              },
                            ),
                          ),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Status message',
                              settingKey: keyBio,
                              initialValue:
                                  settingController.userModel.value.bio ?? '',
                              onChange: (val) async {
                                await settingController.saveUpdateBio(val).then(
                                    (value) => helperController.showToast(
                                        title: 'Saved sucessfully.'));
                              },
                            ),
                          ),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'About',
                              settingKey: keyAbout,
                              keyboardType: TextInputType.name,
                              initialValue:
                                  settingController.userModel.value.about ?? '',
                              onChange: (val) async {
                                await settingController
                                    .saveUpdateAbout(val)
                                    .then(
                                      (value) => helperController.showToast(
                                          title: 'Saved sucessfully.'),
                                    );
                              },
                            ),
                          ),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Phone Number',
                              settingKey: keyPhone,
                              keyboardType: TextInputType.phone,
                              initialValue:
                                  settingController.userModel.value.phone ?? '',
                              onChange: (val) async {
                                await settingController
                                    .saveUpdatePhone(val)
                                    .then(
                                      (value) => helperController.showToast(
                                          title: 'Saved sucessfully.'),
                                    );
                              },
                            ),
                          ),
                          Obx(
                            () => TextInputSettingsTile(
                              title: 'Address',
                              settingKey: keyAddress,
                              keyboardType: TextInputType.text,
                              initialValue:
                                  settingController.userModel.value.address ??
                                      '',
                              onChange: (val) async {
                                await settingController
                                    .saveUpdateAddress(val)
                                    .then(
                                      (value) => helperController.showToast(
                                          title: 'Saved sucessfully.'),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SimpleSettingsTile(
                      title: 'Tiles Setting',
                      subtitle: 'Home screen tiles',
                      leading: Container(
                          padding: EdgeInsets.all(9),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.purple),
                          child: Icon(
                            Icons.dashboard,
                            color: Colors.white,
                          )),
                      child: SettingsScreen(
                        title: 'Tiles Setting',
                        children: [],
                      ),
                    ),
                    // ExpandableSettingsTile(
                    //   title: 'Social Media Links',
                    //   subtitle: 'Set links of your social media accounts',
                    //   leading: Container(
                    //     padding: EdgeInsets.all(9),
                    //     decoration: BoxDecoration(
                    //       shape: BoxShape.circle,
                    //       color: Colors.blue,
                    //     ),
                    //     child: Icon(
                    //       Icons.social_distance,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   children: <Widget>[
                    //     SwitchSettingsTile(
                    //       settingKey: keyEnableFacebook,
                    //       title: 'Facebook',
                    //       enabledLabel: 'Enabled',
                    //       disabledLabel: 'Disabled',
                    //       leading: Icon(Icons.facebook),
                    //       onChange: (val) {},
                    //     ),
                    //     SwitchSettingsTile(
                    //       settingKey: keyEnableTwitter,
                    //       title: 'Twitter',
                    //       enabledLabel: 'Enabled',
                    //       disabledLabel: 'Disabled',
                    //       leading: Container(
                    //           height: 20,
                    //           width: 20,
                    //           clipBehavior: Clip.hardEdge,
                    //           padding: EdgeInsets.all(1),
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: Colors.blue,
                    //           ),
                    //           child: Image.asset(
                    //             'assets/images/twitter_icon.png',
                    //             fit: BoxFit.fill,
                    //           )),
                    //       onChange: (val) {},
                    //     ),
                    //   ],
                    // ),
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
            SettingsGroup(title: 'Security', children: [
              Obx(
                () => SimpleSettingsTile(
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
                      child: Icon(
                        Icons.logout,
                        color: Colors.white,
                      )),
                  onTap: () async {
                    authController.currentUser.value != null
                        ? await logoutUser()
                        : Get.to(() => LoginScreen());
                  },
                ),
              ),
            ]),
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
                                title: 'Feedback updated successfully.');
                          });
                          return;
                        }
                        String? key =
                            await settingController.saveFeedback(feedback);
                        if (key != '') {
                          await Settings.setValue<String>(keyIdFeebdack, key);
                          helperController.showToast(
                              title: 'Feedback saved successfully.');
                        }
                      },
                    )
                  ],
                ),
              ),
            ])
          ]),
    );
  }

  Future logoutUser() async {
    await authController.logoutUser().then((value) {
      helperController.showToast(title: "Account logged out successfully.");
    }).catchError((error) {
      helperController.showToast(title: "Some error occured $error.");
    });
  }
}
