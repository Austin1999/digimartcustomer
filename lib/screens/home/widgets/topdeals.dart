import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/detail/detailscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class TopDeals extends StatelessWidget {
  const TopDeals({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

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
              'Deals of the day',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Deals you don't want to miss",
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 14, color: textgrey),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
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
                      .where((string) => string.onsale == true)
                      .toList()
                      .length,
                  (index) {
                    var dataval = producsController.products
                        .where((string) => string.onsale == true)
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
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: <Widget>[
                          Column(
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  placeholder: (context, url) => Image.asset(
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
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2),
                              Text(
                                '${dataval.price} / ${dataval.variationtype}',
                                style: Theme.of(context).textTheme.caption,
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
                                cartController.addProductToCart(dataval);
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
          ),
        ],
      ),
    );
  }
}
