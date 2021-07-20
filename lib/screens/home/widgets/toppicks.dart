import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/detail/detailscreen.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
import 'package:digimartcustomer/screens/topdeals/topdeals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class TopPicks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Top Picks For You',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Hand Picked Products for you",
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, color: textgrey),
            ),
          ),
          producsController.products.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Sorry, No Products Available',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: 6,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        primary: false,
                        itemBuilder: (context, index) {
                          var dataval = producsController.products[Random()
                              .nextInt(producsController.products.length)];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailScreen(product: dataval)));
                              // Get.to(() => DetailScreen(product: dataval));
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: CachedNetworkImage(
                                      imageUrl: dataval.photo[0],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/loading.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  dataval.quantity == 0
                                      ? Text(
                                          'Out of Stock',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(color: Colors.red),
                                        )
                                      : !dataval.pincode.contains(userController
                                              .userModel.value.pincode)
                                          ? Text(
                                              'Not Deliverable',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(color: Colors.red),
                                            )
                                          : Text(
                                              'Deliverable',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                      color: Colors.green),
                                            ),
                                  SizedBox(height: 5),
                                  Text(
                                    dataval.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    '${dataval.dummy.first.offerprice} / ${dataval.dummy.first.variation}',
                                    style: Theme.of(context).textTheme.caption,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                          );
                        },
                      ),
                    ),
                  ),
                      ],
      ),
    );
  }
}
