import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TopDeals extends StatelessWidget {
  const TopDeals({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        producsController.products.isEmpty
            ? Image.asset('assets/images/loading_card.gif')
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height * 0.32,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.38, crossAxisCount: 1),
                    itemCount: producsController.products.length,
                    itemBuilder: (context, index) {
                      var dataval = producsController.products[index];
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: CachedNetworkImage(
                                      imageUrl: dataval.photo[0],
                                      height: 190,
                                      width: 250,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        'assets/images/loading.gif',
                                        fit: BoxFit.contain,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        backgroundColor: textwhite,
                                        child: IconButton(
                                            icon: Icon(
                                              CupertinoIcons.heart,
                                              color: kprimarycolor,
                                            ),
                                            onPressed: () {}),
                                      ),
                                    ),
                                  ),
                                ],
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
                              Text(
                                dataval.name,
                                style: TextStyle(
                                    color: textblack,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17.0),
                              ),
                              Text(
                                  '₹ ${dataval.price} / ${dataval.variationtype}')
                            ],
                          ));
                    },
                  ),
                ),
              ),
      ],
    );
  }
}
