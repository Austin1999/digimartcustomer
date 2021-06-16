import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/controllers/ordercontrolller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants/firebase.dart';
import 'controllers/appcontroller.dart';
import 'controllers/authcontroller.dart';
import 'controllers/cartcontoller.dart';
import 'controllers/productcontroller.dart';
import 'onboarding/onboarding.dart';
import 'screens/splash/splashscreen.dart';

RxInt initScreen = 0.obs;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialization.then((value) {
    Get.put(AppController());
    Get.put(OrderController());
    Get.put(UserController());
    Get.put(ProducsController());
    Get.put(CartController());
    // Get.put(PaymentsController());
  });
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // initScreen = prefs.getInt("initScreen");
  // await prefs.setInt("initScreen", 1);
  initScreen.value = 1;
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
