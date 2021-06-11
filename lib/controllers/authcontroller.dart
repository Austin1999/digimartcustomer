import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/usermodel.dart';
import 'package:digimartcustomer/onboarding/onboarding.dart';
import 'package:digimartcustomer/screens/auth/login.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/utils/helper/showLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<User> firebaseUser;
  RxBool codesent = false.obs;
  RxBool isLoggedIn = false.obs;
  RxString verificationcode;
  TextEditingController phone = TextEditingController();
  TextEditingController otp = TextEditingController();
  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;
  RxBool updated = false.obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen");
    if (initScreen == 0 || initScreen == null) {
      Get.offAll(() => OnboardingScreen());
    } else {
      if (user == null) {
        Get.offAll(() => LoginScreen());
      } else {
        userModel.bindStream(listenToUser());
        Get.offAll(() => NavigationPage());
      }
    }
  }

  // void signIn() async {
  //   try {
  //     showLoading();
  //     await auth
  //         .signInWithEmailAndPassword(
  //             email: email.text.trim(), password: password.text.trim())
  //         .then((result) {
  //       _clearControllers();
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     Get.snackbar("Sign In Failed", "Try again");
  //   }
  // }

  void signIn() async {
    showLoading();
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+91${phone.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then((result) async {
            String _userId = result.user.uid;
            await firebaseFirestore
                .collection("users")
                .doc(_userId)
                .get()
                .then((doc) {
              if (doc.exists) {
                userController.codesent.value = false;
                userController.clearControllers();
              } else {
                userController.addUserToFirestore(_userId);
                userController.codesent.value = false;
                userController.clearControllers();
              }
            });
          });
        },
        verificationFailed: (FirebaseException e) {
          debugPrint(e.message);
          dismissLoadingWidget();
          Get.snackbar('Verification failed', '',
              backgroundColor: kprimarycolor, colorText: textwhite);
        },
        codeSent: (String verificationId, int resendToken) {
          dismissLoadingWidget();
          codesent.value = true;
          verificationcode = verificationId.obs;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationcode = verificationId.obs;
        },
        // timeout: Duration(seconds:120),
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.rawSnackbar(
        title: "Sign In Failed",
        message: "Try again",
      );
    }
  }

  void signOut() async {
    auth.signOut();
  }

  addUserToFirestore(String userId) {
    firebaseFirestore.collection('users').doc(userId).set(
      {
        "phone": phone.text.trim(),
        "id": userId,
        "cart": [],
        "name": '',
        "address": '',
        "pincode": ''
      },
      SetOptions(merge: true),
    );
  }

  clearControllers() {
    phone.clear();
    otp.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
    logger.i("UPDATED");
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
