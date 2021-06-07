class ProductModel {
  static const VARIATIONTYPE = "variationtype";
  static const NAME = "name";
  static const CATEGORY = "category";
  static const PHOTO = "photo_url";
  static const PRICE = "price";
  static const QUANTITY = "quantity";
  static const VARIATION = "variation";
  static const ONSALE = "onsale";
  static const DESCRIPTION = "description";
  static const REVIEWS = "reviews";
  static const FEATURED = "featured";
  static const PRODUCTID = "product_id";
  static const RATINGS = "rating";
  static const PINCODE = "pincode";

  // List<Product> productList = [];
  String variationtype;
  String name;
  String category;
  List photo;
  var price;
  List pincode;
  int quantity;
  List variation;
  bool onsale;
  String description;
  List reviews;
  bool featured;
  String productid;
  var rating;
  ProductModel(
      {this.name,
      this.category,
      this.description,
      this.pincode,
      this.featured,
      this.onsale,
      this.photo,
      this.price,
      this.productid,
      this.quantity,
      this.rating,
      this.variationtype,
      this.reviews,
      this.variation});

  ProductModel.fromMap(Map<String, dynamic> data) {
    name = data[NAME];
    category = data[CATEGORY];
    description = data[DESCRIPTION];
    featured = data[FEATURED];
    onsale = data[ONSALE];
    photo = data[PHOTO];
    price = data[PRICE].toDouble();
    productid = data[PRODUCTID];
    quantity = data[QUANTITY];
    rating = data[RATINGS];
    variationtype = data[VARIATIONTYPE];
    reviews = data[REVIEWS];
    variation = data[VARIATION];
    pincode = data[PINCODE];
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
