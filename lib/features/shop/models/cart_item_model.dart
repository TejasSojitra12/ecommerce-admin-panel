class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectVariation;
  CartItemModel({
    required this.productId,
    this.title = '',
    this.price = 0.0,
    this.image,
    required this.quantity,
    this.variationId = '',
    this.brandName,
    this.selectVariation,
  });

  // Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// calculate total Amount
  String get totalAmount =>(price*quantity).toStringAsFixed(2);


  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Title': title,
      'Price': price,
      'Image': image,
      'Quantity': quantity,
      'VariationId': variationId,
      'BrandName': brandName,
      'SelectVariation': selectVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> map) {
    return CartItemModel(
      productId: map['ProductId'],
      title: map['Title'],
      price: map['Price']?.toDouble(),
      image: map['Image'],
      quantity: map['Quantity'],
      variationId: map['VariationId'],
      brandName: map['BrandName'],
      selectVariation: map['SelectVariation'] != null
          ? Map<String, String>.from(map['SelectVariation'])
          : null,
    );
  }
}
