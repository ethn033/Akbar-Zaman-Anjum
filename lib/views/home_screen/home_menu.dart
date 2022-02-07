import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/views/columns/columns_screen.dart';
import 'package:mula_jan_shayeri/views/gallery/gallery_screen.dart';
import 'package:mula_jan_shayeri/views/poetry/poetry_screen.dart';
import 'package:mula_jan_shayeri/views/profile/about_author_screen.dart';
import 'package:mula_jan_shayeri/views/books_screens/boooks_screen.dart';
import 'package:mula_jan_shayeri/views/about/social_contact_screen.dart';
import 'package:mula_jan_shayeri/views/partials/widgets.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    Key? key,
    required this.helperController,
  }) : super(key: key);

  final HelperController helperController;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.only(left: 10, right: 10),
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 1.0,
      children: [
        InkWell(
          onTap: () {
            Get.to(() => BioScreen());
          },
          child: HomeCard(
            title: "پیژندنه",
            icon: Icons.info_rounded,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => PoetryScreen());
          },
          child: HomeCard(
            title: "شاعري",
            icon: Icons.text_snippet_outlined,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => BooksScreen());
          },
          child: HomeCard(
            title: "کتابونه",
            icon: Icons.book,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => ColumnScreen());
          },
          child: HomeCard(
            title: "مقالې/ لیکنې",
            icon: Icons.link,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => SocialScreen());
          },
          child: HomeCard(
            title: "اړیکې",
            icon: Icons.link,
          ),
        ),
        InkWell(
          onTap: () {
            Get.to(() => AuthorGalleryScreen());
          },
          child: HomeCard(title: "ګالری", icon: Icons.image_rounded),
        ),
        InkWell(
          onTap: () {
            if (Platform.isAndroid) {
              helperController.showDialog(
                title: 'Exit App',
                middleText: 'Do you want to exit?',
                onPressedConfirm: () {
                  SystemNavigator.pop();
                },
              );
            }
          },
          child: HomeCard(
            title: "بند کړه",
            icon: Icons.exit_to_app,
          ),
        ),
      ],
    );
  }
}
