import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Panier.dart';
import 'cart_item.dart';
class Commande {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const PANIER = "panier";
  static const USER_ID = "userid";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String? id;
  String? description;
  String? userId;
  String? status;
  DateTime? createdAt;
  num? total;
  Panier? panier;


  Commande({required this.panier,this.createdAt,required this.userId,required this.status, required this.total});


  Commande.fromJson(Map<String,dynamic> snapshot) {
    id = snapshot[ID];
    description = snapshot[DESCRIPTION];
    total = snapshot[TOTAL];
    status = snapshot[STATUS];
    userId = snapshot[USER_ID];
    createdAt = snapshot[CREATED_AT];
    panier = snapshot[PANIER];
  }

  Map<String,dynamic> toJson() => {
    'id' : id,
    'userid' : userId,
    'description' : description,
    'total': total,
    "createdAt": DateTime.now().millisecondsSinceEpoch,
    "status": status

  };


  static Future create(String userId ,String description,String status, Panier panier, num totalPrice) async {

    final doc = await FirebaseFirestore.instance.collection('commande').doc();
    final com = Commande(panier: panier, createdAt: DateTime.now(), userId: userId, status: status, total: totalPrice);
    doc.set(com.toJson());
    return await doc.set(com.toJson());
  }
}
