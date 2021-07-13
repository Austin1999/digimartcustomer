import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ProductModel {
  static const NAME = "name";
  static const CATEGORY = "category";
  static const PHOTO = "photo_url";
  static const QUANTITY = "quantity";
  static const ONSALE = "onsale";
  static const DESCRIPTION = "description";
  static const FEATURED = "featured";
  static const PRODUCTID = "product_id";
  static const PINCODE = "pincode";
  static const BRAND = 'brand';
  static const DUMMYPRICE = 'price';

  String name;
  String category;
  List photo;
  String brand;
  List pincode;
  List<PriceItemModel> dummy;
  var quantity;
  bool onsale;
  String description;
  bool featured;
  String productid;
  DocumentSnapshot doc;
  String docid;
  ProductModel({
    this.name,
    this.category,
    this.description,
    this.doc,
    this.brand,
    this.pincode,
    this.featured,
    this.onsale,
    this.photo,
    this.productid,
    this.quantity,
    this.dummy,
    this.docid,
  });

  ProductModel.fromMap(
      Map<String, dynamic> data, documentid, DocumentSnapshot docval) {
    name = data[NAME];
    category = data[CATEGORY];
    brand = data[BRAND];
    doc = docval;
    description = data[DESCRIPTION];
    featured = data[FEATURED];
    onsale = data[ONSALE];
    photo = data[PHOTO];
    productid = data[PRODUCTID];
    quantity = data[QUANTITY];
    pincode = data[PINCODE];
    docid = documentid;
    dummy = _convertPriceItems(data[DUMMYPRICE] ??
        [
          {"mrp": '85', "variation": '750G', "offerprice": '75'}
        ]);
  }

  List<PriceItemModel> _convertPriceItems(List priceFomDb) {
    List<PriceItemModel> _result = [];
    if (priceFomDb.length > 0) {
      priceFomDb.forEach((element) {
        _result.add(PriceItemModel.fromMap(element));
      });
    }
    return _result;
  }
}

class PriceItemModel {
  static const MRP = 'mrp';
  static const OFFERRPRICE = 'offerprice';
  static const VARIATION = 'variation';
  String mrp;
  String offerprice;
  String variation;
  PriceItemModel({this.mrp, this.offerprice, this.variation});

  PriceItemModel.fromMap(Map<String, dynamic> data) {
    mrp = data[MRP] ?? '0.0';
    offerprice = data[OFFERRPRICE] ?? '0.0';
    variation = data[VARIATION] ?? '0Kg';
  }
}

class CategoryModel {
  static const PHOTOURL = "photo_url";
  static const TITLE = "title";

  // List<Product> productList = [];
  String title;
  String photourl;

  CategoryModel({
    this.title,
    this.photourl,
  });

  CategoryModel.fromMap(Map<String, dynamic> data) {
    title = data[TITLE];
    photourl = data[PHOTOURL];
  }
}
