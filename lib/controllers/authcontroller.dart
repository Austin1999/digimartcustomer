import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/usermodel.dart';
import 'package:digimartcustomer/screens/auth/login.dart';
import 'package:digimartcustomer/screens/home/homescreen.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/utils/helper/showLoading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => NavigationPage());
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
          await auth.signInWithCredential(credential).then((result) {
            String _userId = result.user.uid;
            _addUserToFirestore(_userId);
            _clearControllers();
          });
        },
        verificationFailed: (FirebaseException e) {
          debugPrint(e.message);
          dismissLoadingWidget();
          Get.snackbar('Verification failed', '');
        },
        codeSent: (String verificationId, int resendToken) {
          dismissLoadingWidget();
          codesent = true.obs;
          verificationcode = verificationId.obs;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationcode = verificationId.obs;
        },
        timeout: Duration(seconds: 120),
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signOut() async {
    auth.signOut();
  }

  _addUserToFirestore(String userId) {
    firebaseFirestore.collection(usersCollection).doc(userId).set({
      "phone": phone.text.trim(),
      "id": userId,
      // "email": email.text.trim(),
      "cart": [],
    });
  }

  _clearControllers() {
    phone.clear();
    otp.clear();
  }

  updateUserData(Map<String, dynamic> data) {
    logger.i("UPDATED");
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));
}
