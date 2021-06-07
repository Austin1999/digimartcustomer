import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'products/categoryresult.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            userController.firebaseUser.value != null
                ? UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      userController.userModel.value.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    accountEmail: Text(
                      userController.userModel.value.phone,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: kprimarycolor,
                      child: Text(
                        userController.userModel.value.name[0],
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(color: Colors.white),
                      ),
                      // backgroundImage:
                      //     NetworkImage(currentUser.value.image.pthumb),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context).accentColor.withOpacity(1),
                        ),
                        SizedBox(width: 30),
                        Text(
                          'Guest',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
            ListTile(
              title: Text('Home'),
              leading: Icon(
                Icons.home,
              ),
            ),
            ListTile(
              title: Text('Orders'),
              leading: Icon(
                Icons.list,
              ),
            ),
            ListTile(
              title: Text('Categories'),
              // leading: Icon(
              //   Icons.home,
              // ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: producsController.categories.length,
              itemBuilder: (context, index) {
                var element = producsController.categories[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () => Get.to(
                        () => CategoryListpage(searchresult: element.title)),
                    title: Text(element.title),
                    leading: SizedBox(
                      width: 50,
                      child: CachedNetworkImage(
                        imageUrl: element.photourl,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        placeholder: (context, url) => Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
