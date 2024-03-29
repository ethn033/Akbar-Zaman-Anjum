import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/controllers/widets_controller.dart';
import 'package:mula_jan_shayeri/views/home_screen/home_screen.dart';
import 'package:mula_jan_shayeri/views/settings/setting_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Settings.init(cacheProvider: SharePreferenceCache());

  if (Platform.isAndroid) {
    WebView.platform = SurfaceAndroidWebView();
  }

  Get.put(HelperController());
  Get.put(WidgetController());

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueChangeObserver<bool>(
      cacheKey: SettingScrreen.keyDarkMode,
      defaultValue: false,
      builder: (_, isDarkMood, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Akbar Zaman Anjum",
        theme: !isDarkMood
            ? ThemeData(
                outlinedButtonTheme: OutlinedButtonThemeData(
                  style: OutlinedButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                ),
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle.light,
                  backgroundColor: Colors.white,
                  actionsIconTheme: IconThemeData(color: Colors.black),
                  elevation: 0,
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  ),
                  foregroundColor: Colors.black,
                  shadowColor: Colors.red,
                ),
              )
            : ThemeData(
                primaryColor: Colors.black,
                primaryColorBrightness: Brightness.dark,
                primaryColorLight: Colors.black,
                brightness: Brightness.dark,
                primaryColorDark: Colors.black,
                indicatorColor: Colors.white,
                canvasColor: Colors.black,
                // next line is important!
                appBarTheme: AppBarTheme(
                    backgroundColor: Colors.black87,
                    foregroundColor: Colors.white),
              ),
        home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.connectionState == ConnectionState.done) {
              Get.put(SettingController());
              return HomeScreen();
            }
            return Center(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
