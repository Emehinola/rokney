// model for the products

class Product {
  final String? product_name, title, deescription, category;
  int? number_of_products; // number of initial available products
  double? price;
  final List<String>? images; // the images of the product to be sold

  Product(
      {this.product_name,
      this.price,
      this.title,
      this.images,
      this.number_of_products,
      this.deescription,
      this.category});
}
