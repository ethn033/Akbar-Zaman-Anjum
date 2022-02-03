import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:mula_jan_shayeri/models/UserModel.dart';
import 'package:mula_jan_shayeri/utils/constants.dart';

class SettingController extends GetxController {
  Rx<UserModel> userModel = new UserModel().obs;
  var userRef = FirebaseFirestore.instance.collection("settings").doc("user");
  var refFeedbacks = FirebaseFirestore.instance.collection("feedbacks");
  bool swithTheme = false;

  Rx<bool> isBioUpdate = false.obs;
  Rx<bool> isNameUpdate = false.obs;
  Rx<bool> isAboutUpdate = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUser();
  }

  Future<void> getUser() async {
    await userRef.get().then((DocumentSnapshot snapshot) async {
      if (snapshot.exists) {
        userModel.value = new UserModel.create(
          name: snapshot.get("name") ?? '',
          image: snapshot.get("image") ?? '',
          address: snapshot.get("address") ?? '',
          cover: snapshot.get("cover") ?? '',
          email: snapshot.get("email") ?? '',
          bio: snapshot.get("bio") ?? '',
          facebook: snapshot.get("facebook") ?? '',
          instagram: snapshot.get("instagram") ?? '',
          tiktok: snapshot.get("tiktok") ?? '',
          password: snapshot.get("password") ?? '',
          phone: snapshot.get("phone") ?? '',
          telegram: snapshot.get("telegram") ?? '',
          about: snapshot.get("about") ?? '',
        );
      } else {
        await feedInitialData();
        getUser();
      }
    }).onError((error, stackTrace) {
      print('error $error');
    });
  }

  Future<void> updateUser(Map<String, String> data) async {
    return userRef.update(data);
  }

  Future<void> removeImage(String type) {
    return userRef.update({type: ''});
  }

  Future<void> saveUpdateBio(String bio) async {
    userModel.value.bio = bio;
    return await userRef.update({'bio': bio});
  }

  Future<void> saveUpdateName(String name) async {
    userModel.value.name = name;
    return await userRef.update({'name': name});
  }

  Future feedInitialData() async {
    var um = new UserModel.create(
      name: 'User Name',
      image: '',
      address: 'XYZ street, house #5, NJ, United States.',
      cover: '',
      email: 'example@gmail.com',
      bio: 'some bio message',
      facebook: '',
      instagram: '',
      tiktok: '',
      password: '',
      phone: '+92 0323 0123XXX',
      telegram: '',
      about: 'Some long description about the owner of this app.',
    );
    await FirebaseFirestore.instance
        .collection("settings")
        .doc("user")
        .set(um.toMap());
    Constants.hashtags.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("hashtags")
          .add(element.toMap());
    });
  }

  Future<void> saveUpdateAbout(String about) async {
    userModel.value.about = about;
    return await userRef.update({'about': about});
  }

  Future<String> saveFeedback(String feedback) async {
    DocumentReference<Map<String, dynamic>> request =
        await refFeedbacks.add({'feedback': feedback});
    return request.id;
  }

  Future<void> updateFeedback(String feedbackId, String feedback) async {
    return await refFeedbacks.doc(feedbackId).set({'feedback': feedback});
  }

  Future<void> saveUpdatePhone(String val) async {
    userModel.value.phone = val;
    return await userRef.update({'phone': val});
  }

  Future<void> saveUpdateAddress(String val) async {
    userModel.value.address = val;
    return await userRef.update({'address': val});
  }
}
