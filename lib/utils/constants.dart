import 'package:flutter/material.dart';
import 'package:mula_jan_shayeri/models/hashtag_model.dart';

class Constants {
  static const String MY_PREFS = "my_prefs";
  //storage refs
  static const String STORAGE_PROFILE_IMAGES = 'profile_images';
  static const String STORAGE_CATEGORY_IMAGES = 'category_images';
  static const String STORAGE_BOOKS = 'books';

  //user prof
  static const String name = "نيازګل ملاجان";
  static const String email = "youremail@email.com";
  static const String phone = "0340-486xxxxx";
  static const String password = "password";
  static const String address = "Your Address";
  static const String image = "assets/images/profile.jpg";
  static const String cover = "assets/images/cover.jpg";
  static const String facebook = "https://www.facebook.com/profile.php";
  static const String telegram = "https://www.facebook.com/profile.php";
  static const String tiktok = "https://www.facebook.com/profile.php";
  static const String instagram = "https://www.facebook.com/profile.php";
  static const String bio = "د اکبر زمان انجام په اړه ليکل...";

  //default urls
  static const String pdfThumbnail =
      "https://www.nicepng.com/png/detail/35-354814_book-sale-order-form-pdf-icon-png.png";
  static const String categoryThumbnail =
      "https://www.nicepng.com/png/detail/35-354814_book-sale-order-form-pdf-icon-png.png";
  static const String no_image =
      "https://jorgeraziel.com/wp-content/themes/consultix/images/no-image-found-360x260.png";

  //colors
  static List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.amberAccent,
    Colors.indigo,
    Colors.purple,
    Colors.amber,
    Colors.cyanAccent,
    Colors.brown,
    Colors.lime,
    Colors.pink,
    Colors.red,
    Colors.teal,
    Colors.black,
    Colors.yellow
  ];
  //hashtags
  static List<HashtagModel> hashtags = [
    HashtagModel.createTag(
      id: '',
      tag: '#مینه',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#ښکلی',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#جانان',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#درد',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#تهمت',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#بیلتون',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#تصور',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#ژوندون',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#هجران',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#احساس',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#دیدن',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#هیواد',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#یادونه',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#ساقي',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#میخانه',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#سترګې',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#سوله',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#نوی_کال',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#مسافري',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#کلي',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#مازیګر',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
    HashtagModel.createTag(
      id: '',
      tag: '#مور_او_پلار',
      disabled: false,
      date_created: DateTime.now().millisecondsSinceEpoch,
    ),
  ];

  // dev info
  static const String devName = 'Seelai Inc.';
  static const String devFbUrl = 'https://www.facebook.com/seelolewanai';
  static const String devTeliUrl = 'https://t.me/seeloinc';
  static const String devPhone = '+923458001499';
  static const String devMessage =
      'Hi there!\nIs there anyone who can assist me?';
}
