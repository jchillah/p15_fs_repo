import 'package:cloud_firestore/cloud_firestore.dart';

class Drink {
  final int id;
  final String type;
  final String name;
  final String brand;
  final double price;
  final String vol;
  final String quantity;
  bool isDeleted;

  Drink({
    required this.id,
    required this.type,
    required this.name,
    required this.brand,
    required this.price,
    required this.vol,
    required this.quantity,
    this.isDeleted = false,
  });

  factory Drink.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('DocumentSnapshot does not contain data');
    }
    return Drink(
      id: data['id'] as int,
      type: data['type'] as String,
      name: data['name'] as String,
      brand: data['brand'] as String,
      price: (data['price'] as num).toDouble(),
      vol: data['vol'] as String,
      quantity: data['quantity'] as String,
      isDeleted: data['isDeleted'] as bool ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'brand': brand,
      'price': price,
      'vol': vol,
      'quantity': quantity,
      'isDeleted': isDeleted,
    };
  }
}
