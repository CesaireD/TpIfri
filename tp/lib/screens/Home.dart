import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_nullsafety/carousel_nullsafety.dart';
import 'package:tp/modele/produit.dart';
import '../helpers/style.dart';

import '../Search.dart';
import '../widgets/Drawer.dart';
import '../widgets/FeaturedProducts.dart';
import '../widgets/featured_card.dart';
import '../widgets/product_card.dart';
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
  int? choix;
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
        /*
        Produit produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F10.png?alt=media&token=e310a71e-4622-4ed3-b9e8-35bd60d551e6", description: "...", category: "art contemporain", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F1.jpg?alt=media&token=77971cfe-02e0-44d5-83be-f535bb524ddd", description: "...", category: "art contemporain", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F11.jpeg?alt=media&token=1462cef9-894a-48e4-8d03-0a4db137f7df", description: "...", category: "art contemporain", quantity: 7, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F12.jpg?alt=media&token=63c0136b-1918-412a-a608-994d41316586", description: "...", category: "art contemporain", quantity: 15, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F13.jpeg?alt=media&token=476d4f17-e13b-499b-bd22-8b4ea3d3ae51", description: "...", category: "art contemporain", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F14.jpeg?alt=media&token=27be52ef-7272-4b63-a862-e43da852624e", description: "...", category: "peinture abstraite", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_1.jpg?alt=media&token=a78a93b4-e4c1-4de4-8b62-5520dd73bdea", description: "...", category: "peinture abstraite", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_9.jpeg?alt=media&token=821c0e80-84ad-4c9f-bba2-30dc701d3597", description: "...", category: "peinture abstraite", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_8.jpeg?alt=media&token=11460060-557e-4608-bc5d-51b7aaf32681", description: "...", category: "peinture abstraite", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "L'Homme Boubouli", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_7.webp?alt=media&token=b4c158d6-f193-4960-95d9-371cda8b1f56", description: "...", category: "peinture abstraite", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_6.webp?alt=media&token=2c13a641-2708-4961-82e7-bbaf42d52154", description: "...", category: "paysage", quantity: 19, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_5.webp?alt=media&token=ef67851d-a8e9-4049-b756-b3f5ce6e2336", description: "...", category: "paysage", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_4.webp?alt=media&token=71303ccd-7af5-4f0a-b756-6e2dbc739cd7", description: "...", category: "paysage", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_3.webp?alt=media&token=6cc67445-15c8-49ee-b950-3909814ea0ce", description: "...", category: "portrait humain", quantity: 5, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_2.webp?alt=media&token=6df3c6e8-9dad-4950-b928-7fd3c9c3bb81", description: "...", category: "portrait humain", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_10.jpeg?alt=media&token=c1a10f6d-54da-4e43-8418-d9eef1aacab3", description: "...", category: "portrait humain", quantity: 5, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        produit = Produit(name: "Jamaicain", picture: "https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_1.jpg?alt=media&token=a78a93b4-e4c1-4de4-8b62-5520dd73bdea", description: "...", category: "portrait humain", quantity: 25, price: 209000, feature: true, date: DateTime.now());
        produit.add();
        */

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
      child: Carousel(
        boxFit: BoxFit.contain,
        autoplay: false,
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        images: [
          InkWell(
            onTap: () {
              //print("ggggggggggggggggggggggggggggggggggggggggggggggg");
            },
            child: Image.network("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F10.png?alt=media&token=e310a71e-4622-4ed3-b9e8-35bd60d551e6"),
          ),
          //NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F10.png?alt=media&token=e310a71e-4622-4ed3-b9e8-35bd60d551e6"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_2.webp?alt=media&token=6df3c6e8-9dad-4950-b928-7fd3c9c3bb81"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_3.webp?alt=media&token=6cc67445-15c8-49ee-b950-3909814ea0ce"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Fjamaika_6.webp?alt=media&token=2c13a641-2708-4961-82e7-bbaf42d52154"),
          NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F13.jpeg?alt=media&token=476d4f17-e13b-499b-bd22-8b4ea3d3ae51"),
          InkWell(
            onTap: () {
              print("ggggggggggggggggggggggggggggggggggggggggggggggg");
            },
            child: Image.network("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F13.jpeg?alt=media&token=476d4f17-e13b-499b-bd22-8b4ea3d3ae51"),
          ),
          //NetworkImage(url),
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
        //currentIndex: choix!,
        onTap: (int index){
          setState(() {
            choix=index;
          });
        },
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: TextButton(onPressed: () {},
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




      SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
              margin: const EdgeInsets.all(10.0),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image_carousel,
                  Search(),
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
                 /* Expanded(
                      flex: 1,
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemCount: 1,//Produit.list.length,
                        itemBuilder: (_, index) {
                            final produit = Produit.list;
                            if(produit.length == 0){
                              return null;//const Center(child: CircularProgressIndicator());
                            }else{
                              return ProductCard(product: produit[index]);
                            }

                        },
                    ),

                  ),*/


                  /*ListView.builder(
                      itemCount: Produit.list.length,
                      itemBuilder: (_, index){

                      }
                  ),*/




                  /*StreamBuilder<List<Produit>>(
                          stream: Produit.fetch(),
                          builder: (context, snapshot) {
                            if(snapshot.hasError){
                              return const Text('');
                            }else if(snapshot.hasData){
                              final produits = snapshot.data!;
                              return ListView.builder(
                                    itemCount: produits.length,
                                    itemBuilder: (_, index)
                                {
                                  return FeaturedCard(produit: produits[index]);
                                }
                              );
                            }else{
                              return const Center(child: CircularProgressIndicator());
                            }
                          }
                      ),*/




                ],
              ),
            ),
          ] 
        ),
      ),
    );
  }
  
}