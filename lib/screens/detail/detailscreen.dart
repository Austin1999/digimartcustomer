import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
import 'package:digimartcustomer/screens/search/searchpage.dart';
import '../drawer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class DetailScreen extends StatefulWidget {
  ProductModel product;
  DetailScreen({this.product});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Get.to(() => ListSearch()),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
              child: Badge(
                elevation: 0,
                // padding: EdgeInsets.all(3.0),
                shape: BadgeShape.square,
                borderRadius: BorderRadius.circular(8),
                badgeContent: SizedBox(
                  height: 12,
                  child: Text(
                    userController.userModel.value.cart?.length.toString(),
                    style: TextStyle(color: textwhite, fontSize: 10.0),
                  ),
                ),
                child: InkWell(
                    onTap: () => Get.off(() => ShoppingCartWidget()),
                    child: Icon(Icons.shopping_cart)),
              ),
            ),
          ],
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            widget.product.name,
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
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
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.product.photo[0],
                            height: size.width * 0.5,
                            width: size.width * 0.9,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/loading.gif',
                              fit: BoxFit.contain,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '??? ${widget.product.price} Per/ ${widget.product.variationtype} ',
                                  style: TextStyle(
                                      decoration: widget.product.onsale
                                          ? TextDecoration.lineThrough
                                          : null,
                                      color: widget.product.onsale
                                          ? textgrey
                                          : textblack,
                                      fontWeight: widget.product.onsale
                                          ? FontWeight.normal
                                          : FontWeight.bold,
                                      fontSize:
                                          widget.product.onsale ? 14 : 18),
                                ),
                              ),
                              widget.product.onsale
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '??? ${widget.product.discount} Per/ ${widget.product.variationtype} ',
                                        style: TextStyle(
                                            color: textblack,
                                            fontWeight: FontWeight.bold,
                                            fontSize: widget.product.onsale
                                                ? 14
                                                : 18),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          Spacer(),
                          // ignore: deprecated_member_use
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: OutlinedButton(
                              style: ButtonStyle(
                                side: MaterialStateProperty.all(BorderSide(
                                    color: widget.product.quantity == 0 ||
                                            !widget.product.pincode.contains(
                                                userController
                                                    .userModel.value.pincode)
                                        ? Colors.red
                                        : kprimarycolor)),
                                foregroundColor: MaterialStateProperty.all(
                                    widget.product.quantity == 0 ||
                                            !widget.product.pincode.contains(
                                                userController
                                                    .userModel.value.pincode)
                                        ? Colors.red
                                        : kprimarycolor),
                              ),
                              onPressed: () {
                                if (userController
                                    .userModel.value.address.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Complete your profile'),
                                        content: Text(
                                            'Please add your address and pincode to your profile section'),
                                        actions: [
                                          RaisedButton(
                                              color: kprimarycolor,
                                              child: Text(
                                                'Go to my Profile',
                                                style:
                                                    TextStyle(color: textwhite),
                                              ),
                                              onPressed: () {
                                                Get.to(() => MyProfile());
                                              })
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  widget.product.quantity == 0
                                      ? null
                                      : widget.product.pincode.contains(
                                              userController
                                                  .userModel.value.pincode)
                                          ? cartController
                                              .addProductToCart(widget.product)
                                          : null;
                                }
                              },
                              child: Text(
                                widget.product.quantity == 0
                                    ? 'Out of Stock'
                                    : widget.product.pincode.contains(
                                            userController
                                                .userModel.value.pincode)
                                        ? 'Add to Cart'
                                        : 'Not Deliverable',
                                style: TextStyle(fontSize: 17.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.product.quantity < 10 &&
                              widget.product.quantity != 0
                          ? Padding(
                              padding: const EdgeInsets.only(
                                  left: 16.0, right: 16.0),
                              child: Text(
                                'Hurry! Only Few Left',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: Colors.red,
                                    ),
                              ),
                            )
                          : Container(),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Row(children: [
                          Text(
                            'Shipping Price',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Spacer(),
                          Text(
                            orderController.ordercongig.shippingfee == '0'
                                ? 'Free'
                                : '???${orderController.ordercongig.shippingfee}',
                            style: TextStyle(color: textgrey),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 16.0),
                        child: Row(children: [
                          Text(
                            'Tax',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          Spacer(),
                          Text(
                            '${orderController.ordercongig.tax}%',
                            style: TextStyle(color: textgrey),
                          ),
                        ]),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 14.0),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text(
                          widget.product.description,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: textgrey,
                          ),
                        ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Products you might Like',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.count(
                          crossAxisCount: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? 2
                              : 4,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          primary: false,
                          children: List.generate(
                            producsController.products
                                .where((value) =>
                                    value.productid != widget.product.productid)
                                .toList()
                                .length,
                            (index) {
                              var products = producsController.products
                                  .where((value) =>
                                      value.productid !=
                                      widget.product.productid)
                                  .toList();
                              var dataval = products[index];
                              // if(dataval.name != widget.product.name)
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailScreen(product: dataval)));
                                  // Get.to(() => DetailScreen(product: dataval));
                                },
                                child: Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: dataval.photo[0],
                                            imageBuilder:
                                                (context, imageProvider) =>
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
                                                    .copyWith(
                                                        color: Colors.red),
                                              )
                                            : !dataval.pincode.contains(
                                                    userController.userModel
                                                        .value.pincode)
                                                ? Text(
                                                    'Not Deliverable',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                            color: Colors.red),
                                                  )
                                                : Text(
                                                    'Deliverable',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                            color:
                                                                Colors.green),
                                                  ),
                                        // RatingBarIndicator(
                                        //   rating: double.parse(dataval.rating),
                                        //   itemBuilder: (context, index) => Icon(
                                        //     Icons.star,
                                        //     color: Colors.amber,
                                        //   ),
                                        //   itemCount: 5,
                                        //   itemSize: 22.0,
                                        //   direction: Axis.horizontal,
                                        // ),
                                        SizedBox(height: 5),
                                        Text(
                                          dataval.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          '${dataval.price} / ${dataval.variationtype}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      width: 40,
                                      height: 40,
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          cartController
                                              .addProductToCart(dataval);
                                        },
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          color: textwhite,
                                          size: 24,
                                        ),
                                        color: kprimarycolor,
                                        shape: StadiumBorder(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // bottomNavigationBar: SizedBox(
        //   // height: 70,
        //   child: BottomAppBar(
        //     child:
        //     ),
        // ),
      ),
    );
  }
}
