import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/utils/helper/showLoading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/details.dart';

class COD extends StatefulWidget {
  final List<CartItemModel> product;
  COD({this.product});
  @override
  _CODState createState() => _CODState();
}

class _CODState extends State<COD> {
  TextEditingController phone =
      TextEditingController(text: userController.userModel.value.phone);
  TextEditingController address =
      TextEditingController(text: userController.userModel.value.address);
  TextEditingController name =
      TextEditingController(text: userController.userModel.value.name);
  TextEditingController pincode =
      TextEditingController(text: userController.userModel.value.pincode);

  double discount = userController.userModel.value.cart.fold(
      0,
      (previousValue, element) =>
          previousValue + (int.parse(element.discount) * element.quantity));
  double carttotal = userController.userModel.value.cart.fold(
    0,
    (previousValue, element) => previousValue + double.parse(element.cost),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            'Confirm Address',
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        bottomNavigationBar: Material(
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
                              text:
                                  '₹${double.parse((carttotal + int.parse(orderController.ordercongig.shippingfee) + (carttotal * (int.parse(orderController.ordercongig.tax)) / 100) - (carttotal - discount)).toStringAsFixed(2))}',
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
                      var totalPrice = double.parse((carttotal +
                              int.parse(
                                  orderController.ordercongig.shippingfee) +
                              (carttotal *
                                  (int.parse(orderController.ordercongig.tax)) /
                                  100) -
                              (carttotal - discount))
                          .toStringAsFixed(2));

                      showLoading();
                      try {
                        firebaseFirestore
                            .collection('users')
                            .doc(userController.firebaseUser.value.uid)
                            .collection('orders')
                            .add({
                          'item':
                              widget.product.map((e) => e.toJson()).toList(),
                          'cusName': userController.userModel.value.name,
                          'address': userController.userModel.value.address,
                          'pincode': userController.userModel.value.pincode,
                          'phone': userController.userModel.value.phone,
                          'datetime': DateTime.now(),
                          'deliverystatus': 'Order Placed',
                          'totalprice': totalPrice,
                          'shippingfee':
                              orderController.ordercongig.shippingfee,
                          'tax': orderController.ordercongig.tax,
                          'discount': (carttotal - discount)
                        }).whenComplete(() {
                          firebaseFirestore.collection('orders').add({
                            'item':
                                widget.product.map((e) => e.toJson()).toList(),
                            'cusName': userController.userModel.value.name,
                            'address': userController.userModel.value.address,
                            'pincode': userController.userModel.value.pincode,
                            'phone': userController.userModel.value.phone,
                            'datetime': DateTime.now(),
                            'deliverystatus': 'Order Placed',
                            'userId': userController.firebaseUser.value.uid,
                            'totalprice': totalPrice,
                            'shippingfee':
                                orderController.ordercongig.shippingfee,
                            'tax': orderController.ordercongig.tax,
                            'discount': (carttotal - discount)
                          }).whenComplete(() {
                            widget.product.forEach((element) {
                              print('Product ID : ${element.productId}');
                              cartController.removeCartItem(element);
                              firebaseFirestore
                                  .collection('products')
                                  .doc(element.docid)
                                  .update({
                                'quantity':
                                    FieldValue.increment(-element.quantity)
                              });
                            });

                            dismissLoadingWidget();
                            Get.defaultDialog(
                                barrierDismissible: false,
                                onConfirm: () => Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavigationPage()),
                                    (route) => false),
                                title: 'Congratulations',
                                middleText: 'Order Successfully Placed',
                                textConfirm: 'Okay',
                                confirmTextColor: textwhite);
                          });
                        });
                      } catch (e) {
                        Get.snackbar("Error", "Cannot Place this item");
                        debugPrint(e.toString());
                      }
                    },
                    child: Container(
                      width: ((MediaQuery.of(context).size.width) / 2),
                      height: 50.0,
                      color: (carttotal == 0)
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      alignment: Alignment.center,
                      child: Text(
                        'Place Order',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
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
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      dense: true,
                      title: Text(
                        'Order Summary',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Column(
                          children: widget.product
                              .map(
                                (e) => ListTile(
                                  dense: true,
                                  title: Text(
                                    '${e.name} x ${e.quantity}',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  trailing: Text(
                                    '₹${e.cost}',
                                    style: TextStyle(color: textgrey),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Tax',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          trailing: Text(
                            '${orderController.ordercongig.tax}%',
                            style: TextStyle(color: textgrey),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Discount',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          trailing: Text(
                            '- ₹${carttotal - discount}',
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Shipping Price',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          trailing: Text(
                            orderController.ordercongig.shippingfee == '0'
                                ? 'Free'
                                : '₹${orderController.ordercongig.shippingfee}',
                            style: TextStyle(color: textgrey),
                          ),
                        ),
                        // ListTile(
                        //   dense: true,
                        //   title: Text(
                        //     'Subtotal',
                        //     style: Theme.of(context).textTheme.bodyText2,
                        //   ),
                        //   trailing: Text(
                        //     '₹${carttotal + int.parse(orderController.ordercongig.shippingfee) + (carttotal * (int.parse(orderController.ordercongig.tax)) / 100) - (carttotal - discount)}',
                        //     style: TextStyle(color: textgrey),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ProfileDetails(
                      name: name,
                      phone: phone,
                      address: address,
                      pincode: pincode),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
