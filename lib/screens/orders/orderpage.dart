import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/listview/galleryview.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'orderdetails.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: kprimarycolor),
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              'My Orders',
              style: TextStyle(color: kprimarycolor),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.list),
                onPressed: () => Get.to(() => GalleryView()),
              ),
            ],
          ),
          body: Obx(
            () => orderController.orders.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "You don't have any orders yet",
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: orderController.orders.length,
                    itemBuilder: (context, index) {
                      var data = orderController.orders[index];

                      String formattedDate = DateFormat('EEE, d-M-y | hh:mm')
                          .format(data.datetime.toDate());
                      return Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => Get.to(() => OrderDetailsPage(
                                  date: formattedDate,
                                  orders: data,
                                )),
                            child: Container(
                              height: 130,
                              padding: const EdgeInsets.all(0),
                              child: Row(children: [
                                // Expanded(
                                //   flex: 5,
                                //   child: Padding(
                                //     padding: const EdgeInsets.all(8.0),
                                //     child: CachedNetworkImage(
                                //       imageUrl: data.item[0].image,
                                //       imageBuilder: (context, imageProvider) =>
                                //           Container(
                                //         decoration: BoxDecoration(
                                //           image: DecorationImage(
                                //               image: imageProvider,
                                //               fit: BoxFit.cover),
                                //           borderRadius:
                                //               BorderRadius.circular(5),
                                //         ),
                                //       ),
                                //       placeholder: (context, url) =>
                                //           Image.asset(
                                //         'assets/images/loading.gif',
                                //         fit: BoxFit.contain,
                                //       ),
                                //     ),
                                //   ),
                                // ),

                                Expanded(
                                  child: Container(
                                    padding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          data.item
                                              .map((e) => e.pname)
                                              .toString()
                                              .replaceAll('(', '')
                                              .replaceAll(')', ''),
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Theme.of(context).textTheme.subtitle1,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          '₹${data.item[0].price}/${data.item[0].cost}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text('Ordered On : $formattedDate'),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          'Status : ${data.status}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                  color:
                                                      data.status == 'Cancelled'
                                                          ? Colors.red
                                                          : Colors.green),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ]),
                            ),
                          ));
                    },
                  ),
          )),
    );
  }
}
