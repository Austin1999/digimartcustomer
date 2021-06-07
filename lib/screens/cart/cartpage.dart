import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/payment.dart/paymentmethod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
// import 'package:pay/pay.dart';

import 'cartwidget.dart';

class ShoppingCartWidget extends StatefulWidget {
  @override
  _ShoppingCartWidgetState createState() => _ShoppingCartWidgetState();
}

class _ShoppingCartWidgetState extends State<ShoppingCartWidget> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[50],
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: TextStyle(color: kprimarycolor),
        ),
      ),
      bottomNavigationBar: Obx(() {
        double carttotal = userController.userModel.value.cart
            .fold(0, (previousValue, element) => previousValue + element.cost);
        return Material(
          elevation: 5.0,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: ((MediaQuery.of(context).size.width) / 2),
                  height: 50.0,
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      text: 'Total: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                          color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' ₹$carttotal',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: kprimarycolor)),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    (carttotal == 0)
                        ? null
                        : Get.to(() => PaymentMethod(
                              product: userController.userModel.value.cart,
                            ));
                  },
                  child: Container(
                    width: ((MediaQuery.of(context).size.width) / 2),
                    height: 50.0,
                    color: (carttotal == 0)
                        ? Colors.grey
                        : Theme.of(context).primaryColor,
                    alignment: Alignment.center,
                    child: Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      body: userController.userModel.value.cart.isEmpty
          ? Center(
              child: Text(
                'Your cart is Empty',
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          : Stack(
              children: [
                ListView(
                  children: [
                    Obx(() => Column(
                          children: userController.userModel.value.cart
                              .map((cartItem) => Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: textwhite,
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Theme.of(context)
                                                .hintColor
                                                .withOpacity(0.15),
                                            offset: Offset(0, 3),
                                            blurRadius: 10)
                                      ],
                                    ),
                                    child: CartItemWidget(
                                      cartItem: cartItem,
                                    ),
                                  ))
                              .toList(),
                        )),
                  ],
                ),
              ],
            ),
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
