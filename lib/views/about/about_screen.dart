// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';
import 'package:mula_jan_shayeri/controllers/setting_controller.dart';
import 'package:mula_jan_shayeri/views/partials/widgets.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({Key? key}) : super(key: key);
  SettingController settingController = Get.find();
  HelperController helperController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            textDirection: TextDirection.rtl,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: size.height / 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 10,
                  ),
                ),
                child: Image.asset('assets/images/dev_image.png'),
              ),
              Text(
                'د پښتو ادبیاتو ایپ',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ContactUs(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text(
                  'پښتو ادبي کاریال د شاعرانو او ليکوالانو لپاره ساز کړے شوے دے چرته چې شاعران او اديبان خپل ليکل، کالمونه، شاعري او کتابونه د نړۍ ګوټ ګوټ ته په آسانه رسولي شي. د دې اپلیکیشن سره به ستاسو لیکنې، شعرونه، کتابونه او ټول هغه ادبيات چې تاسو جوړ کړئ د تل لپاره به خوندي شي. د کاریال خصوصيات لاندني دې:',
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '1: کټګورۍ جوړې کړئ:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'څومره چې تاسو غواړئ کټګورۍ جوړ کړئ. دا کټګورۍ حذف کیدی شي. بیا تاسو کولی شئ په اړونده کټګوریو کې ډیری شعرونه واچوئ.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '2: خپل کتابونه له نړۍ سره شریک کړئ:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'د پښتو ادبیاتو نړیوال اپلیکیشن سره، تاسو کولی شئ خپل خپل یا ستاسو د خوښې pdf کتابونه له نړۍ سره شریک کړئ. تاسو کولی شئ د خپلو مینه والو سره لامحدود کتابونه اپلوډ کړئ او دوی به وکولی شي دا د غوښتنلیک له لارې ولولي یا وروسته ډاونلوډ کړي. دوی کولی شي ستاسو کتابونه له نورو سره شریک کړي.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '3: ستاسو په اړه پاڼه:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'د دې غوښتنلیک سره، تاسو د خپل ځان په اړه د یو څه شریکولو په کنټرول کې یاست. پدې اپلیکیشن کې ، تاسو یوه پاڼه ترلاسه کوئ چې ستاسو په اړه هرڅه وايي. تاسو کولی شئ دا هر وخت تازه کړئ ترڅو ستاسو په اړه د خپلو مینه والو سره شریک کړئ.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '4: د پروفایل پاڼه:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'ایپ د پروفایل برخه لري کوم چې تاسو کولی شئ کنټرول کړئ ترڅو خپل پروفایل تازه وساتئ. تاسو کولی شئ د خپل پروفایل عکس یا پوښ عکس اپلوډ کړئ او کله چې تاسو وغواړئ حذف یې کړئ.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '۵: د ګالری پاڼه:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'دا اپلیکیشن تاسو ته د ښکلي ګالري سکرین چمتو کوي چیرې چې تاسو کولی شئ خپلې ښکلې شیبې خوندي کړئ او ستاسو مینه وال به وکولی شي دا شیبې وګوري.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '6: ستاسو د ټولنیزو اړیکو پاڼه:',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'خپل مینه وال له تاسو سره وصل وساتئ. دلته د ټولنیز تماس سکرین شتون لري چیرې چې تاسو کولی شئ له خپلو مینه والو سره وصل شئ.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'ایا تاسو غواړئ اپلیکیشن د خپل نوم سره په Play Store کې اپلوډ کړئ؟ که هو، مهرباني وکړئ موږ سره اړیکه ونیسئ.',
                  textDirection: TextDirection.rtl,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ContactUs(),
            ],
          ),
        ),
      ),
    );
  }
}
