import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/payment.dart/widgets/details.dart';
import 'package:digimartcustomer/screens/profile/widgets/profiledialog.dart';
import 'package:digimartcustomer/utils/helper/showLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  TextEditingController phone =
      TextEditingController(text: userController.userModel.value.phone);
  TextEditingController address =
      TextEditingController(text: userController.userModel.value.address);
  TextEditingController name =
      TextEditingController(text: userController.userModel.value.name);
  TextEditingController pincode =
      TextEditingController(text: userController.userModel.value.pincode);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // key: _con.scaffoldKey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: textblack),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3)),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            userController.userModel.value.name,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          Text(
                            userController.userModel.value.phone,
                            style: Theme.of(context).textTheme.caption,
                          )
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                    SizedBox(
                        width: 50,
                        height: 50,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(300),
                          onTap: () {
                            Navigator.of(context).pushNamed('/Profile');
                          },
                          child: CircleAvatar(
                            backgroundColor: kprimarycolor,
                            child: Text(
                              userController.userModel.value.name == ''
                                  ? 'D'
                                  : userController.userModel.value.name
                                      .substring(0, 1),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(color: textwhite),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: textwhite,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person),
                      title: Text(
                        'Profile Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: ButtonTheme(
                        padding: EdgeInsets.all(0),
                        minWidth: 50.0,
                        height: 25.0,
                        child: ProfileSettingsDialog(
                          onChanged: () {
                            userController.updateUserData({
                              'name': name.text,
                              'address': address.text,
                              'phone': phone.text,
                              'pincode': pincode.text
                            });
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Full name',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        userController.userModel.value.name,
                        style: TextStyle(color: textgrey),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Phone',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        userController.userModel.value.phone,
                        style: TextStyle(color: textgrey),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Address',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: SizedBox(
                        width: 150,
                        child: Text(
                          userController.userModel.value.address ?? 'Unknown',
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(color: textgrey),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Pincode',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      trailing: Text(
                        userController.userModel.value.pincode,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: textgrey),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: textwhite,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ],
                ),
                child: ListView(
                  shrinkWrap: true,
                  primary: false,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text(
                        'App Settings',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Languages');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.translate,
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Languages',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                      trailing: Text(
                        'English',
                        style: TextStyle(color: textgrey),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/DeliveryAddresses');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.place,
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Delivery Addresses',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed('/Help');
                      },
                      dense: true,
                      title: Row(
                        children: <Widget>[
                          Icon(
                            Icons.help,
                            size: 22,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Help & Support',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
