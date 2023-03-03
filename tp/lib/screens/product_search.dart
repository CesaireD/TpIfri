import '../helpers/common.dart';
import '../helpers/style.dart';
import '../modele/produit.dart';
import '../screens/product_details.dart';
import '../widgets/custom_text.dart';
import '../widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductSearchScreen extends StatelessWidget {
  const ProductSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Produit>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: black),
        backgroundColor: white,
        leading: IconButton(icon: const Icon(Icons.close), onPressed: (){
          Navigator.pop(context);
        }),
        title: CustomText(text: "Products", size: 20,),
        elevation: 0.0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: (){})
        ],
      ),
      body: Produit.searched.isEmpty ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.search, color: grey, size: 30,),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(text: "No products Found", color: grey, weight: FontWeight.w300, size: 22,),
            ],
          )
        ],
      ) : ListView.builder(
          itemCount: Produit.searched.length,
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: ()async{
                  changeScreen(context, ProductDetails(product: Produit.searched[index]));
                },
                child: ProductCard(product:  Produit.searched[index]));
          }),
    );
  }
}
