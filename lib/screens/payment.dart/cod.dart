import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/screens/profile/widgets/profiledialog.dart';
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
    0.0,
    (previousValue, element) {
      return previousValue + (double.parse(element.discount) * element.number);
    },
  );
  double carttotal = userController.userModel.value.cart.fold(
    0,
    (previousValue, element) =>
        previousValue + (double.parse(element.price) * element.number),
  );
  @override
  Widget build(BuildContext context) {
    print('Discount : $discount');
    print('Cart Total : $carttotal');
    print(widget.product);
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
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Total: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                                color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                  text:
                                      '₹${double.parse((discount + (carttotal > double.parse(orderController.ordercongig.range) ? double.parse(orderController.ordercongig.maxfee) : double.parse(orderController.ordercongig.minfee))).toStringAsFixed(2))}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: kprimarycolor)),
                            ],
                          ),
                        ),
                        Text(
                          '(Inclusive of all taxes)',
                          style: Theme.of(context).textTheme.overline,
                        )
                      ],
                    ),
                  ), 
                  InkWell(
                    onTap: () {
                      var totalPrice = double.parse((carttotal +
                              (carttotal >
                                      double.parse(
                                          orderController.ordercongig.range)
                                  ? double.parse(
                                      orderController.ordercongig.maxfee)
                                  : double.parse(
                                        orderController.ordercongig.minfee,
                                      ) -
                                      (carttotal - discount)))
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
                          'shippingfee': carttotal >
                                  double.parse(
                                      orderController.ordercongig.range)
                              ? orderController.ordercongig.maxfee
                              : orderController.ordercongig.minfee,
                          'discount': (carttotal - discount)
                        }).then((v) {
                          firebaseFirestore.collection('orders').add({
                            'item':
                                widget.product.map((e) => e.toJson()).toList(),
                            'cusName': userController.userModel.value.name,
                            'address': userController.userModel.value.address,
                            'pincode': userController.userModel.value.pincode,
                            'phone': userController.userModel.value.phone,
                            'datetime': DateTime.now(),
                            'deliverystatus': 'Order Placed',
                            "docId": v.id,
                            'userId': userController.firebaseUser.value.uid,
                            'totalprice': totalPrice,
                            'shippingfee': carttotal >
                                    double.parse(
                                        orderController.ordercongig.range)
                                ? orderController.ordercongig.maxfee
                                : orderController.ordercongig.minfee,
                            'discount': (carttotal - discount)
                          }).whenComplete(() {
                            widget.product.forEach((element) {
                              print('Product ID : ${element.productId}');
                              cartController.removeCartItem(element);
                              // firebaseFirestore
                              //     .collection('products')
                              //     .doc(element.docid)
                              //     .update({
                              //   'quantity': element.quantity
                              //               .replaceAll(RegExp("[A-Za-z]"), "")
                              //               .trim()
                              //               .length ==
                              //           3
                              //       ? FieldValue.increment(-((double.parse(
                              //               element.quantity
                              //                   .replaceAll(
                              //                       RegExp("[A-Za-z]"), "")
                              //                   .trim())) /
                              //           1000))
                              //       : FieldValue.increment(-((double.parse(
                              //           element.quantity
                              //               .replaceAll(RegExp("[A-Za-z]"), "")
                              //               .trim())))),
                              // });
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
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${e.name} x ${e.number}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
                                      ),
                                      Text('(${e.quantity})'),
                                    ],
                                  ),
                                  trailing: Text(
                                    '₹${int.parse(e.price) * e.number}',
                                    style: TextStyle(color: textgrey),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        // ListTile(
                        //   dense: true,
                        //   title: Text(
                        //     'Tax',
                        //     style: Theme.of(context).textTheme.bodyText2,
                        //   ),
                        //   trailing: Text(
                        //     '${}%',
                        //     style: TextStyle(color: textgrey),
                        //   ),
                        // ),
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
                            carttotal >
                                    double.parse(
                                        orderController.ordercongig.range)
                                ? '₹${orderController.ordercongig.maxfee}'
                                : '₹${orderController.ordercongig.minfee}',
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
              Obx(
                () => Container(
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
                          child: ProfileSettingsDialog(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
