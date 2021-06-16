import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
import 'package:digimartcustomer/screens/products/productsresult.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> {
  TextEditingController _textController = TextEditingController();
  List newDataList =
      producsController.products.map((element) => element.name).toList();

  @override
  Widget build(BuildContext context) {
    // List<String> newDataList = List.from(mainDataList);

    onItemChanged(String value) {
      setState(() {
        newDataList = producsController.products
            .map((element) => element.name)
            .toList()
            .where(
                (string) => string.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                autofocus: true,
                controller: _textController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: Icon(
                      Icons.close,
                    ),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pushAndRemoveUntil(Get.context,
                          MaterialPageRoute(builder: (context) {
                        appController.selectedIndex.value = 0;
                        return NavigationPage();
                      }), (route) => false);
                      _textController.clear();
                    },
                  ),
                  hintText: 'Search Here...',
                ),
                onChanged: onItemChanged,
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(12.0),
                children: newDataList.map((data) {
                  return ListTile(
                    title: Text(data),
                    onTap: () =>
                        Get.to(() => ProductsListpage(searchresult: data)),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
