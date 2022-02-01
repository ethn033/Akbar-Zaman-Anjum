// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';

class ShowFullScreenImage extends StatelessWidget {
  String tag, url;
  ShowFullScreenImage({Key? key, required this.tag, required this.url})
      : super(key: key);
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await helperController.downloadFile(url);
                        },
                        padding: EdgeInsets.all(16),
                        icon: Icon(
                          Icons.download,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Hero(
                      tag: tag,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: url,
                        placeholder: (context, url) => Container(
                          color: Colors.grey,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.grey[400],
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            tag == "profileImage"
                                ? "assets/images/no_image.jpg"
                                : "assets/images/no_image_found.png",
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
