import 'package:digimartcustomer/screens/home/widgets/appbar.dart';
import 'package:digimartcustomer/screens/home/widgets/carousel.dart';
import 'package:digimartcustomer/screens/home/widgets/freatured.dart';
import 'package:digimartcustomer/screens/home/widgets/topdeals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeAppbar(size: size),
              Carousel(),
              Featured(size: size),
              TopDeals(size: size),
            ],
          ),
        ),
      ),
    );
  }
}
