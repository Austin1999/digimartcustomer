import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.rawSnackbar(
          title: "Check your cart",
          message: "${product.name} is already added",
        );
      } else {
        String itemId = Uuid().v1().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              'variationtype': product.variationtype,
              "id": itemId,
              "productId": product.productid,
              "name": product.name,
              "quantity": 1,
              "price": product.price,
              "image": product.photo[0],
              "cost": product.price,
              'discount': product.discount,
              "docid": product.docid
            }
          ])
        });
        Get.rawSnackbar(
          title: "Item added",
          message: "${product.name} was added to your cart",
        );
      }
    } catch (e) {
      Get.rawSnackbar(
        title: "Error",
        message: "Cannot add this item",
      );
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toJson()])
      });
    } catch (e) {
      Get.rawSnackbar(
        title: "Error",
        message: "Cannot remove this item",
      );
      debugPrint(e.message);
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart.isNotEmpty) {
      userModel.cart.forEach((cartItem) {
        totalCartPrice += double.parse(cartItem.cost);
      });
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userModel.value.cart
          .where((item) => item.productId == product.productid)
          .isNotEmpty;

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      item.quantity--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    item.quantity++;
    // logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
