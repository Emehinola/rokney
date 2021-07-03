// model for the products

class Product {
  final String? productName, title, deescription, category;
  int? numberOfProduct; // number of initial available products
  double? price;
  final List<String>? images; // the images of the product to be sold

  Product(
      {this.productName,
      this.price,
      this.title,
      this.images,
      this.numberOfProduct,
      this.deescription,
      this.category});
}
