import 'dart:async';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/model/ordermodel.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController instance = Get.find();
  RxList<OrderModel> orders = RxList<OrderModel>([]);
  OrderConfigModel ordercongig = OrderConfigModel();
  String collection = "orders";

  @override
  onReady() async {
    super.onReady();
    orders.bindStream(getAllOrders());
    ordercongig = await getorderconfigs();
  }

  Stream<List<OrderModel>> getAllOrders() => firebaseFirestore
      .collection('users')
      .doc(auth.currentUser.uid)
      .collection('orders')
      .orderBy('datetime', descending: true)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => OrderModel.fromMap(item.data())).toList());

  Future<OrderConfigModel> getorderconfigs() async => await firebaseFirestore
      .collection('settings')
      .doc('deliveryoptions')
      .get()
      .then((value) => OrderConfigModel.fromMap(value.data()));
}
