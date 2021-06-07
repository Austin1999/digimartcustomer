import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kprimarycolor),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(color: kprimarycolor),
        ),
      ),
      body: Center(
        child: Text(
          "You Don't have any Notification",
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
    ));
  }
}
