import 'package:flutter/material.dart';

import '../modele/produit.dart';

class DetailProduit extends StatefulWidget{
  final Produit? produit;
  const DetailProduit({Key? key, this.produit}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DetailProduitState();
  }
  
}
class DetailProduitState extends State<DetailProduit>{
  final _key = GlobalKey<ScaffoldState>();
  //String _color = "";
  //String _size = "";

  @override
  Widget build(BuildContext context) {

    return Center();
  }
  
}