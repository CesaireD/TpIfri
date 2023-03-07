import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'Panier.dart';
import 'cart_item.dart';
import 'produit.dart';

class Utilisateur {

  String id;
  String? name = "";
  String? picture;
  String email ="";
  String password;
  String? tel="";
  int? totalAchat;
  final int? totalPrix;
  String? adresse ="";
  final date;
  static Utilisateur? user;

  Utilisateur({this.id = '',this.name,this.picture,required this.email,required this.password,this.adresse,this.totalAchat,this.tel, this.totalPrix,this.date});


  add() async {
    final docUser = FirebaseFirestore.instance.collection('user').doc(id);

    final prod = Utilisateur(
      id: id,
      name: name,
      picture: picture,
      email: email,
      password: password,
      tel: tel,
      totalAchat: totalAchat,
      totalPrix: totalPrix,
      date: date,
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
      user = Utilisateur.fromJson(snapshot.data()!);
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
  );

  static Future ajouterAuPanier(Produit product, String id) async {
    try {
      print("A-----${id}----------");

      Panier.dispose();
      await Panier.fetch(id);
      //print("1----------${Panier.panier!.id}---------------");
      //List<Produit> prod = [];
      Panier p;
      if(Panier.panier == null){
        print("1---------------------------------");
        final ref = await FirebaseFirestore.instance.collection('panier')
            .doc(id);

        //prod.add(product);
        p = Panier(id: ref.id, commander: false, userId: id);
        ref.set(p.toJson());

        final doc = await FirebaseFirestore.instance.collection('panier')
            .doc(id).collection('produit').doc(product.id);
        doc.set(product.toJson());

      }else{
        print("2--------${Panier.panier!.id}--------------");
        final doc = await FirebaseFirestore.instance.collection('panier')
            .doc(id).collection('produit').doc(product.id);
        doc.set(product.toJson());
        /*p = Panier.panier!;
        p.produit!.add(product);
        await FirebaseFirestore.instance.collection('panier')
            .doc(Panier.idP)
            .delete();
        final ref = await FirebaseFirestore.instance.collection('panier')
            .doc()
            .set(p.toJson());
        //prod = Panier.prod;
        //prod.add(product);

         */
      }

      return true;

    } on FirebaseException catch (e) {
      print(e);
    }
  }


}