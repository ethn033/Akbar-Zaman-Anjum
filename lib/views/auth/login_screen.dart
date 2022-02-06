// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  TextEditingController emailTextController = new TextEditingController();
  TextEditingController passwordtextController = new TextEditingController();
  WidgetController widgetController = Get.find();
  AuthController authController = Get.find();
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                height: size.height / 6,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 5,
                    ),
                  ),
                  child: Obx(
                    () => CachedNetworkImage(
                      imageUrl: settingController.userModel.value.image ?? "",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/no_image.jpg",
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Login Form",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    "دا یوازې د دې اپلیکیشن لیکوال / شاعر / مالک لپاره د ننوتلو سکرین دی. تاسو باید ننوتل مه کوئ که تاسو د دې اپلیکیشن مالک نه یاست. مننه",
                  ),
                ),
              ),
              TextFormField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter email",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordtextController,
                obscureText: true,
                enableSuggestions: false,
                obscuringCharacter: "*",
                autocorrect: false,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter password",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              widgetController.buttonWithIcon(
                onPressed: () async {
                  if (authController.loading.value) {
                    return;
                  }
                  if (emailTextController.text.toLowerCase().trim().isEmpty ||
                      passwordtextController.text.trim().isEmpty ||
                      passwordtextController.text.trim().length < 7) {
                    return;
                  }
                  await authController
                      .signInUser(emailTextController.text.toLowerCase().trim(),
                          passwordtextController.text.trim())
                      .then((UserCredential? user) {
                    helperController.showToast(
                        title: 'Signed in successfully.', color: Colors.green);
                    authController.currentUser.value = user!.user;
                    authController.loading.value = false;
                    Get.back();
                  }).catchError((onError) {
                    helperController.showToast(
                        title: 'Error occured $onError', color: Colors.red);
                    authController.loading.value = false;
                  });
                },
                icon: Obx(
                  () => authController.loading.value
                      ? SizedBox(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                          height: 10.0,
                          width: 10.0,
                        )
                      : Icon(Icons.login),
                ),
                label: "login",
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
