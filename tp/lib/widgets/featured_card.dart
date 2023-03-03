import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/common.dart';
import '../helpers/style.dart';
import '../modele/produit.dart';
import '../screens/DetailProduit.dart';
import 'loading.dart';

class FeaturedCard extends StatelessWidget {
  final Produit? produit;

  const FeaturedCard({Key? key, this.produit}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          changeScreen(context, DetailProduit(produit: produit,));
        },
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(
              color: Color.fromARGB(62, 168, 174, 201),
              offset: Offset(0, 1),
              blurRadius: 10
            )],
          ),
          /*BoxDecoration(
            color: white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(-2, -1),
                blurRadius: 5
              )
            ]),*/
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                Positioned.fill(child: Align(alignment: Alignment.center,child: Loading(),)),
                Center(
                  child: Image.network(
                    produit!.picture,
                    fit: BoxFit.cover,
                    height: 220,
                    width: 200,
                  )

                  /*FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      placeholderScale: 0.5,
                      imageScale: 0.5,
                      image: produit!.picture,
                      fit: BoxFit.cover,
                      height: 220,
                      width: 200,
                  ),*/
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          //Colors.black.withOpacity(0.8),
                          //Colors.black.withOpacity(0.7),
                          //Colors.black.withOpacity(0.7),
                          //Colors.black.withOpacity(0.7),
                          //Colors.black.withOpacity(0.6),
                          //Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.5),
                          Colors.black.withOpacity(0.1),
                          Colors.black.withOpacity(0.05),
                          Colors.black.withOpacity(0.025),
                        ]
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: '${produit!.name} \n', style: const TextStyle(fontSize: 18)),
                          TextSpan(text: '${produit!.price} Fcfa',style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold))
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
