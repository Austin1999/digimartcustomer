import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget {
  const HomeAppbar({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      color: kprimarycolor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  kappname,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textwhite,
                      fontSize: 22),
                ),
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: textwhite,
                      size: 28,
                    ),
                    onPressed: () {})
              ],
            ),
            InkWell(
              // onTap: () => Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ListSearch(
              //       prodlist:
              //           data.productList.map((e) => e.name).toList(),
              //     ),
              //   ),
              // ),
              child: Container(
                height: size.height * 0.06,
                width: size.width * 0.95,
                child: Card(
                  child: SizedBox(
                    width: size.width * 0.8,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search...',
                              style: TextStyle(color: kprimarycolor),
                            ),
                            Icon(
                              Icons.search,
                              color: kprimarycolor,
                            )
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
