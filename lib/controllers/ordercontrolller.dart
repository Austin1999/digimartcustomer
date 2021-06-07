import 'dart:async';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/ordermodel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  String collection = "orders";

  @override
  onReady() {
    super.onReady();
    orders.bindStream(getAllOrders());
  }

  Stream<List<OrderModel>> getAllOrders() => firebaseFirestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('orders')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());
}
