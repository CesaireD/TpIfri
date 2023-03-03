import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_item.dart';
class OrderModel {
  static const ID = "id";
  static const DESCRIPTION = "description";
  static const CART = "cart";
  static const USER_ID = "userId";
  static const TOTAL = "total";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String? _id;
  String? _description;
  String? _userId;
  String? _status;
  int? _createdAt;
  int? _total;

//  getters
  String get id => _id!;

  String get description => _description!;

  String get userId => _userId!;

  String get status => _status!;

  int get total => _total!;

  int get createdAt => _createdAt!;

  // public variable
  List? cart;

  OrderModel.fromJson(Map<String,dynamic> snapshot) {
    _id = snapshot[ID];
    _description = snapshot[DESCRIPTION];
    _total = snapshot[TOTAL];
    _status = snapshot[STATUS];
    _userId = snapshot[USER_ID];
    _createdAt = snapshot[CREATED_AT];
    cart = snapshot[CART];
  }
}



class OrderServices{
  String collection = "orders";
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void createOrder(String userId ,String id,String description,String status ,List<CartItemModel> cart, int totalPrice) {
    List<Map> convertedCart = [];

    for(CartItemModel item in cart){
      convertedCart.add(item.toMap());
    }

    _firestore.collection(collection).doc(id).set({
      "userId": userId,
      "id": id,
      "cart": convertedCart,
      "total": totalPrice,
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "description": description,
      "status": status
    });
  }
/*
  Future<List<OrderModel>> getUserOrders({String? userId}) async {
    var order = await _firestore
        .collection(collection)
        .where("userId", isEqualTo: userId)
        .get();

  }


          .then((result) {
        List<OrderModel> orders = [];
        for (DocumentSnapshot order in result.docs) {
          orders.add(OrderModel.fromJson(order));
        }
        return orders;
      });

 */

}
