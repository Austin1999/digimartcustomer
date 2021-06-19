import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    Key key,
    @required this.name,
    @required this.phone,
    @required this.address,
    @required this.pincode,
  }) : super(key: key);

  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController address;
  final TextEditingController pincode;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: ListTile(
                title: Text(
                  'Name',
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.65,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 40.0,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle,
                      decoration: InputDecoration(
                        fillColor: kprimarycolor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                      controller: name,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Phone',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.65,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 40.0,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle,
                      decoration: InputDecoration(
                        fillColor: kprimarycolor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                      controller: phone,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Address',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.65,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: TextField(
                    minLines: 6,
                    maxLines: 7,
                    style: Theme.of(context).textTheme.subtitle,
                    decoration: InputDecoration(
                      fillColor: kprimarycolor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                    ),
                    controller: address,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: size.width * 0.3,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 16.0),
                  child: Text(
                    'Pincode',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * 0.65,
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 40.0,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle,
                      decoration: InputDecoration(
                        fillColor: kprimarycolor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                      controller: pincode,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
