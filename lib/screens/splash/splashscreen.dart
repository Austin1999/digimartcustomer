import 'package:digimartcustomer/constants/assetpaths.dart';
import 'package:digimartcustomer/screens/loading/loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 120,
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: Loading())
        ],
      ),
    );
  }
}
