import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/constants/firebase.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:get/get.dart';

class ProducsController extends GetxController {
  static ProducsController instance = Get.find();
  RxList<ProductModel> products = RxList<ProductModel>([]);
  // RxList<ProductModel> categorisedproducts = RxList<ProductModel>([]);
  // String collection = "products";
  int doclimit = 15;
  RxBool hasNext = true.obs;
  RxBool isFetchingProducts = false.obs;
  RxString string = 'All'.obs;
  RxString pincode = userController.userModel.value.pincode.obs;
  RxList categories = RxList([]);
  RxList carousel = RxList([]);
  var length;

  @override
  onReady() {
    super.onReady();
    // products.bindStream(getAllProducts());
    carousel.bindStream(getCarousalLists());
    categories.bindStream(getCategoryLists());
    producsController.getNextProducts(null,null);
    // getNextProducts();
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

  static Future<QuerySnapshot> getProducts(limit,name,
      {DocumentSnapshot startAfter,category}) async {
        print(category);
    final refproducts = firebaseFirestore.collection('products').orderBy('product_id').limit(limit);
if(category == null){
    if (startAfter == null) {
      return refproducts.get();
    } else {
      return refproducts.startAfterDocument(startAfter).get();
    }
    
  }else{
    if (startAfter == null) {
      return refproducts.where(name,isEqualTo:category).get();
    } else {
      return refproducts.where(name,isEqualTo:category).startAfterDocument(startAfter).get();
    }
  }
      }

  Future getNextProducts(category,name) async {
    if (isFetchingProducts.value) return;
    isFetchingProducts.value = true;
    try {
      print(products);
      QuerySnapshot snap = await getProducts(doclimit,name,startAfter:products.isEmpty?null: products.last.doc,category: category);
      products
          .addAll(snap.docs.map((e) => ProductModel.fromMap(e.data(), e.id, e)));
          print(products);
      if (snap.docs.length < doclimit) hasNext.value = false;
    } catch (e) {
      print(e.toString());
    }
    isFetchingProducts.value = false;
  }
  // Stream<List<ProductModel>> getAllProducts() =>
  //     // userController.userModel.value.pincode == ''
  //     //     ?
  //     firebaseFirestore.collection("products").snapshots().map((query) => query
  //         .docs
  //         .map((item) => ProductModel.fromMap(item.data(), item.id))
  //         .toList());
}
