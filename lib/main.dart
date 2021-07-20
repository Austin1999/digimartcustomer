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
import 'package:in_app_update/in_app_update.dart';
import 'screens/splash/splashscreen.dart';

int initScreen = 0;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // initScreen = prefs.getInt("initScreen");
  // await prefs.setInt("initScreen", 1);

  await initialization.then((value) {
    print(initScreen);
    Get.put(AppController());
    Get.put(UserController());
      Get.put(OrderController());

      Get.put(ProducsController());
      Get.put(CartController());
  
    // Get.put(PaymentsController());
  });

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppUpdateInfo _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  //  bool _flexibleUpdateAvailable = false;
  //  Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) {
  //     showSnack(e.toString());
  //   });
  // }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateInfo?.updateAvailability == UpdateAvailability.updateAvailable
        ? InAppUpdate.performImmediateUpdate()
            .catchError((e) => showSnack(e.toString()))
        : null;
  }

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
