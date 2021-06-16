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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CachedNetworkImage(
              imageUrl: item.photourl,
              placeholder: (context, url) => Image.asset(
                'assets/images/loading.gif',
                fit: BoxFit.contain,
              ),
            ),
            Text(
              item.title,
              overflow: TextOverflow.fade,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.5),
            )
          ],
        ),
        onTap: () {
          Get.to(() => CategoryListpage(searchresult: item.title));
        },
      );
    }

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
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          ListTile(
            title: Text(
              'Categories',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          producsController.categories.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'No Categories Available',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                )
              : Obx(
                  () => GridView.count(
                    primary: false,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(0),
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    crossAxisCount: 4,
                    childAspectRatio: ((width) / 500),
                    children: List.generate(producsController.categories.length,
                        (index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: getStructuredGridCell(
                            producsController.categories[index]),
                      );
                    }),
                  ),
                ),
        ],
      ),
    );
  }
}
