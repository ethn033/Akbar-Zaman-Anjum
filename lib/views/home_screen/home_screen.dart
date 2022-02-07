import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/about/about_screen.dart';
import 'package:mula_jan_shayeri/views/home_screen/bio_widget.dart';
import 'package:mula_jan_shayeri/views/home_screen/cover_widget.dart';
import 'package:mula_jan_shayeri/views/home_screen/home_menu.dart';
import 'package:mula_jan_shayeri/views/home_screen/image_widget.dart';
import 'package:mula_jan_shayeri/views/home_screen/nav_drawer.dart';
import 'package:mula_jan_shayeri/views/settings/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HelperController helperController = Get.find();
  SettingController settingController = Get.find();
  AuthController authController = Get.put(AuthController());

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(settingController.userModel.value.name ?? "..Loading"),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.settings,
            ),
            onSelected: (String val) => settingsClicked(val),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'setting',
                child: Text(
                  'Settings',
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Text(
                  'Share App',
                ),
              ),
              PopupMenuItem(
                value: 'rateus',
                child: Text(
                  'Rate Us',
                ),
              ),
              PopupMenuItem(
                value: 'about',
                child: Text(
                  'About Us',
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: size.height / 3,
                margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Stack(
                  children: [
                    //cover photo
                    CoverWidget(
                      size: size,
                      helperController: helperController,
                      settingController: settingController,
                      authController: authController,
                    ),
                    // image photo
                    ImageWidget(
                      size: size,
                      helperController: helperController,
                      settingController: settingController,
                      authController: authController,
                    ),
                  ],
                ),
              ),
              Obx(
                () => Flexible(
                    child: Text(
                  settingController.userModel.value.name ?? 'Loding..',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              BioWidget(settingController: settingController),
              SizedBox(
                height: 15,
              ),
              HomeMenu(helperController: helperController),
            ],
          ),
        ),
      ),
      drawer: NavDrawer(auth: authController, setting: settingController),
    );
  }

  settingsClicked(String val) async {
    switch (val) {
      case 'share':
        {
          await helperController.shareApp();
          break;
        }
      case 'rateus':
        {
          await helperController.rateUs();
          break;
        }
      case 'about':
        {
          Get.to(() => AboutScreen());
          break;
        }
      case 'setting':
        {
          Get.to(() => SettingScrreen());
          break;
        }
      default:
        break;
    }
  }
}
