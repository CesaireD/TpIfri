import 'package:flutter/material.dart';

import '../modele/produit.dart';
import '../widgets/featured_card.dart';
import '../widgets/product_card.dart';

class VoirTous extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VoirTousState();
  }
  
}
class VoirTousState extends State<VoirTous>{

  /*Widget buildProduct() => SliverToBoxAdapter(
    child: StreamBuilder<List<Produit>>(
        stream: Produit.fetch(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Text('');
          }else if(snapshot.hasData){
            final produits = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: 1,
                itemBuilder: (_, index)
                {
                  return ;//FeaturedCard(produit: produits[index]);
                }
            );
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }
    ),
  );*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
        children: Produit.list.map((e) => GestureDetector(
          child: ProductCard(product: e),
        )
        ).toList()
    );



      /*CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Nos produits'),
          leading: const Icon(Icons.arrow_back),
          floating: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search)
            )
          ],
        ),
        buildProduct(),
      ],
    );

       */
  }
  
}