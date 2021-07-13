import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/detail/detailscreen.dart';
import 'package:digimartcustomer/screens/profile/myprofile.dart';
import 'package:digimartcustomer/screens/search/searchpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class FeaturedPage extends StatefulWidget {
  @override
  _FeaturedPageState createState() => _FeaturedPageState();
}

class _FeaturedPageState extends State<FeaturedPage> {
  final ScrollController scrollController = ScrollController();
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(scrollListener);
    // producsController.getNextProducts(true,'featured');
  }
    @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent/2 ) {
      if (producsController.hasNext.value) {
        producsController.getNextProducts(true,'featured');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            'Featured products',
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        body: SingleChildScrollView(
controller: scrollController,
          child: Container(
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
                    'Featured',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Products Featured by brands',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: textgrey),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.count(
                      // controller: scrollController,
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
                            .where((string) => string.featured == true)
                            .toList()
                            .length,
                        (index) {
                          var dataval = producsController.products
                              .where((string) => string.featured == true)
                              .toList()[index];
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
                                    errorWidget: (context, url, error) => Image.asset(
                                            'assets/images/loading.gif',
                                            fit: BoxFit.contain,
                                          ),
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
                                            .copyWith(color: Colors.red),
                                      )
                                    : !dataval.pincode.contains(
                                            userController
                                                .userModel.value.pincode)
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
                                                    color: Colors.green),
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
                                  style:
                                      Theme.of(context).textTheme.bodyText1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2),
                                Text(
                                  '${dataval.dummy.first.offerprice} / ${dataval.dummy.first.variation}',
                                  style:
                                      Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          );
                        },
                      ),
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
