import 'package:cloud_firestore/cloud_firestore.dart';

class Drink {
  final int id;
  final String type;
  final String name;
  final String brand;
  final double price;
  final String vol;
  final String quantity;

  Drink({
    required this.id,
    required this.type,
    required this.name,
    required this.brand,
    required this.price,
    required this.vol,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'brand': brand,
      'price': price,
      'vol': vol,
      'quantity': quantity,
    };
  }

  factory Drink.fromMap(Map<String, dynamic> map, int id) {
    return Drink(
      id: id,
      type: map['type'],
      name: map['name'],
      brand: map['brand'],
      price: map['price'],
      vol: map['vol'],
      quantity: map['quantity'],
    );
  }
  static Drink fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return Drink(
      id: data['id'],
      type: data['type'],
      name: data['name'],
      brand: data['brand'],
      price: data['price'],
      vol: data['vol'],
      quantity: data['quantity'],
    );
  }
}
