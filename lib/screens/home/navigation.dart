import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/home/homescreen.dart';
import 'package:digimartcustomer/screens/home/widgets/tabbar.dart';
import 'package:digimartcustomer/screens/orders/orderpage.dart';
import 'package:digimartcustomer/screens/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ShoppingCartWidget(),
    OrderPage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: CustomBottomAppBar(
          centerItemText: 'Search',
          color: Colors.grey,
          backgroundColor: Colors.white,
          selectedColor: kprimarycolor,
          notchedShape: CircularNotchedRectangle(),
          onTabSelected: _onItemTapped,
          items: [
            CustomBottomAppBarItem(iconData: Icons.home, text: 'Home'),
            CustomBottomAppBarItem(iconData: Icons.shopping_cart, text: 'Cart'),
            CustomBottomAppBarItem(iconData: Icons.list, text: 'Orders'),
            CustomBottomAppBarItem(
                iconData: Icons.account_circle, text: 'Profile'),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kprimarycolor,
          onPressed: () {},
          child: Icon(Icons.search),
          elevation: 2.0,
        ),
      ),
    );
  }
}