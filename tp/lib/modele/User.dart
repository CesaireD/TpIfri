import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'Panier.dart';
import 'cart_item.dart';
import 'produit.dart';

class Utilisateur {

  String id;
  final String name;
  final String? picture;
  final String email;
  final String password;
  final int? tel;
  final int? totalAchat;
  final int? totalPrix;
  final date;
  final List<Produit?> produits;

  Utilisateur({this.id = '',required this.name,this.picture,required this.email,required this.password,this.totalAchat,this.tel, this.totalPrix,this.date, required this.produits});


  add() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();

    final prod = Utilisateur(
      id: docUser.id,
      name: name,
      picture: picture,
      email: email,
      password: password,
      tel: tel,
      totalAchat: totalAchat,
      totalPrix: totalPrix,
      date: date,
      produits: produits,
    );
    final json = prod.toJson();
    await docUser.set(json);
  }

  static Stream<List<Utilisateur>> fetch() => FirebaseFirestore.instance
      .collection('user')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Utilisateur.fromJson(doc.data())).toList());

  static Future<Utilisateur?> fetchByEmail(String email) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(email);
    final snapshot = await docUser.get();
    if(snapshot.exists){
      return Utilisateur.fromJson(snapshot.data()!);
    }
  }

  Map<String,dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'picture' : picture,
    'email' : email,
    'password' : password,
    'tel' : tel,
    'totalAchat' : totalAchat,
    'totalPrix' : totalPrix,
    'date' : date,
    'produits' : produits
  };

  static Utilisateur fromJson(Map<String,dynamic> json) => Utilisateur(
    id: json['id'],
    name: json['name'],
    picture: json['picture'],
    email: json['email'],
    password: json['password'],
    tel: json['tel'],
    totalAchat: json['totalAchat'],
    totalPrix: json['totalPrix'],
    date: (json['date'] as Timestamp).toDate(),
    produits: json['produits'] as List<Produit>
  );

  static Future ajouterAuPanier(Produit product, String id) async {
    try {

      await Panier.fetch(id);
      List<Produit> prod = [];
      Panier p;
      if(Panier.panier == null){
        //q!.produit!.add(product);
        prod.add(product);
        p = Panier(produit: prod, commander: false, userId: id);
      }else{
        p = Panier.panier!;
        p.produit!.add(product);
        //prod = Panier.prod;
        //prod.add(product);
      }

      //List<Produit> pro = p.first.produit!;
      //pro.add(product);
      //Panier q = p.first;
      //q.produit = pro;

      await FirebaseFirestore.instance.collection('panier')
          .doc(Panier.idP)
          .delete();
      final ref = await FirebaseFirestore.instance.collection('panier')
          .doc()
          .set(p.toJson());
    } on FirebaseException catch (e) {
      print(e);
    }
  }


}