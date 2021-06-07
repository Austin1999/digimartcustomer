import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(
                        'assets/images/logo.jpg',
                      ),
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: userController.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter your Phone Number',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Visibility(
                    visible: userController.codesent.value,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: userController.otp,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter OTP',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        color: kprimarycolor,
                        child: Text(
                          userController.codesent.value == false
                              ? 'Send OTP'
                              : 'Verify OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                        onPressed: () async {
                          // userController.codesent.value = true;
                          userController.codesent.value == false
                              ? userController.signIn()
                              : await auth
                                  .signInWithCredential(
                                      PhoneAuthProvider.credential(
                                          verificationId: userController
                                              .verificationcode.value,
                                          smsCode: userController.otp.text))
                                  .then((result) async {
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
                                      userController
                                          .addUserToFirestore(_userId);
                                      userController.codesent.value = false;
                                      userController.clearControllers();
                                    }
                                  });
                                });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
