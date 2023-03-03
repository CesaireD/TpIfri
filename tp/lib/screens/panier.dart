import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../modele/Panier.dart';
import '../modele/produit.dart';
import 'Commande.dart';
import '../modele/produit.dart';
import 'Home.dart';

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

  void supprimer() {}
  List<Produit?> l =[];
  List<Produit>? produit;

  _ok() async{
    await Panier.fetch(FirebaseAuth.instance.currentUser!.uid);
    produit = Panier.prod;
        taille = Panier.prod.length;

  }

  void initState() {

    super.initState();

  }
  List<Widget> show_list_produit() {
    List<Widget> list_r = [];

    print("+--------------------------------------------------------------------");
    print("l ${l.length}");
    print("+--------------------------------------------------------------------");

    l.forEach((element) {
      Row row = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
            Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
              // Appeler ici la fonction pour supprimer l'élément
              if(direction==DismissDirection.startToEnd){
              onAddToFavorites();
              }else{
              onDelete();
              }
              setState(() {

              });

              },
              secondaryBackground:  Container(
                alignment: Alignment.centerRight,
                color: Colors.deepOrange[600],
                child: Icon(Icons.delete,
                size: MediaQuery.of(context).size.width/7,),
                ),
              background:  Container(
                alignment: Alignment.centerLeft,
                color: Colors.yellow[500],
                child: Icon(Icons.star,
                size: MediaQuery.of(context).size.width/7,),
              ),
              child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Column(children: [
              Image.network(
              element!.picture,
              fit: BoxFit.cover,
              height: 150,
              width: 150,
              )
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Text(
                element!.name,
                style: TextStyle(
                fontSize:  MediaQuery.of(context).size.width/20,
                fontWeight: FontWeight.bold,
                ),
                ),
                Text(
                "" + element!.price.toString() + " FCFA",
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
                    onPressed: compte, icon: const Icon(Icons.add)),
                    Text(
                    val.toString(),
                      style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width/20,),
                    ),
                    IconButton(
                    onPressed: decompte,
                    icon: const Icon(Icons.remove))
                    ],
                  ),
                )
              ],
              )
              ],
              ),
            )
        ],
      );
      list_r.add(row);
    });
    return list_r;
  }
void onDelete(){
  //TODO fonction pour supprimer un produit du panier
}
void onAddToFavorites(){
  //TODO pour ajouter aux favoris
}
var prix_total=0;
int total(int val) {
    return prix_total+=val;
}
  Widget affiche_produit() {
    return /*StreamBuilder<List<Produit>>(
        stream: produit!,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            final produits = snapshot.data!;
            return */ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: Panier.prod.length,
                itemBuilder: (_, index) {
                  final produits = Panier.prod;
                  return  Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) {
                      if(index!=null){
                        total(produits[index].price);
                      }
                      // Appeler ici la fonction pour supprimer l'élément
                      if(direction==DismissDirection.startToEnd){
                          onAddToFavorites();
                      }else{
                          onDelete();
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
                         Padding(padding: EdgeInsets.only(right:MediaQuery.of(context).size.width/3.5),
                         child:  Image.network(
                           produits[index].picture,
                           fit: BoxFit.contain,
                           height: 150,
                           width: 150,
                         ))
                        ]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              produits[index].name,
                              style: TextStyle(
                                fontSize:  MediaQuery.of(context).size.width/20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "" + produits[index].price.toString() + " FCFA",
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
                                      onPressed: compte, icon: const Icon(Icons.add)),
                                  Text(
                                    val.toString(),
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width/20,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: decompte,
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
          /*} else {
            return const Center(child: CircularProgressIndicator());
          }*/
        //});
  }

  /*Widget affiche_produit() {
    return StreamBuilder<List<Produit>>(
        stream: Produit.fetch(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('${snapshot.error}');
          } else if (snapshot.hasData) {
            final produits = snapshot.data!;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: produits.length,
                itemBuilder: (_, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Column(children: [
                        new Image.network(
                          produits[index].picture,
                          fit: BoxFit.cover,
                          height: 150,
                          width: 150,
                        )
                      ]),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text(
                            produits[index].name,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Text(
                            "" + produits[index].price.toString() + " FCFA",
                            style: TextStyle(
                              color: Colors.blue[700],
                            ),
                          ),
                          new Card(
                            color: Colors.grey[300],
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                new IconButton(
                                    onPressed: compte, icon: Icon(Icons.add)),
                                new Text(
                                  val.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                new IconButton(
                                    onPressed: decompte,
                                    icon: Icon(Icons.remove))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }*/

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
                  Text("$prix_total FCA",
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
                      Navigator.push(context,  MaterialPageRoute(builder: (BuildContext context){
                        return Commande();
                      }));
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.5),
                        child: Text("Sous total:",style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/20,
                          color: Colors.grey[700],
                        ),),),
                      Text("$prix_total",style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: MediaQuery.of(context).size.width/20
                      ),)
                      ],
                    ), Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/1.29),
                        child: Text("Impôt: ",style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/20,
                          color: Colors.grey[700],
                        ),),),
                        Text("$impot",style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width/20,
                          color: Colors.blue[900],
                        ),),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((color) => Colors.blue[900])
                    ),
                    onPressed: (){
                      //todo fonction de "verification"
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
    return Scaffold(
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
                 Expanded(child: affiche_produit()),
                  expanded_widget(index_expanded)
               ],
  /*new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: affiche_produit(), /*new Column(
            children: <Widget> [
              affiche_produit(),
              /*
              new SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:  [
                      new Container(
                        padding: const EdgeInsets.only(top:9,bottom: 9) ,
                        margin: const EdgeInsets.only(left: 10,right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: new Image.asset('assets/image1.jpg',
                          width: 170,
                          height:150,
                          fit: BoxFit.fill,
                        ),
                      ),
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text("Ja Morant et sa fille",
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          new Text(prix+devise,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue[900]
                            ),
                          ),
                          new Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[200],
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:  <Widget>[
                                new IconButton(
                                  onPressed: compte,
                                  icon: Icon(Icons.add),
                                  color: Colors.black,
                                ),
                                Text(val.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                  ),
                                ),
                                new IconButton(
                                    onPressed: decompte,
                                    icon: Icon(Icons.remove)
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 25),
                        width: MediaQuery.of(context).size.width/4,
                        height: 150,
                        color: Colors.deepOrangeAccent[700],
                        child: new Column(
                          children:<Widget> [
                            new IconButton(
                              alignment: Alignment.centerRight,
                              onPressed: supprimer,
                              icon: Icon(Icons.delete_sweep_outlined,
                                  size: 100
                              ),
                            )
                          ],
                        ),
                      )
                    ]
                ),
              ),*/
            ],
          ),*/
        // ),*/
          ),
    );
  }
}
