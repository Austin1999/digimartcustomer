class OrderModel {
  static const ITEM = "item";
  static const TOTALPRICE = "totalprice";
  static const PHONE = "phone";
  static const ADDRESS = "address";
  static const CUSNAME = "cusName";
  static const PINCODE = "pincode";
  static const DATETIME = "datetime";
  static const STATUS = "deliverystatus";
  static const TAX = 'tax';
  static const SHIPPINGFEE = 'shippingfee';
  static const DISCOUNT = "discount";

  String id;
  var totalprice;
  String cusname;
  String address;
  String phone;
  String pincode;
  var datetime;
  String status;
  String tax;
  String shippingfee;
  var discount;
  List<OrderItemModel> item;

  OrderModel(
      {this.address,
      this.status,
      this.item,
      this.cusname,
      this.totalprice,
      this.datetime,
      this.discount,
      this.phone,
      this.tax,
      this.shippingfee,
      this.pincode});

  OrderModel.fromMap(Map<String, dynamic> data) {
    phone = data[PHONE];
    address = data[ADDRESS];
    cusname = data[CUSNAME];
    totalprice = data[TOTALPRICE];
    pincode = data[PINCODE];
    datetime = data[DATETIME];
    status = data[STATUS];
    tax = data[TAX];
    discount = data[DISCOUNT];
    shippingfee = data[SHIPPINGFEE];
    item = _convertCartItems(data[ITEM]);
  }
}

List<OrderItemModel> _convertCartItems(List cartFomDb) {
  List<OrderItemModel> _result = [];
  if (cartFomDb.length > 0) {
    cartFomDb.forEach((element) {
      _result.add(OrderItemModel.fromMap(element));
    });
  }
  return _result;
}

//--------------------------------------------------------------------------------------------------

// Order Item Model

class OrderItemModel {
  static const ID = "orderId";
  static const IMAGE = "image";
  static const PNAME = "name";
  static const QUANTITY = "quantity";
  static const COST = "cost";
  static const PRICE = "price";
  static const PRODUCT_ID = "productId";
  static const VARIATIONTYPE = "variationtype";
  static const DISCOUNT = "discount";
  static const TAX = 'tax';
  static const SHIPPINGFEE = 'shippingfee';

  String id;
  String image;
  int quantity;
  String cost;
  String productId;
  String price;
  String variationtype;
  String pname;
  String discount;

  OrderItemModel({
    this.productId,
    this.id,
    this.image,
    this.pname,
    this.price,
    this.discount,
    this.quantity,
    this.variationtype,
    this.cost,
  });

  OrderItemModel.fromMap(Map<String, dynamic> data) {
    id = data[ID];
    image = data[IMAGE];
    pname = data[PNAME];
    quantity = data[QUANTITY];
    cost = data[COST];
    productId = data[PRODUCT_ID];
    price = data[PRICE];
    variationtype = data[VARIATIONTYPE];
    discount = data[DISCOUNT];
  }

  Map<String, dynamic> toJson() => {
        ID: id,
        PRODUCT_ID: productId,
        IMAGE: image,
        PNAME: pname,
        QUANTITY: quantity,
        COST: price,
        PRICE: price,
        DISCOUNT: discount,
      };
}
