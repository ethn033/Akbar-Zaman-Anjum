// ignore_for_file: unnecessary_cast, unnecessary_statements, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/models/hashtag_model.dart';
import 'package:mula_jan_shayeri/models/poetry_model.dart';

class PoetryController extends GetxController {
  CollectionReference refPoetries =
      FirebaseFirestore.instance.collection("poetries");
  CollectionReference refHashtags =
      FirebaseFirestore.instance.collection("hashtags");

  List<PoetryModel> poetries = List<PoetryModel>.empty(growable: true).obs;
  List<HashtagModel> hashTags = List<HashtagModel>.empty(growable: true).obs;
  List<String> selectedHashTags = List<String>.empty(growable: true).obs;
  RxBool no_poetry = false.obs;
  RxBool no_hashtags = false.obs;
  RxBool uploading = false.obs;
  RxBool deleting = false.obs;
  RxBool can_copy_poetry = true.obs;
  RxBool can_share_poetry = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getPoetries();
  }

  @override
  void onClose() {
    super.onClose();
  }

  addHatshTag(String tag) {
    selectedHashTags.contains(tag)
        ? selectedHashTags.remove(tag)
        : selectedHashTags.add(tag);
  }

  Future<void> saveHashTag(String tag) async {
    HashtagModel ht = HashtagModel.createTag(
      date_created: DateTime.now().microsecondsSinceEpoch,
      tag: tag,
      disabled: false,
    );
    final id = await refHashtags.add(ht.toMap());
    ht.id = id.id;
    hashTags.insert(0, ht);
    no_hashtags.value = false;
  }

  Future<void> getHashTags() async {
    QuerySnapshot querySnapshot = await refHashtags
        .where('disabled', isEqualTo: false)
        .orderBy("date_created", descending: true)
        .get();

    if (hashTags.length > 0) {
      hashTags.clear();
    }

    querySnapshot.docs.forEach((doc) {
      hashTags.add(HashtagModel.createTag(
        id: doc.id,
        tag: doc.get("tag"),
        disabled: doc.get("disabled"),
        date_created: doc.get("date_created"),
      ));
    });

    if (hashTags.length == 0) {
      no_hashtags.value = true;
    } else {
      no_hashtags.value = false;
    }
  }

  Future<void> getPoetries() async {
    // var mod = new PoetryModel.createPoetry(
    //   poetry_text: 'poetry_text',
    //   date_created: DateTime.now().microsecondsSinceEpoch,
    //   can_copy: true,
    //   can_share: true,
    //   cat_id: "",
    //   id: "",
    //   image_url: "",
    //   is_deleted: false,
    //   likes: 0,
    //   reads: 0,
    //   tags: [
    //     '#love',
    //     '#pain',
    //     '#heart',
    //   ],
    // );
    // await refPoetries.add(mod.toMap());

    QuerySnapshot querySnapshot = await refPoetries
        .where('is_deleted', isEqualTo: false)
        .orderBy("date_created", descending: true)
        .get();

    if (poetries.length > 0) {
      poetries.clear();
      poetries = List<PoetryModel>.empty(growable: true);
    }

    querySnapshot.docs.forEach((doc) {
      poetries.add(
        PoetryModel.createPoetry(
          id: doc.id,
          cat_id: doc.get("cat_id"),
          poetry_text: doc.get("poetry_text"),
          date_created: doc.get("date_created"),
          reads: doc.get("reads"),
          likes: doc.get("likes"),
          is_deleted: doc.get("is_deleted"),
          can_copy: doc.get("can_copy"),
          can_share: doc.get("can_share"),
          image_url: doc.get("image_url"),
          tags: doc.get("tags"),
        ),
      );
    });

    if (poetries.length == 0) {
      no_poetry.value = true;
    }
  }

  Future<void> deletePOetry({
    required String poetryId,
  }) async {
    return await refPoetries.doc(poetryId).update(
      {
        'is_deleted': true,
      },
    );
  }

  Future<DocumentReference> savePoetry(PoetryModel pm) async {
    return await refPoetries.add(pm.toMap());
  }

  Future<void> likePoetry(int index) {
    PoetryModel pm = poetries[index];
    pm.likes = pm.likes! + 1;
    poetries.removeAt(index);
    poetries.insert(index, pm);
    Map<String, Object> like = new Map();
    like['likes'] = pm.likes!;
    return refPoetries.doc(poetries[index].id).update(like);
  }

  Future<void> readPoetry(int index) {
    PoetryModel pm = poetries[index];
    pm.likes = pm.reads! + 1;
    poetries.removeAt(index);
    poetries.insert(index, pm);
    Map<String, Object> like = new Map();
    like['reads'] = pm.likes!;
    return refPoetries.doc(poetries[index].id).update(like);
  }

  Future<void> deleteHashtag(HashtagModel hashtagModel) async {
    if (hashTags.contains(hashtagModel)) {
      hashTags.remove(hashtagModel);
      final index =
          selectedHashTags.indexWhere((element) => element == hashtagModel.tag);
      if (index > 0) {
        selectedHashTags.removeAt(index);
      }
    }
    if (hashTags.length == 0) {
      no_hashtags.value = true;
    }
    return await refHashtags.doc(hashtagModel.id).update({'disabled': true});
  }

  Future<bool> isTagExists(String tag) async {
    QuerySnapshot querySnapshot = await refHashtags
        .where('disabled', isEqualTo: false)
        .where('tag', isEqualTo: tag)
        .get();
    if (querySnapshot.docs.length > 0) {
      return true;
    }
    return false;
  }
}
