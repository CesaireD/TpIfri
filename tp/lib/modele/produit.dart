import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'Panier.dart';

class Produit {

  String id;
  final String name;
  final String picture;
  final String description;
  final String category;
  final int quantity;
  final int price;
  final bool feature;
  final DateTime date;

  static List<Produit> list = [];
  static List<Produit> searched = [];

  Produit({this.id = '',required this.name,required this.picture,required this.description,required this.category,required this.quantity,required this.price,required this.feature,required this.date});


  add() async {
   final docProduit = FirebaseFirestore.instance.collection('produit').doc();

   final prod = Produit(
       id: docProduit.id,
       name: name,
       picture: picture,
       description: description,
       category: category,
       quantity: quantity,
       price: price,
       feature: feature,
       date: date,
   );
   final json = prod.toJson();
   await docProduit.set(json);
 }

  static Future<Stream<List<Produit>>> search(String name) async {
    String searchKey = name[0].toUpperCase() + name.substring(1);
    var prod = FirebaseFirestore.instance
        .collection('produit')
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Produit.fromJson(doc.data())).toList());
    prod.forEach((element) {searched = element;});
    return prod;
  }
 static Stream<List<Produit>> fetch() {
    var prod = FirebaseFirestore.instance
        .collection('produit')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => Produit.fromJson(doc.data())).toList());
    prod.forEach((element) { list = element;});
    return prod;
 }

 static Future<Produit?> fetchByID(String id) async {
   final docProd = FirebaseFirestore.instance.collection('produit').doc(id);
   final snapshot = await docProd.get();
   if(snapshot.exists){
     return Produit.fromJson(snapshot.data()!);
   }
 }

 Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'picture' : picture,
    'description' : description,
    'category' : category,
    'quantity' : quantity,
    'price' : price,
    'sale' : feature,
    'date' : date,

 };

 static Produit fromJson(Map<String,dynamic> json) => Produit(
     id: json['id'],
     name: json['name'],
     picture: json['picture'],
     description: json['description'],
     category: json['category'],
     quantity: json['quantity'],
     price: json['price'],
     feature: json['sale'],
     date: (json['date'] as Timestamp).toDate(),
 );



}

class ProdString {
  String id;
  static num? prix = Panier.getTotal();
  static dispose() {
    prix = 0;
    prix = Panier.getTotal();
  }
  ProdString({required this.id});
  static ProdString fromJson(Map<String,dynamic> json) => ProdString(
      id: json['id']
  );
}

/*


  Future<List<Produit>> searchProducts({String? productName}) {
    // code to convert the first character to uppercase
    String searchKey = productName[0].toUpperCase() + productName!.substring(1);
    return _firestore
        .collection(collection)
        .orderBy("name")
        .startAt([searchKey])
        .endAt([searchKey + '\uf8ff'])
        .getDocuments()
        .then((result) {
      List<Produit> products = [];
      for (DocumentSnapshot product in result.documents) {
        products.add(Produit.fromSnapshot(product));
      }
      return products;
    });
  }
}*/