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

import 'widgets/toppicks.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> _profileSettingsFormKey = new GlobalKey<FormState>();

  TextEditingController phone =
      TextEditingController(text: userController.userModel.value.phone);
  TextEditingController address =
      TextEditingController(text: userController.userModel.value.address);
  TextEditingController name =
      TextEditingController(text: userController.userModel.value.name);
  TextEditingController pincode =
      TextEditingController(text: userController.userModel.value.pincode);

  showProfileDialog() async {
    TextEditingController pincode = TextEditingController();
    await Future.delayed(Duration(milliseconds: 50));

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20),
          titlePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          title: Text('Please Enter Your Pincode'),
          children: [
            TextFormField(
              style: TextStyle(color: Theme.of(context).hintColor),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: 'Pincode',
                labelText: 'Pincode',
                hintStyle: Theme.of(context).textTheme.bodyText2.merge(
                      TextStyle(color: Theme.of(context).focusColor),
                    ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).hintColor.withOpacity(0.2))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).hintColor)),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: Theme.of(context).textTheme.bodyText2.merge(
                      TextStyle(color: Theme.of(context).hintColor),
                    ),
              ),
              validator: (input) =>
                  input.trim().length < 3 ? 'Not a Valid Pincode' : null,
              controller: pincode,
            ),
            MaterialButton(
              onPressed: () {
                userController.updateUserData({'pincode': pincode.text});
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: kprimarycolor),
              ),
            ),
          ],
        );
      },
    );
  }

  InputDecoration getInputDecoration({String hintText, String labelText}) {
    return new InputDecoration(
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).focusColor),
          ),
      enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).hintColor.withOpacity(0.2))),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).hintColor)),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: Theme.of(context).textTheme.bodyText2.merge(
            TextStyle(color: Theme.of(context).hintColor),
          ),
    );
  }

  void _submit() {
    if (_profileSettingsFormKey.currentState.validate()) {
      _profileSettingsFormKey.currentState.save();
      userController.updateUserData({
        'name': name.text,
        'address': address.text,
        'phone': phone.text,
        'pincode': pincode.text
      });
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (userController.userModel.value.pincode == '') showProfileDialog();
    super.initState();
  }

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
          title: Image.asset(
            'assets/images/logo.png',
            height: 100,
          ),
          // Text(
          //   'Digimart',
          //   style: TextStyle(color: kprimarycolor),
          // ),
          actions: [
            Obx(
              () => InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          titlePadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          title: Row(
                            children: <Widget>[
                              Icon(Icons.person),
                              SizedBox(width: 10),
                              Text(
                                'Edit Profile',
                                style: Theme.of(context).textTheme.bodyText1,
                              )
                            ],
                          ),
                          children: <Widget>[
                            Form(
                              key: _profileSettingsFormKey,
                              child: Column(
                                children: <Widget>[
                                  new TextFormField(
                                    controller: name,
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    keyboardType: TextInputType.text,
                                    decoration: getInputDecoration(
                                        hintText: 'Your Name',
                                        labelText: 'Full Name'),
                                    validator: (input) =>
                                        input.trim().length < 2
                                            ? 'Not a Valid Name'
                                            : null,
                                  ),
                                  new TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    keyboardType: TextInputType.text,
                                    decoration: getInputDecoration(
                                        hintText: '+91 00000 0000',
                                        labelText: 'Phone'),
                                    validator: (input) =>
                                        input.trim().length < 3
                                            ? 'Not a Valid Phone'
                                            : null,
                                    controller: phone,
                                  ),
                                  new TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    keyboardType: TextInputType.text,
                                    decoration: getInputDecoration(
                                        hintText: 'Your Address',
                                        labelText: 'Address'),
                                    validator: (input) =>
                                        input.trim().length < 3
                                            ? 'Not a Valid Address'
                                            : null,
                                    controller: address,
                                  ),
                                  new TextFormField(
                                    style: TextStyle(
                                        color: Theme.of(context).hintColor),
                                    keyboardType: TextInputType.text,
                                    decoration: getInputDecoration(
                                        hintText: 'Pincode',
                                        labelText: 'Pincode'),
                                    validator: (input) =>
                                        input.trim().length < 3
                                            ? 'Not a Valid Pincode'
                                            : null,
                                    controller: pincode,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: <Widget>[
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'),
                                ),
                                MaterialButton(
                                  onPressed: _submit,
                                  child: Text(
                                    'Save',
                                    style: TextStyle(color: kprimarycolor),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      });
                },
                child: SizedBox(
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
                          userController.userModel.value.pincode == null
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
                  TopPicks(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
