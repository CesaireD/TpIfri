import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modele/produit.dart';
import 'featured_card.dart';

class FeaturedProducts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FeaturedProductsState();
  }
  
}
class FeaturedProductsState extends State<FeaturedProducts>{


  /*Widget buildProduit(Produit produit) => ListTile(
    leading: CircleAvatar(child: Text('${produit.price}')),
    title: Text(produit.name),
    subtitle: Text(produit.date.toIso8601String()),
  );*/
  @override
  Widget build(BuildContext context) {
    final  produit = Produit.fetch();
    int? taille;

    Future<void> tailleGetter() async {
      int count = await produit.length;
      taille = count;
    }

    @override
    void initState() {
      tailleGetter();
      super.initState();
    }

    return Container(
      height: 230,
      child: StreamBuilder<List<Produit>>(
          stream: Produit.fetch(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Text('${snapshot.error}');
            }else if(snapshot.hasData){
              final produits = snapshot.data!;
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taille,
                  itemBuilder: (_, index) {
                    if(produits[index].feature == false) {
                      return FeaturedCard(produit: produits[index]);
                    }else{
                      return null;
                    }
                  }
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }
      ),
/*
        ListView(
          children: produits.map(buildProduit).toList(),
        );*/



      /*ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: taille,
          itemBuilder: (_, index) {
            return FeaturedCard(produit: produit[index]);
          }
      ),*/
    );
  }
  
}