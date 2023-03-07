import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:tp/helpers/common.dart';
import 'package:tp/modele/produit.dart';
import 'package:tp/screens/panier.dart';
import 'package:tp/screens/profile.dart';
import '../helpers/style.dart';

import '../Search.dart';
import '../widgets/Drawer.dart';
import '../widgets/FeaturedProducts.dart';
import '../widgets/featured_card.dart';
import '../widgets/product_card.dart';
import 'VoirTous.dart';
class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }


}
class HomePageState extends State<HomePage>{
  final _key = GlobalKey<ScaffoldState>();
  final _recherche = TextEditingController();
  String _dropdownValue = "Art contemporain";
  String _searchValue = '';
  int choix=0;
  final List<String> _suggestions = [
    'contemporain',
    'peinture',
    'portrait',
    'paysage',
  ];
  Widget buildProduit(Produit produit) => ListTile(
    leading: CircleAvatar(child: Text('${produit.price}')),
    title: Text(produit.name),
    subtitle: Text(produit.date.toIso8601String()),
  );
  void dropdownCallback(String? selectedValue) {
    if(selectedValue is String){
      setState(() {
        _dropdownValue = selectedValue;
      });
    }
    switch (_dropdownValue) {
      case "Art contemporain" : {

      }
      break;
      case "Peinture abstraite" : {

        setState(() {

        });



      }
      break;
      case "Portrait humain" : {

      }
      break;
      case "Paysage" : {

      }
      break;
      default: {

      }
      break;

    }
  }



  @override
  Widget build(BuildContext context) {
    Widget image_carousel = Container(
      height: 200,
      child: const Carousel(
        autoplayDuration: Duration(seconds: 5),
        boxFit: BoxFit.contain,
        autoplay: true,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        images: [
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F10.png?alt=media&token=e310a71e-4622-4ed3-b9e8-35bd60d551e6"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_2.webp?alt=media&token=6df3c6e8-9dad-4950-b928-7fd3c9c3bb81"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_3.webp?alt=media&token=6cc67445-15c8-49ee-b950-3909814ea0ce"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_6.webp?alt=media&token=2c13a641-2708-4961-82e7-bbaf42d52154"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F13.jpeg?alt=media&token=476d4f17-e13b-499b-bd22-8b4ea3d3ae51"),
        ],
      ),
    );
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("ArTBrOs"),
      ),
      drawer: const Draweer(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: choix,
        onTap: (int index){
          setState(() {
            choix=index;
            print("choix : $choix");
          });
        },
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: TextButton(onPressed: () {
              setState(() {
                choix=0;
              });
            },
                child: const Text(
                  "Explorer",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                )) ,
            label: "",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
              color: Colors.black,
            ),
            label: "",
          ),
          const  BottomNavigationBarItem(
            icon: Icon(Icons.person,
              color: Colors.black,
            ),
            label: "",
          ),
        ],
      ),
      body: /*Center(child: Text("Hi..."),)*/




      choix ==0? SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              margin: const EdgeInsets.all(10.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Search(),
                  image_carousel,
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Catégories',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),
                        ),
                      ),
                      DropdownButton(
                        items: const [
                          DropdownMenuItem(value: "Art contemporain",child: Text("Art contemporain",),),
                          DropdownMenuItem(value: "Peinture abstraite",child: Text("Peinture abstraite"),),
                          DropdownMenuItem(value: "Portrait humain",child: Text("Portrait humain"),),
                          DropdownMenuItem(value: "Paysage",child: Text("Paysage"),),
                        ],
                        style: GoogleFonts.patuaOne(
                            textStyle: const TextStyle(color: Colors.black,fontSize: 20)
                        ),
                        value: _dropdownValue,
                        iconSize: 20.0,
                        onChanged: dropdownCallback,
                      )
                    ],
                  ),
                  const SizedBox(height: 30.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Meilleure vente',style: textStyle,),
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            changeScreen(context, VoirTous());
                          },
                          child: const Text('Voir tout')
                      ),
                    ],
                  ),
                  FeaturedProducts(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text('Decouverte',style: textStyle,),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: Produit.list.map((e) => GestureDetector(
                      child: ProductCard(product: e),
                    )
                    ).toList()
                  ),

                ],
              ),
            ),
          ] 
        ),
      ):(choix == 1? PanierPage():Profile()),
    );
  }
  
}