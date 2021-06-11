import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/listview/photoview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GalleryView extends StatelessWidget {
  final int crossAxisCount;
  const GalleryView({Key key, this.crossAxisCount = 3});

  static const MethodChannel _channel = const MethodChannel('gallery_view');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            'My Orders',
            style: TextStyle(color: kprimarycolor),
          ),
        ),
        backgroundColor: Colors.grey[50],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: userController.userModel.value.listorders.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) {
                              return ViewPhotos(
                                imageIndex: index,
                                imageList:
                                    userController.userModel.value.listorders,
                                heroTitle: "image$index",
                              );
                            },
                            fullscreenDialog: true));
                  },
                  child: Container(
                    child: Hero(
                        tag: "photo$index",
                        child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl:
                              userController.userModel.value.listorders[index],
                          placeholder: (context, url) => Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.contain,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
