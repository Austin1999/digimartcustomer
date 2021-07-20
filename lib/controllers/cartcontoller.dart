import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digimartcustomer/constants/appconstants.dart';
import 'package:digimartcustomer/constants/controllers.dart';
import 'package:digimartcustomer/model/cartitemmodel.dart';
import 'package:digimartcustomer/model/productmodel.dart';
import 'package:digimartcustomer/model/usermodel.dart';
import 'package:digimartcustomer/screens/cart/cartpage.dart';
import 'package:digimartcustomer/screens/home/navigation.dart';
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

  void addProductToCart(ProductModel product, PriceItemModel quantity) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.rawSnackbar(
          mainButton: MaterialButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(Get.context,
                  MaterialPageRoute(builder: (context) {
                appController.selectedIndex.value = 1;
                return NavigationPage();
              }), (route) => false);
            },
            child: Text(
              'Go to MyCarts',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
          title: "Check your cart",
          message: "${product.name} is already added",
        );
      } else {
        String itemId = Uuid().v1().toString();
        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId,
              "number":1,
              "productId": product.productid,
              "name": product.name,
              "quantity": quantity.variation,
              "price": quantity.mrp,
              "image": product.photo[0],
              "cost":quantity.offerprice,
                  // quantity.replaceAll(RegExp("[A-Za-z]"), "").trim().length == 3
                  //     ? (int.parse(product.price) *
                  //             (int.parse(
                  //                     quantity
                  //                         .replaceAll(RegExp("[A-Za-z]"), "")
                  //                         .trim()) /
                  //                 1000))
                  //         .toString()
                  //     : (int.parse(product.price) *
                  //             (int.parse(quantity
                  //                 .replaceAll(RegExp("[A-Za-z]"), "")
                  //                 .trim())))
                  //         .toString(),
              'discount': quantity.offerprice,
              "docid": product.docid
            }
          ])
        });
        Get.rawSnackbar(
          mainButton: MaterialButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(Get.context,
                  MaterialPageRoute(builder: (context) {
                appController.selectedIndex.value = 1;
                return NavigationPage();
              }), (route) => false);
            },
            child: Text(
              'Go to MyCarts',
              style: TextStyle(color: Colors.yellow),
            ),
          ),
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
      item.number--;
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toJson()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    item.number++;
    // logger.i({"quantity": item.quantity});
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toJson()])
    });
  }
}
