import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/model/ordermodel.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  final OrderModel orders;
  final date;
  OrderDetailsPage({this.orders, this.date});
  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[50],
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: kprimarycolor),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
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
                      trailing: Text(
                        widget.orders.status,
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      primary: false,
                      children: [
                        Column(
                          children: widget.orders.item
                              .map(
                                (e) => ListTile(
                                  dense: true,
                                  title: Text(
                                    '${e.pname} x ${e.quantity}',
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
                        // ListTile(
                        //   dense: true,
                        //   title: Text(
                        //     'Subtotal',
                        //     style: Theme.of(context).textTheme.bodyText2,
                        //   ),
                        //   trailing: Text(
                        //     '₹${widget.orders.totalprice}',
                        //     style: TextStyle(color: textgrey),
                        //   ),
                        // ),
                        ListTile(
                          dense: true,
                          title: Text(
                            'Tax',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          trailing: Text(
                            '${widget.orders.tax}%',
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
                            '- ₹${widget.orders.discount.toString()}',
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
                            widget.orders.shippingfee == '0'
                                ? 'Free'
                                : '₹${widget.orders.shippingfee}',
                            style: TextStyle(color: textgrey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                child: ListTile(
                  dense: false,
                  title: Text(
                    'Total',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: Text(
                    '₹${widget.orders.totalprice}',
                    style: TextStyle(color: textgrey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    ListTile(
                      title: Text('Order Details',
                          style: Theme.of(context).textTheme.headline6),
                    ),
                    ListTile(
                      title: Text('Ordered On',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Text(widget.date,
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    ListTile(
                      title: Text('Shipping Address',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
                      child: Text(widget.orders.address,
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
