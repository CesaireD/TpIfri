import 'package:flutter/material.dart';
import 'package:tp/modele/produit.dart';

import 'helpers/common.dart';
import 'helpers/style.dart';
import 'screens/product_search.dart';

class Search extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchState();
  }
  
}
class SearchState extends State<Search>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 8, left: 8, right: 8, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            color: grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: const Icon(
              Icons.search,
              color: black,
            ),
            title: TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (pattern)async{
                await Produit.search(pattern);
                changeScreen(context, ProductSearchScreen());
              },
              decoration: const InputDecoration(
                hintText: "blazer, dress...",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
      /*Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: TextField(
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.blueGrey[300],
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.white,),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: "E.g: formal dress",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueGrey[300],
            ),
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey[300],
            ),
          ),
          maxLines: 1,
        ),
      ),
    );*/
  }
  
}