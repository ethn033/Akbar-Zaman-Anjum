// ignore_for_file: unnecessary_cast

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<User?> currentUser = (null as User?).obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  Rx<bool> loading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await setCurrentUser();
  }

  Future<UserCredential?> signInUser(String email, String password) async {
    loading.value = true;
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<UserCredential?> signUpuser(String email, String password) async {
    loading.value = true;
    try {
      return await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    loading.value = false;
  }

  Future<void> logoutUser() async {
    return await auth.signOut();
  }

  Future<User?> isUserLoggedIn() async {
    return auth.currentUser;
  }

  Future<void> setCurrentUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      currentUser.value = user;
    });
  }
}
