import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tp/helpers/common.dart';
import '../modele/Panier.dart';
import '../modele/produit.dart';
import 'Commande.dart';
import '../modele/produit.dart';
import 'Home.dart';
/*
class PanierPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Mat",
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: ProductRow(),
    );
  }
}
*/
class ProductRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductRow();
}

class _ProductRow extends State<ProductRow> {
  int val = 1;
  int taille = 0;
  void compte() {
    setState(() {
      val++;
    });
  }

  void decompte() {
    if (val >= 2) {
      setState(() {
        val--;
      });
    } else {
      setState(() {
        val = 1;
      });
    }
  }

  bool oui = false;

  ok() async {
    await ProdString.dispose();
    await Panier.dispose();
    await Panier.fetch(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      oui = true;
    });
    return oui;
  }
  @override
  void initState() {
    super.initState();
    Panier.dispose();
    final a=ok();
  }
  Widget show_list_produit() {
    print("+--------------------------------------------------------------------");
    print("Nombre de produit dans le panier :${Panier.prod.length}");
   return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: Panier.prod.length,

        itemBuilder: (_, index) {
          final produits = Panier.prod;
          print("${Panier.prod.length}--------------------------------------------------------------------");
          return  Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.horizontal,
            onDismissed: (direction) async {
              if(index!=null){
                total(produits[index].price);
              }
              // Appeler ici la fonction pour supprimer l'??l??ment
              if(direction==DismissDirection.startToEnd){
                onAddToFavorites();
              }else{
                await onDelete(produits[index].id);
                print("-------------Supprimer-------------");
              }

              setState(() {

              });

            },
            secondaryBackground:  Container(
              alignment: Alignment.centerRight,
              color: Colors.deepOrange[600],
              child:Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // color: Colors.deepOrange[600],
                  children: [
                    Text("Supprimer",style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width/15
                    ),),
                    Icon(Icons.delete,
                      color: Colors.white,
                      size: MediaQuery.of(context).size.width/7,),
                  ]
              ),
            ),
            background:  Container(
              alignment: Alignment.centerLeft,
              color: Colors.yellow[500],
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // color: Colors.deepOrange[600],
                  children: [
                    Text("Favoris",style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width/15
                    ),),
                    Icon(Icons.star,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width/7,),
                  ]
              ),
            ),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(children: [
                  Padding(padding: EdgeInsets.only(right:MediaQuery.of(context).size.width/10),
                      child:  Card(
                        margin: const EdgeInsets.only(left: 10),
                        child: Image.network(
                        produits[index].picture,
                        fit: BoxFit.contain,
                        height: 150,
                        width: 150,
                      )),
                      )
                ]),
                Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Card(
                     color: Colors.white,
                     elevation: 0.0,
                     margin: const EdgeInsets.only(right: 5),
                     child:  Text(
                       produits[index].name,
                       style: TextStyle(
                         fontSize:  MediaQuery.of(context).size.width/20,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                   ),
                    Text(
                      " " + produits[index].price.toString() + " cfa",
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize:  MediaQuery.of(context).size.width/18
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                              onPressed: /*compte*/(){

                                setState(() {
                                  top[index]++;
                                  ProdString.prix = somme(ProdString.prix, prix_total) ;
                                });
                              },
                              icon: const Icon(Icons.add)),
                          Text(
                            //val.toString(),
                            getTop(top[index]),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/20,
                            ),
                          ),
                          IconButton(
                              onPressed: /*decompte*/(){
                                if(top[index] == 1){

                                }else{
                                  setState(() {
                                    top[index]--;
                                    ProdString.prix = somme(ProdString.prix, prix_total*(-1));
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
onDelete(String id) async {
  //TODO fonction pour supprimer un produit du panier
  await FirebaseFirestore.instance.collection('panier').doc(Panier.panier!.id).collection('produit').doc(id).delete();
  setState(() {
    ok();
  });
}
somme(a,b) {return a+b;}
div(a,b) { return ((a/b).round() * 100) / 100  ; }

List<num> top = [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1];
getTop(index){
    return index.toString();
}
void onAddToFavorites(){
  //TODO pour ajouter aux favoris
}
num prix_total = 0;
void total(int val) {
    prix_total+=val;
}


  void retour() {
    Navigator.pop(context);

  }

  void Rechercher() {}
int impot=0;
int index_expanded=0;
  
Widget expanded_widget(int value){
  if(value==0){
    return Expanded(
        flex: index_expanded,
        child: InkWell(
          onTap: (){
            setState(() {
              if(index_expanded==0){
                index_expanded=1;
              }else{
                index_expanded=0;
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("TOTAL",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: MediaQuery.of(context).size.width/19,
                    ),),
                  Text("${getTop(somme(ProdString.prix, div(ProdString.prix, 999)))} FCA",
                    style: TextStyle(
                        color:Colors.blue[900],
                        fontSize: MediaQuery.of(context).size.width/15
                    ),),
                ],
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((color) => Colors.blue[900])
                  ),
                  onPressed: (){
                      changeScreen(context, CommandeRow(total: somme(ProdString.prix, div(ProdString.prix, 999)),totalSansTaxe: ProdString.prix!,tva: div(ProdString.prix, 999)));
                  },
                  child: Text("VERIFIER",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width/15,
                  ),))
            ],
          ),
        )
    );
  }else{
   return Expanded(
        flex: index_expanded,
        child: InkWell(
          onTap: (){
            setState(() {
              if(index_expanded==0){
                index_expanded=1;
              }else{
                index_expanded=0;
              }
            });
          },
          child: Card(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sous total:",
                            style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width/20,
                            color: Colors.grey[700],
                          ),
                          ),
                        Text("${ProdString.prix}",style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: MediaQuery.of(context).size.width/20
                        ),)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TVA:",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/20,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(getTop(div(ProdString.prix, 999)),style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: MediaQuery.of(context).size.width/20
                          ),)
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("TOTAL:",
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                          Text(getTop(somme(ProdString.prix, div(ProdString.prix, 999))),style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: MediaQuery.of(context).size.width/18
                          ),)
                        ],
                      ),
                    ),

                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((color) => Colors.blue[900])
                    ),
                    onPressed: (){
                      changeScreen(context, CommandeRow(total: somme(ProdString.prix, div(ProdString.prix, 999)),totalSansTaxe: ProdString.prix!,tva: div(ProdString.prix, 999)));
                    },
                    child: Text("VERIFIER",style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width/15,
                    ),))
              ],
            ),
          ),
        )
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return oui ? Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        leading: IconButton(
            onPressed: retour,
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          Container(
            decoration:
                const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            child: IconButton(
              onPressed: Rechercher,
              icon: Icon(
                Icons.search,
                size: 35,
                color: Colors.blue[900],
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      //TODO faire en sorte que le truc puisse afficher les produits
      //Todo le singchildscrollView n'accepte pas le card vis versa
      body: Column(
          //elevation: 1,
               children: [
                 Expanded(child: show_list_produit()),
                  expanded_widget(index_expanded)
               ],
          ),
    ):const Center(child: CircularProgressIndicator(),);
  }
}
