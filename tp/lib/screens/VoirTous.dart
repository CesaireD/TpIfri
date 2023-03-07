import 'package:flutter/material.dart';
import '../helpers/style.dart';
import '../modele/produit.dart';
import '../widgets/custom_text.dart';
import '../widgets/product_card.dart';

class VoirTous extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VoirTousState();
  }
  
}
class VoirTousState extends State<VoirTous>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "Nos produits", size: 20,),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0),
            margin: const EdgeInsets.all(10.0),
            child: Column(
                children: Produit.list.map((e) => GestureDetector(
                  child: ProductCard(product: e),
                )
                ).toList()
            ),
          )
        ]
      ),
    );

  }
  
}