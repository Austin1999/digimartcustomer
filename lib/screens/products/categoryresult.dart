import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/detail/detailscreen.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/screens/search/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../drawer.dart';

class CategoryListpage extends StatefulWidget {
  final String searchresult;
  CategoryListpage({@required this.searchresult});
  @override
  _CategoryListpageState createState() => _CategoryListpageState();
}

class _CategoryListpageState extends State<CategoryListpage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> datalist = producsController.products
        .where((string) => string.category
            .toLowerCase()
            .contains(widget.searchresult.toLowerCase()))
        .toList();
    print(datalist);
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
                  child: Obx(
                    () => Text(
                      userController.userModel.value.cart?.length.toString(),
                      style: TextStyle(color: textwhite, fontSize: 10.0),
                    ),
                  ),
                ),
                child: InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(Get.context,
                            MaterialPageRoute(builder: (context) {
                          appController.selectedIndex.value = 1;
                          return NavigationPage();
                        }), (route) => false),
                    child: Icon(Icons.shopping_cart)),
              ),
            ),
          ],
          backgroundColor: Colors.grey[50],
          title: Text(
            widget.searchresult,
            style: TextStyle(color: kprimarycolor),
          ),
          elevation: 0,
          iconTheme: IconThemeData(color: kprimarycolor),
        ),
        body: ListView.builder(
          itemCount: datalist.length,
          itemBuilder: (context, index) {
            var data = datalist[index];

            return Card(
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Get.to(() => DetailScreen(
                        product: data,
                      )),
                  child: Container(
                    height: 130,
                    padding: const EdgeInsets.all(0),
                    child: Row(children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: data.photo[0],
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
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 5,
                        child: Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(data.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.fade,
                                  style: Theme.of(context).textTheme.subtitle1),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '₹${data.price}/${data.variationtype}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              data.quantity == 0
                                  ? Text(
                                      'Out of Stock',
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2
                                          .copyWith(color: Colors.red),
                                    )
                                  : !data.pincode.contains(userController
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
                                              .copyWith(color: Colors.green),
                                        ),
                              // RatingBarIndicator(
                              //   rating: double.parse(data.rating),
                              //   itemBuilder: (context, index) => Icon(
                              //     Icons.star,
                              //     color: Colors.amber,
                              //   ),
                              //   itemCount: 5,
                              //   itemSize: 22.0,
                              //   direction: Axis.horizontal,
                              // ),
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
      ),
    );
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
