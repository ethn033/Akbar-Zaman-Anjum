// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/views/about/about_screen.dart';
import 'package:mula_jan_shayeri/views/auth/login_screen.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';
import 'package:package_info/package_info.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({Key? key, required this.auth, required this.setting})
      : super(key: key);

  AuthController auth;
  SettingController setting;
  HelperController helperController = Get.find();
  WidgetController widgetsController = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.all(0),
            child: GestureDetector(
              onTap: () {
                Get.back();
                Get.to(
                  () => ShowFullScreenImage(
                    tag: "coverImage",
                    url: setting.userModel.value.cover ?? "",
                  ),
                );
              },
              child: Hero(
                tag: "coverImage",
                child: Obx(
                  () => CachedNetworkImage(
                    height: size.height / 3.9,
                    width: size.width,
                    imageUrl: setting.userModel.value.cover ?? "",
                    imageBuilder: (context, image) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey[300],
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey[400],
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) {
                      return Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/no_image_found.png",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 15),
              child: FutureBuilder(
                future: helperController.getPackageInfo(),
                builder: (context, AsyncSnapshot<PackageInfo?> packageInfo) {
                  if (packageInfo.connectionState != ConnectionState.done) {
                    return Text('Loading..');
                  }
                  return Text(
                    'Version ${packageInfo.data!.version}',
                    style: TextStyle(fontSize: 12),
                  );
                },
              )),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Application",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.favorite),
            title: Text('Favourite Poetry'),
            onTap: () async {
              Navigator.pop(context);
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Communication",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => ListTile(
              dense: true,
              leading: auth.currentUser.value == null
                  ? Icon(Icons.login)
                  : Icon(Icons.logout),
              title: auth.currentUser.value == null
                  ? Text('Login')
                  : Text('Logout'),
              onTap: () async {
                Navigator.pop(context);
                auth.currentUser.value == null
                    ? Get.to(
                        () => LoginScreen(),
                      )
                    : auth.logoutUser();
              },
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.share),
            title: Text('Share App'),
            onTap: () async {
              Get.back();
              await helperController.shareApp();
            },
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            dense: true,
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            onTap: () async {
              Get.back();
              Get.defaultDialog(
                barrierDismissible: false,
                title: 'Pashto Literature App',
                cancel: widgetsController.button(
                  label: 'Close',
                  width: double.minPositive,
                  onPressed: () async {
                    Get.back();
                  },
                ),
                content: Container(
                  width: size.width,
                  height: size.height - 300,
                  child: WebView(
                    initialUrl: 'assets/html/privacy_policy.html',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated:
                        (WebViewController webViewController) async {
                      String fileText = await rootBundle
                          .loadString('assets/html/privacy_policy.html');
                      webViewController.loadUrl(
                        Uri.dataFromString(
                          fileText,
                          mimeType: 'text/html',
                          encoding: Encoding.getByName('utf-8'),
                        ).toString(),
                      );
                    },
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                    },
                  ),
                ),
              );
            },
          ),
          ListTile(
            dense: true,
            leading: Icon(
              Icons.info_outline_rounded,
            ),
            title: Text('About Us'),
            onTap: () async {
              Get.back();
              Get.to(() => AboutScreen());
            },
          ),
        ],
      ),
    );
  }
}
