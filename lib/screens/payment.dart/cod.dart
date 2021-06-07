import 'package:cached_network_image/cached_network_image.dart';
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
  double carttotal = userController.userModel.value.cart
      .fold(0, (previousValue, element) => previousValue + element.cost);
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
                      var totalPrice = userController.userModel.value.cart.fold(
                          0,
                          (previousValue, element) =>
                              previousValue + element.cost);

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
                          'totalprice': totalPrice
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
                            'totalprice': totalPrice
                          }).whenComplete(() {
                            widget.product.forEach((element) {
                              cartController.removeCartItem(element);
                            });
                            dismissLoadingWidget();
                            Get.defaultDialog(
                                barrierDismissible: false,
                                onConfirm: () =>
                                    Get.off(() => NavigationPage()),
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
                        'Pay Now',
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
              Column(
                children: widget.product.map((e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImage(
                            imageUrl: e.image,
                            height: 120,
                            width: 140,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.contain,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 14, top: 14.0),
                          child: Column(
                            children: [
                              Text(
                                e.name,
                                style: TextStyle(
                                    color: textblack,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14),
                                child: Text(
                                  "\₹${e.price} / ${e.variationtype}",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          direction: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Text(
                                " Quantity : ${e.quantity}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 30,
              ),
              ProfileDetails(
                  name: name, phone: phone, address: address, pincode: pincode),
            ],
          ),
          // bottomNavigationBar: SizedBox(
          //   // height: 70,
          //   child: BottomAppBar(
          //     child: Row(
          //       children: [
          //         Spacer(),
          //         // ignore: deprecated_member_use
          //         Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: OutlinedButton(
          //             style: ButtonStyle(
          //               side: MaterialStateProperty.all(
          //                   BorderSide(color: kprimarycolor)),
          //               foregroundColor: MaterialStateProperty.all(kprimarycolor),
          //             ),
          //             onPressed: () {

          //             },
          //             child: Text(
          //               'Place Order',
          //               style: TextStyle(fontSize: 17.5),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
        ),
      ),
    );
  }
}
