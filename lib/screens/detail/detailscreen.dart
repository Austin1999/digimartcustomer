import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(children: <Widget>[
                IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () => Get.off(() => ShoppingCartWidget())),
                new Obx(
                  () => Positioned(
                    // draw a red marble
                    top: 0.0,
                    right: 0.0,
                    child: new CircleAvatar(
                      radius: 6.5,
                      backgroundColor: Colors.red,
                      child: Text(
                        userController.userModel.value.cart?.length.toString(),
                        style: TextStyle(color: textwhite, fontSize: 12.0),
                      ),
                    ),
                  ),
                ),
              ]),
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
                          widget.product.name,
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
                                        RatingBarIndicator(
                                          rating: dataval.rating,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 22.0,
                                          direction: Axis.horizontal,
                                        ),
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
        bottomNavigationBar: SizedBox(
          // height: 70,
          child: BottomAppBar(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '₹ ${widget.product.price} Per/ ${widget.product.variationtype} ',
                    style: TextStyle(
                        color: textblack,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Spacer(),
                // ignore: deprecated_member_use
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                          BorderSide(color: kprimarycolor)),
                      foregroundColor: MaterialStateProperty.all(kprimarycolor),
                    ),
                    onPressed: () {
                      if (userController.userModel.value.address.isEmpty) {
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
                                      style: TextStyle(color: textwhite),
                                    ),
                                    onPressed: () {
                                      Get.to(() => MyProfile());
                                    })
                              ],
                            );
                          },
                        );
                      } else {
                        cartController.addProductToCart(widget.product);
                      }
                    },
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(fontSize: 17.5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
