// ignore_for_file: public_member_api_docs, sort_constructors_first
class PaymentMethodModel {
  String name;
  String image;
  PaymentMethodModel({
    required this.name,
    required this.image,
  });

  static PaymentMethodModel empty() => PaymentMethodModel(name: '', image: '');
}
