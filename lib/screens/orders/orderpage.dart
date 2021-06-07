import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
          ),
          body: orderController.orders.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "You don't have any orders yet",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                )
              : Obx(
                  () => ListView.builder(
                    itemCount: orderController.orders.length,
                    itemBuilder: (context, index) {
                      var data = orderController.orders[index];

                      String formattedDate = DateFormat('EEE, d-M-y | hh:mm')
                          .format(data.datetime.toDate());
                      return Container(
                        height: 130,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                        child: Row(children: [
                          Expanded(
                            flex: 6,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: data.item[0].image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
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
                          Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    data.item[0].pname,
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Quantity : ${data.item[0].quantity} ${data.item[0].variationtype}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Price : ${data.item[0].cost}',
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Align(
                                    child: data.item.length > 1
                                        ? Text(
                                            '+${(data.item.length - 1)} item',
                                            style: TextStyle(fontSize: 14.0),
                                          )
                                        : Container(),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Ordered On',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(fontSize: 14.0),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data.status,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {}, child: Text('View More'))
                            ],
                          ),
                        ]),
                      );
                    },
                  ),
                )),
    );
  }
}
