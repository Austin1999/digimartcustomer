import 'package:cached_network_image/cached_network_image.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/products/categoryresult.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    InkWell getStructuredGridCell(CategoryModel category) {
      final item = category;
      return InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: item.photourl,
              height: 50,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
              child: Text(
                item.title,
                overflow: TextOverflow.fade,
                style: TextStyle( fontSize: 8.5,fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        onTap: () {
          Get.to(() => CategoryListpage(searchresult: item.title));
        },
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        ListTile(
          title: Text(
            'What are you looking For?',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Obx(
                () =>producsController.categories.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'No Categories Available',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            :  Padding(
                  padding: const EdgeInsets.only(left:8.0,right: 8.0),
                  child: GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    crossAxisCount:  MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? 4
                          : 6,
                    childAspectRatio: 0.93,
                    children: List.generate(producsController.categories.length,
                        (index) {
                      return Container(
                        margin:
                            EdgeInsets.only(bottom: 10, left: 10),
                        decoration: BoxDecoration(
                          color: textwhite,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                color:
                                    Theme.of(context).hintColor.withOpacity(0.15),
                                offset: Offset(0, 3),
                                blurRadius: 10)
                          ],
                        ),
                        child: getStructuredGridCell(
                            producsController.categories[index]),
                      );
                    }),
                  ),
                ),
              ),
      ],
    );
  }
}
