import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/firebase.dart';
import 'controllers/appcontroller.dart';
import 'controllers/authcontroller.dart';
import 'controllers/cartcontoller.dart';
import 'controllers/productcontroller.dart';
import 'screens/splash/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(UserController());
    Get.put(ProducsController());
    Get.put(CartController());
    // Get.put(PaymentsController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: materialColor,
      ),
      home: SplashScreen(),
    );
  }
}
