class ProductData {
  String? company, product, description;
  int? quantity;
  double? price;

  ProductData();

  // static final ProductData products = ProductData._();

  void reset() {
    company = product = description = quantity = price = null;
  }

  void addToProductList() {
    // Add the current instance of ProductData to the productList
    productList.add(this);
  }
}

List<ProductData> productList = [];
