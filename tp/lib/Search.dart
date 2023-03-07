import 'package:flutter/material.dart';
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
              autofocus: true,
              onSubmitted: (pattern){
                changeScreen(context, const ProductSearchScreen());
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
  }
  
}