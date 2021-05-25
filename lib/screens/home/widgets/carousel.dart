import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          viewportFraction: 1,
          aspectRatio: 2,
          enlargeCenterPage: true,
        ),
        items: producsController.carousel
            .map(
              (item) => Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: CachedNetworkImage(
                    imageUrl: item,
                    width: 1200,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      'assets/images/loading.gif',
                      fit: BoxFit.contain,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
