import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/home/widgets/appbar.dart';
import 'package:digimartcustomer/screens/home/widgets/carousel.dart';
import 'package:digimartcustomer/screens/home/widgets/category.dart';
import 'package:digimartcustomer/screens/home/widgets/freatured.dart';
import 'package:digimartcustomer/screens/home/widgets/topdeals.dart';
import 'package:digimartcustomer/screens/notificaiton/notification.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // showProfileDialog() async {
  //   await Future.delayed(Duration(milliseconds: 50));

  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Complete your profile'),
  //         content: Text(
  //             'Please add your address and pincode to your profile section'),
  //         actions: [
  //           RaisedButton(
  //               color: kprimarycolor,
  //               child: Text(
  //                 'Go to my Profile',
  //                 style: TextStyle(color: textwhite),
  //               ),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 Navigator.pop(context);
  //                 Get.to(() => MyProfile());
  //               })
  //         ],
  //       );
  //     },
  //   );
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   if (userController.userModel.value.address == '' ||
  //       userController.userModel.value.address == null) showProfileDialog();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[100],
          elevation: 0,
          automaticallyImplyLeading: false,
          // leading:
          title: Text(
            'Digimart',
            style: TextStyle(color: kprimarycolor),
          ),
          actions: [
            Obx(
              () => SizedBox(
                width: size.width * 0.45,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userController.userModel.value.address == null
                            ? ''
                            : userController.userModel.value.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kprimarycolor,
                            fontSize: 14),
                      ),
                      Text(
                        userController.userModel.value.address == null
                            ? ''
                            : userController.userModel.value.pincode,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: kprimarycolor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Get.to(() => NotificationPage());
                })
          ],
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: HomeAppbar(size: size),
              ),
              Carousel(),
              CategoryGrid(),
              Column(
                children: [
                  Featured(size: size),
                  TopDeals(size: size),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
