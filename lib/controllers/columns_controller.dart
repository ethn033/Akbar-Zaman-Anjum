// ignore_for_file: unnecessary_cast, unnecessary_statements, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/models/column_model.dart';

class ColumnsController extends GetxController {
  CollectionReference refColumns =
      FirebaseFirestore.instance.collection("columns");

  List<ColumnModel> columns = List<ColumnModel>.empty(growable: true).obs;
  RxBool no_columns = false.obs;
  RxBool uploading = false.obs;
  RxBool deleting = false.obs;
  RxBool can_copy_column = true.obs;
  RxBool can_share_column = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getColumns();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getColumns() async {
//     var mod = new ColumnModel.createColumn(
//       column_text: '''
//      په ټوليزه توگه د پښتو ادب د ادبپوهانو په اند په دوه برخو کې ويشل شوی دی. يعنې شفاهي يا گړنی ادب او بل ليکلی يا تحريري ادب. گړنی ادب بيا يوه برخه د پښتو زړې سندرې دي چې شاعر ېې نامالوم وي. او بله برخه اولسي سندرې دي چې شاعران ېې مالوم وي.

// لنډۍ ، ټپه ، کاکړۍ غاړې، لنډکۍ، سروکی (مسريزه)، نارې، فالونه، چغيان (اننکی)، يادهوي سندرې، ساندې، نکلونه، متلونه، د سيندو سندرې، د ماشومانو ادبيات لکه اکو بکو، چاربيته ، کيسی چی د ذهني ازموينی په غرض ويل کيږي. همدارنگه ځينی کيسې لکه انگک بنگک ، سرکۍ وزه او نورې د پښتو د شفاهي ادب نمونی دي.

// ليکلی ادب: لکه بوللـه، خوابنامه، الفنامه، ساقي نامه، رباعي، مثنوي، غزل، مناجات، حمد، نعت او اوسنۍ هايکو.

// د پښتو د ليکلي ادب څيړنه له دوهمې هجرۍ پيړۍ د امير کروړ سوري له وياړنې څخه پيل کيږي.ږ چې په 139 هجرۍ سپوږميز کال ېې ويلې ده. همغه شان د پښتو انشا لرغونی نمونه همدا وياړنه گڼل کيږي.

// د پښتو ژبی املا څيړنه بيا د 612 هجرۍ د سليمان ماکو له تذکرۀ الاوليا څخه کيږي. د پير روښان خيرالبيان، د اخون درويزه مخزن الاسلام، د خوشال خان خټک دستار نامه، د ملا مست سلوک الغزا د خپلو خپلو ځانگړنو سره د خپل خپل پير غوره نمونې گڼل کېږي.

// د پښتو لمړی گرامر په 1195 هجري کال د معرفته الافغان کتاب وو چې د نوميالي شاعر او ليکوال پير محمد کاکړ تاليف دی - گڼل کيږي چې وروسته دغه لړۍ تر اوسه روانه ده.

// د پښتو ژبې لومړی لاس ته راغلې قصيده د اسعد سوري قصيده ده چې په 425 هجري کال ويل شوې ده. که څه هم ويل کيږي چې په داريايي ادب پهلوي ادب کې قصيدې ته وورته شعري جوړښتونه موندل کيږي ، خو ترکومه چې د لاس ته راغلو اسنادو خبره ده ، نو له عربۍ څخه پښتو خله کړې. د نوموړي قصيده په دې ټکو پيل کيږي.''',
//       date_created: DateTime.now().microsecondsSinceEpoch,
//       can_copy: true,
//       can_share: true,
//       id: "",
//       image_url: "",
//       is_deleted: false,
//       likes: 0,
//       reads: 0,
//     );
//     await refColumns.add(mod.toMap());

    QuerySnapshot querySnapshot = await refColumns
        .where('is_deleted', isEqualTo: false)
        .orderBy("date_created", descending: true)
        .get();

    if (columns.length > 0) {
      columns.clear();
    }

    querySnapshot.docs.forEach((doc) {
      columns.add(
        ColumnModel.createColumn(
          id: doc.id,
          column_text: doc.get("column_text"),
          date_created: doc.get("date_created"),
          reads: doc.get("reads"),
          likes: doc.get("likes"),
          is_deleted: doc.get("is_deleted"),
          can_copy: doc.get("can_copy"),
          can_share: doc.get("can_share"),
          image_url: doc.get("image_url"),
        ),
      );
    });

    if (columns.length == 0) {
      no_columns.value = true;
    }
  }

  Future<void> deleteColumn({
    required String columnId,
  }) async {
    return await refColumns.doc(columnId).update(
      {
        'is_deleted': true,
      },
    );
  }

  Future<DocumentReference> saveColumn(ColumnModel cm) async {
    return await refColumns.add(cm.toMap());
  }

  Future<void> likeColumn(int index) {
    ColumnModel pm = columns[index];
    pm.likes = pm.likes! + 1;
    columns.removeAt(index);
    columns.insert(index, pm);
    Map<String, Object> like = new Map();
    like['likes'] = pm.likes!;
    return refColumns.doc(columns[index].id).update(like);
  }

  Future<void> readColumn(int index) {
    ColumnModel pm = columns[index];
    pm.likes = pm.reads! + 1;
    columns.removeAt(index);
    columns.insert(index, pm);
    Map<String, Object> like = new Map();
    like['reads'] = pm.likes!;
    return refColumns.doc(columns[index].id).update(like);
  }
}
