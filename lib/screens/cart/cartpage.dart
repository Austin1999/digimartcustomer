import 'package:digimartcustomer/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'cartwidget.dart';

class ShoppingCartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Shopping Cart",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Obx(() => Column(
                      children: userController.userModel.value.cart
                          .map((cartItem) => CartItemWidget(
                                cartItem: cartItem,
                              ))
                          .toList(),
                    )),
              ],
            ),
            // Positioned(
            //     bottom: 30,
            //     child: Container(
            //       width: MediaQuery.of(context).size.width,
            //       padding: EdgeInsets.all(8),
            //       // child:
            //       // Obx(() => CustomButton(
            //       // text: "Pay (\$${cartController.totalCartPrice.value.toStringAsFixed(2)})", onTap: () {
            //       //   paymentsController.createPaymentMethod();
            //       // }
            //       // ),
            //       // )
            //     ))
          ],
        ),
      ),
    );
  }
}
