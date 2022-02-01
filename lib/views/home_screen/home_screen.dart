import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mula_jan_shayeri/controllers/auth_controller.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/about/about_screen.dart';
import 'package:mula_jan_shayeri/views/home_screen/home_menu.dart';
import 'package:mula_jan_shayeri/views/home_screen/nav_drawer.dart';
import 'package:mula_jan_shayeri/views/profile/full_screen_image.dart';
import 'package:mula_jan_shayeri/views/settings/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HelperController helperController = Get.find();
  SettingController settingController = Get.find();
  AuthController authController = Get.put(AuthController());
  TextEditingController bioTextController = new TextEditingController();
  TextEditingController nameTextController = new TextEditingController();
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
          () => Text(settingController.userModel.value.name ?? "Loading.."),
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
                  'Setting',
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Text(
                  'Share App',
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: size.height / 3,
                margin: EdgeInsets.only(left: 13, right: 13, top: 8),
                child: Stack(
                  children: [
                    //cover photo
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ShowFullScreenImage(
                                tag: "coverImage",
                                url: settingController.userModel.value.cover ??
                                    "",
                              ),
                            );
                          },
                          child: Hero(
                            tag: "coverImage",
                            child: Obx(
                              () => CachedNetworkImage(
                                height: size.height / 3.9,
                                width: size.width,
                                imageUrl:
                                    settingController.userModel.value.cover ??
                                        "",
                                imageBuilder: (context, image) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
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
                                      borderRadius: BorderRadius.circular(30),
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
                        Obx(
                          () => authController.currentUser.value != null
                              ? Positioned(
                                  right: -10,
                                  bottom: 5,
                                  child: MaterialButton(
                                    onPressed: () {
                                      _showBottomsheet(context, "cover");
                                    },
                                    color: Colors.white10.withOpacity(0.7),
                                    textColor: Colors.white,
                                    child: Icon(
                                      Icons.image_outlined,
                                      size: 19,
                                      color: Colors.black,
                                    ),
                                    shape: CircleBorder(),
                                    elevation: 0.5,
                                  ),
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                    // image photo
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: size.height / 4.6,
                              width: size.height / 4.6,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 5,
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ShowFullScreenImage(
                                      tag: "profileImage",
                                      url: settingController
                                              .userModel.value.image ??
                                          "",
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: "profileImage",
                                  child: Obx(
                                    () => CachedNetworkImage(
                                      imageUrl: settingController
                                              .userModel.value.image ??
                                          "",
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey[300],
                                        ),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/no_image.jpg",
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => authController.currentUser.value != null
                                  ? Positioned(
                                      right: size.height / 5 / 2 - 5,
                                      bottom: 0,
                                      child: MaterialButton(
                                        onPressed: () {
                                          _showBottomsheet(context, "image");
                                        },
                                        color: Colors.white10.withOpacity(0.9),
                                        textColor: Colors.white,
                                        child: Icon(
                                          Icons.image_outlined,
                                          size: 19,
                                          color: Colors.black,
                                        ),
                                        shape: CircleBorder(),
                                        elevation: 0.5,
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      authController.currentUser.value != null
                          ? InkWell(
                              onTap: () async {
                                if (settingController.isNameUpdate.value) {
                                  await saveUpdateName(nameTextController.text);
                                  settingController.isNameUpdate.value = false;

                                  return;
                                }
                                settingController.isNameUpdate.value = true;
                                nameTextController.text =
                                    settingController.userModel.value.name ??
                                        '';
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 5),
                                child: settingController.isNameUpdate.value
                                    ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.edit,
                                        color: Colors.grey[900],
                                      ),
                              ),
                            )
                          : SizedBox(),
                      Flexible(
                        child: !settingController.isNameUpdate.value
                            ? Text(
                                settingController.userModel.value.name ??
                                    'Loding..',
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : TextFormField(
                                // autofocus: false,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                controller: nameTextController,
                                onFieldSubmitted: (val) async {
                                  await saveUpdateName(val);
                                  settingController.isNameUpdate.value = false;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(
                        () => authController.currentUser.value != null
                            ? InkWell(
                                onTap: () async {
                                  if (settingController.isBioUpdate.value) {
                                    await settingController
                                        .saveUpdateBio(bioTextController.text);
                                    settingController.isBioUpdate.value = false;
                                    return;
                                  }
                                  settingController.isBioUpdate.value = true;
                                  bioTextController.text =
                                      settingController.userModel.value.bio!;
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: settingController.isBioUpdate.value
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.green,
                                        )
                                      : Icon(
                                          Icons.edit,
                                          color: Colors.grey[900],
                                        ),
                                ),
                              )
                            : SizedBox(),
                      ),
                      Flexible(
                        child: !settingController.isBioUpdate.value
                            ? Text(
                                settingController.userModel.value.bio ??
                                    'Loding..',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                ),
                              )
                            : TextFormField(
                                // autofocus: false,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                controller: bioTextController,
                                onFieldSubmitted: (val) async {
                                  await saveUpdateBio(val);
                                  settingController.isBioUpdate.value = false;
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
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

  _showBottomsheet(BuildContext buildContex, String type) {
    showModalBottomSheet(
      isScrollControlled: false,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      context: buildContex,
      builder: (context) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.camera),
              title: Text('Camera'),
              onTap: () async {
                Get.back();
                File file =
                    await helperController.pickFile(ImageSource.camera) as File;
                file = await helperController.cropImage(img: file);
                helperController.showLoadingDialog(title: 'Uploading Image..');
                String url = await helperController.uploadFile(
                    file: file, storageReffernece: 'profile_images/');

                Map<String, String> data = new Map();
                type == 'cover' ? data['cover'] = url : data['image'] = url;

                await updateUser(data);
                Get.back();
                await settingController.getUser();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.image,
              ),
              title: Text('Gallery'),
              onTap: () async {
                Get.back();
                File file = await helperController.pickFile(ImageSource.gallery)
                    as File;
                file = await helperController.cropImage(img: file);
                helperController.showLoadingDialog(title: 'Uploading Image..');
                String url = await helperController.uploadFile(
                    file: file, storageReffernece: 'profile_images');

                Map<String, String> data = new Map();
                data[type] = url;
                await updateUser(data);
                Get.back();
                await settingController.getUser();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.delete_outline,
              ),
              title: Text('Remove Image'),
              onTap: () async {
                Get.back();
                await removeImage(type);
                await settingController.getUser();
              },
            ),
          ],
        ),
      ),
    );
  }

  removeImage(String type) async {
    await settingController.removeImage(type).then((_) {
      helperController.showToast(title: "Removed successfully.");
    }).catchError((onError) {
      helperController.showToast(
          title: "Some error occured ${onError.toString()}.");
    });
  }

  updateUser(Map<String, String> data) {
    settingController.updateUser(data).then((value) {
      helperController.showToast(
        title: "Successfully created!",
        color: Colors.green,
      );
    }).catchError((onError) {
      helperController.showToast(
        title: "Error Occured. Please try again.",
        color: Colors.red,
      );
    });
  }

  settingsClicked(String val) async {
    switch (val) {
      case 'share':
        {
          await helperController.shareApp();
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

  Future<void> saveUpdateBio(String bio) async {
    await settingController.saveUpdateBio(bio).then((value) {
      helperController.showToast(title: 'Updated successfully');
    }).catchError((error) {
      helperController.showToast(title: 'Error occured. $error');
    });
  }

  Future<void> saveUpdateName(String name) async {
    await settingController.saveUpdateName(name).then((value) {
      helperController.showToast(title: 'Updated successfully');
    }).catchError((error) {
      helperController.showToast(title: 'Error occured. $error');
    });
  }
}
