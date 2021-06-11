import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/listupload/listupload.dart';
import 'package:digimartcustomer/screens/orders/orderpage.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return SafeArea(
      child: Scaffold(
        // appBar: ,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 160,
                color: kprimarycolor,
                child: Center(
                  child: UserAccountsDrawerHeader(
                    accountEmail: Text(
                      userController.userModel.value.phone,
                    ),
                    accountName: Text(
                      userController.userModel.value.name,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: textwhite,
                      child: Text(
                          userController.userModel.value.name == ''
                              ? 'D'
                              : userController.userModel.value.name
                                  .substring(0, 1),
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: kprimarycolor)),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () => Get.to(() => MyProfile()),
                leading: Icon(
                  Icons.account_circle_outlined,
                  color: kprimarycolor,
                ),
                title: Text('My Profile'),
              ),
              Divider(),
              ListTile(
                onTap: () => Get.to(() => OrderPage()),
                leading: Icon(
                  Icons.list,
                  color: kprimarycolor,
                ),
                title: Text('My Orders'),
              ),
              Divider(),
              ListTile(
                onTap: () => Get.to(() => ListUploadPage()),
                leading: Icon(Icons.upload_file, color: kprimarycolor),
                title: Text('Upload List'),
                trailing: Tooltip(
                    key: key,
                    message:
                        'Upload your photo of grocery list we will deliver at your doorstep.',
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _onTap(key),
                        child: Icon(Icons.help))),
              ),
              Divider(),
              ListTile(
                onTap: () => Get.to(() => ShoppingCartWidget()),
                leading:
                    Icon(Icons.shopping_cart_outlined, color: kprimarycolor),
                title: Text('My Cart'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.star_rate_outlined, color: kprimarycolor),
                title: Text('Rate us'),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.help_outline, color: kprimarycolor),
                title: Text('Help'),
              ),
              Divider(),
              ListTile(
                onTap: () => userController.signOut(),
                leading: Icon(Icons.login_outlined, color: kprimarycolor),
                title: Text('Log Out'),
              ),
              Divider(),
              Text('Version $version')
            ],
          ),
        ),
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
