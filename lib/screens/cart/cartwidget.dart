import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:flutter/material.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemWidget({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        // onTap: () => Get.to(() => DetailScreen(
        //       product: data,
        //     )),

        child: Container(
      height: MediaQuery.of(context).size.height / 5.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 140.0,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: cartItem.image,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      // width: (MediaQuery.of(context).size.width - 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${cartItem.name}',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            '₹${cartItem.price} / ₹${cartItem.variationtype}',
                            style: TextStyle(
                              color: kprimarycolor,
                              fontSize: 15.0,
                            ),
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  text: 'Price:  ',
                                  style: TextStyle(
                                      fontSize: 15.0, color: Colors.grey),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' ${cartItem.cost}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: kprimarycolor,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.delete_outline),
                onPressed: () {
                  print(cartItem);
                  print(cartItem.toJson());
                  firebaseFirestore
                      .collection(userController.usersCollection)
                      .doc(userController.firebaseUser.value.uid)
                      .update({
                    'cart': FieldValue.arrayRemove([cartItem.toJson()])
                  });
                  // cartController.removeCartItem(cartItem);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: () {
                        cartController.decreaseQuantity(cartItem);
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cartItem.quantity.toString(),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: () {
                        cartController.increaseQuantity(cartItem);
                      }),
                ],
              ),
            ],
          ),
        ],
      ),
    ));
    // return Padding(
    //   padding: const EdgeInsets.only(top: 8.0),
    //   child: Column(
    //     children: [
    //       Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           ClipRRect(
    //             borderRadius: BorderRadius.circular(12.0),
    //             child: CachedNetworkImage(
    //               imageUrl: cartItem.image,
    //               height: 100,
    //               width: 100,
    //               fit: BoxFit.cover,
    //               placeholder: (context, url) => Image.asset(
    //                 'assets/images/loading.gif',
    //                 fit: BoxFit.contain,
    //               ),
    //               errorWidget: (context, url, error) => Icon(Icons.error),
    //             ),
    //           ),
    //           Container(
    //             child: Column(
    //               children: [
    //                 Text(
    //                   cartItem.name,
    //                   style: TextStyle(
    //                       color: textblack,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 18.0),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     "\₹${cartItem.price} / ${cartItem.variationtype}",
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    // Wrap(
    //   alignment: WrapAlignment.spaceBetween,
    //   crossAxisAlignment: WrapCrossAlignment.end,
    //   direction: Axis.vertical,
    //   children: [
    //     IconButton(
    //       icon: Icon(Icons.delete_outline),
    //       onPressed: () {
    //         print(cartItem.toJson());
    //         firebaseFirestore
    //             .collection(userController.usersCollection)
    //             .doc(userController.firebaseUser.value.uid)
    //             .update({
    //           'cart': [cartItem.toJson()]
    //         });
    //         // cartController.removeCartItem(cartItem);
    //       },
    //     ),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         IconButton(
    //             icon: Icon(Icons.chevron_left),
    //             onPressed: () {
    //               cartController.decreaseQuantity(cartItem);
    //             }),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             cartItem.quantity.toString(),
    //           ),
    //         ),
    //         IconButton(
    //             icon: Icon(Icons.chevron_right),
    //             onPressed: () {
    //               cartController.increaseQuantity(cartItem);
    //             }),
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.all(14),
    //       child: Text(
    //         "\₹${cartItem.cost}",
    //         style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    //       ),
    //     ),
    //   ],
    // );
    // ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
