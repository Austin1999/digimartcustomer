class CartItemModel {
  static const ID = "id";
  static const IMAGE = "image";
  static const NAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";
  static const DISCOUNT = "discount";
  static const DOCID = 'docid';
  static const NUMBER = 'number';

  String id;
  String image;
  String name;
  String quantity;
  String cost;
  String productId;
  String price;
  String docid;
  int number;
  String discount;

  CartItemModel(
      {this.productId,
      this.id,
      this.image,
      this.name,
      this.price,
      this.quantity,
      this.number,
      this.discount,
      this.docid,
      this.cost});

  CartItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    name = data[NAME];
    quantity = data[QUANTITY];
    cost = data[COST];
    productId = data[PRODUCT_ID];
    price = data[PRICE];
    docid = data[DOCID];
    discount = data[DISCOUNT];
    number = data[NUMBER];
  }

  Map<String, dynamic> toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        NAME: name,
        QUANTITY: quantity,
        COST: cost,
        PRICE: price,
        DISCOUNT: discount,
        DOCID: docid,
        NUMBER: number,
      };
}

class OrderConfigModel {
  static const MINVALUE = 'minfee';
  static const MAXVALUE = 'maxfee';
  static const RANGE = 'range';
  String minfee;
  String maxfee;
  String range;
  OrderConfigModel({this.minfee, this.maxfee});
  OrderConfigModel.fromMap(data) {
    minfee = data[MINVALUE];
    maxfee = data[MAXVALUE];
    range = data[RANGE];
  }
}
