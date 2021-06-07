import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/screens/detail/detailscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ProductsListpage extends StatefulWidget {
  final String searchresult;
  ProductsListpage({@required this.searchresult});
  @override
  _ProductsListpageState createState() => _ProductsListpageState();
}

class _ProductsListpageState extends State<ProductsListpage> {
  @override
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
        .where((string) => string.name
            .toLowerCase()
            .contains(widget.searchresult.toLowerCase()))
        .toList();
    print(datalist);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: kprimarycolor),
          backgroundColor: Colors.grey[50],
          elevation: 0,
          title: Text(
            'Search Result',
            style: TextStyle(color: kprimarycolor),
          ),
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
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data.photo[0]),
                                    fit: BoxFit.fill)),
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
                              Text(
                                data.name,
                                style: Theme.of(context).textTheme.title,
                              ),
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
                              RatingBarIndicator(
                                rating: data.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 22.0,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text('View More'))
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
