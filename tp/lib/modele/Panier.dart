
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp/modele/Commande.dart';

import 'produit.dart';

class Panier {

  String? id;
  final String? userId;
  bool? commander;
  List<Produit>? produit;
  static List<Produit> prod =[];
  static num totalPrix = 0;
  static String idP = "";
  static Panier? panier;


  Panier({required this.produit, this.commander, this.id, this.userId});

  add() async {
    final docProduit = FirebaseFirestore.instance.collection('panier').doc();
    final prod = Panier(
      id: docProduit.id,
      userId: userId,
      produit: produit,
      commander: commander,
    );
    final json = prod.toJson();
    await docProduit.set(json);
  }


  /*static Future<Stream<List<Produit>>> fetch(String id) async {
    var v = FirebaseFirestore.instance.collection('panier').where("userid", isEqualTo: id).snapshots().map((event) => event.docs.map((e) => Produit.fromJson(e.data())).toList());
    //v.forEach((element) {prod.add(element); totalPrix += element.price;});
    for(Produit p in v as List<Produit>){
      prod.add(p);
    }
    return v;
  }*/

  static Future<Stream<List<Panier>>> fetch(String idU) async {
    var v = await FirebaseFirestore.instance.collection('panier').where("userid", isEqualTo: idU).snapshots().map((event) => event.docs.map((e) => Panier.fromJson(e.data())).toList());
    v.forEach((element) {
      element.forEach((element) {
        prod = element.produit! ;
        prod.forEach((element) { totalPrix += (element.price * element.quantity);});
        idP = element.id!;
        panier = element;
      });

    });
    return v;
  }

  Map<String,dynamic> toJson() => {
    'id' : id,
    'userid' : userId,
    'produit' : produit,
    'vendu' : commander,

  };

  static Panier fromJson(Map<String,dynamic> json) => Panier(
    id: json['id'],
    userId: json['userid'],
    produit: json['produit'] as List<Produit>,
    commander: json['vendu']
  );
  
  command() async {
    //Commande(panier: this, userId: userId, status: "en attente", total: totalPrix);
    await Commande.create(userId!, "", "en attente", this, totalPrix);
    commander = true;
  }



}