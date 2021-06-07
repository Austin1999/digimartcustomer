import 'dart:async';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  // RxList<ProductModel> categorisedproducts = RxList<ProductModel>([]);
  // String collection = "products";
  RxString string = 'All'.obs;
  String pincode = userController.userModel.value.pincode;
  RxList categories = RxList([]);
  RxList carousel = RxList([]);

  @override
  onReady() {
    super.onReady();
    products.bindStream(getAllProducts());
    carousel.bindStream(getCarousalLists());
    categories.bindStream(getCategoryLists());

    // categorisedproducts.bindStream(getCategoryProducts());
  }

  Stream<List> getCategoryLists() => firebaseFirestore
      .collection('category')
      .doc('categories')
      .snapshots()
      .map((query) => query
          .get('categories')
          .map((item) => CategoryModel.fromMap(item))
          .toList());

  Stream<List> getCarousalLists() => firebaseFirestore
      .collection('category')
      .doc('carousel')
      .snapshots()
      .map((query) => query.get('photourl'));

  Stream<List<ProductModel>> getAllProducts() => pincode == ''
      ? firebaseFirestore.collection("products").snapshots().map((query) =>
          query.docs.map((item) => ProductModel.fromMap(item.data())).toList())
      : firebaseFirestore
          .collection("products")
          .where('pincode',
              arrayContains: userController.userModel.value.pincode)
          .snapshots()
          .map((query) => query.docs
              .map((item) => ProductModel.fromMap(item.data()))
              .toList());

  // Stream<List<ProductModel>> getCategoryProducts(value) => firebaseFirestore
  //     .collection("products")
  //     .where('category', isEqualTo: value)
  //     .where('pincode', arrayContains: userController.userModel.value.pincode)
  //     .snapshots()
  //     .map((query) =>
  //         query.docs.map((item) => ProductModel.fromMap(item.data())).toList());
}
