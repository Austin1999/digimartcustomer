import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/screens/payment.dart/cod.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentMethod extends StatefulWidget {
  final List<CartItemModel> product;
  // final CartItemModel productlist;
  PaymentMethod({this.product});
  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Payment Method',
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(vertical: 0),
                  title: Text(
                    'Cash on Delivery',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text('Select your preferred payment mode'),
                ),
              ),
              InkWell(
                splashColor: Theme.of(context).accentColor,
                focusColor: Theme.of(context).accentColor,
                highlightColor: Theme.of(context).primaryColor,
                onTap: () => Get.to(() => COD(
                      product: widget.product,
                    )),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.1),
                          blurRadius: 5,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          image: DecorationImage(
                              image: AssetImage('assets/images/cash.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(width: 15),
                      Flexible(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Cash on Delivery',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                                  Text(
                                    'description',
                                    // paymentMethod.description,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.keyboard_arrow_right,
                              color: Theme.of(context).focusColor,
                            ),
                          ],
                        ),
                      )
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
