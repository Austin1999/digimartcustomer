import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: SpinKitCubeGrid(
          color: kprimarycolor,
          size: 30,
        ));
        // child: SpinKitWanderingCubes(
        //   color: kprimarycolor,
        //   size: 30,
        // ));
  }
}
