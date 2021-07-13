import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/home/homescreen.dart';
import 'package:digimartcustomer/screens/home/widgets/tabbar.dart';
import 'package:digimartcustomer/screens/orders/orderpage.dart';
import 'package:digimartcustomer/screens/profile/profile.dart';
import 'package:digimartcustomer/screens/search/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  void _onItemTapped(int index) {
    if(index == 2){
       appController.selectedIndex.value = 0;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ListSearch(),),);
    }
    else{
    setState(() {
      appController.selectedIndex.value = index;
    });
    }
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ShoppingCartWidget(),
    ListSearch(),
    OrderPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(appController.selectedIndex.value),
        ),
        bottomNavigationBar: Obx(
          () => CustomBottomAppBar(
            // centerItemText: 'Search',
            color: Colors.grey,
            backgroundColor: Colors.white,
            selectedColor: kprimarycolor,
            // notchedShape: CircularNotchedRectangle(),
            onTabSelected: _onItemTapped,
            items: [
              CustomBottomAppBarItem(
                  iconData: Icons.home, text: 'Home', badge: false),
              CustomBottomAppBarItem(
                  iconData: Icons.shopping_cart,
                  text: 'Cart',
                  badge: true,
                  value: userController.userModel.value?.cart?.length ?? 0),
              CustomBottomAppBarItem(
                  iconData: Icons.search, text: 'Search', badge: false),
              CustomBottomAppBarItem(
                  iconData: Icons.list,
                  text: 'Orders',
                  badge: false,
                  value: orderController?.orders?.length ?? 0),
              CustomBottomAppBarItem(
                  iconData: Icons.account_circle,
                  text: 'Profile',
                  badge: false),
            ],
          ),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: kprimarycolor,
        //   onPressed: () {
        //     Get.to(() => ListSearch());
        //   },
        //   child: Icon(Icons.search),
        //   elevation: 2.0,
        // ),
      ),
    );
  }
}
