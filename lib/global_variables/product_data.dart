class ProductData {
  String? company, product, description;
  int? quantity;
  double? price;

  ProductData({
    this.company,
    this.product,
    this.description,
    this.quantity,
    this.price,
  });

  void reset() {
    company = product = description = null;
    quantity = null;
    price = null;
  }

  void getProductList() {
    Map<String, dynamic> productMap = {
      'company': company,
      'product': product,
      'quantity': quantity,
      'price': price,
      'description': description,
    };
    productList.add(productMap);
  }
}

List<Map<String, dynamic>> productList = [];
List<List> invoice = [];
