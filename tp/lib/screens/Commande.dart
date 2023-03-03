import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tp/modele/produit.dart';
import 'Home.dart';

class Commande extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Mat",
      theme: ThemeData(primaryColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: CommandeRow(),
    );
  }
}

class CommandeRow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CommandeRow();
}

class _CommandeRow extends State<CommandeRow> {
  int val = 1;
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

  void ok() async {
    print("-------ggggggggggg----");

    //var p = await Produit.fetch();
    //print(p.length);
    l = await Produit.fetch() as List<Produit?>;
  }


  void initState() {
    ok();
    super.initState();

  }
 /* List<Widget> show_list_produit() {
    List<Widget> list_r = [];
    setState(() {
      ok();
    });
    print("+--------------------------------------------------------------------");
    print("l ${l.length}");
    print("+--------------------------------------------------------------------");

    l.forEach((element) {
      Row row = new Row(
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
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Column(children: [
                  new Image.network(
                    element!.picture,
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  )
                ]),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      element!.name,
                      style: TextStyle(
                        fontSize:  MediaQuery.of(context).size.width/20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    new Text(
                      "" + element!.price.toString() + " FCFA",
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize:  MediaQuery.of(context).size.width/18
                      ),
                    ),
                    new Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      color: Colors.grey[300],
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new IconButton(
                              onPressed: compte, icon: Icon(Icons.add)),
                          new Text(
                            val.toString(),
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width/20,),
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
            ),
            secondaryBackground:  new Container(
              alignment: Alignment.centerRight,
              color: Colors.deepOrange[600],
              child: Icon(Icons.delete,
                size: MediaQuery.of(context).size.width/7,),
            ),
            background:  new Container(
              alignment: Alignment.centerLeft,
              color: Colors.yellow[500],
              child: Icon(Icons.star,
                size: MediaQuery.of(context).size.width/7,),
            ),
          )
        ],
      );
      list_r.add(row);
    });
    return list_r;
  }*/
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
                  total(produits[index].price);
                  return  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Text(
                          produits[index].name,
                          style: TextStyle(
                            fontSize:  MediaQuery.of(context).size.width/20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        new Text(
                          "" + produits[index].price.toString() + " FCFA",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:  MediaQuery.of(context).size.width/18
                          ),
                        ),
                        new Text(produits[index].quantity.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize:  MediaQuery.of(context).size.width/18
                          ),)
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void retour() {
    Navigator.pop(context);
  }

  void Rechercher() {}
  int impot=0;

  Widget expanded_widget(){
      return Expanded(
          flex: 0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget> [
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text("TOTAL",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: MediaQuery.of(context).size.width/19,
                    ),),
                  new Text("$prix_total FCA",
                    style: TextStyle(
                        color:Colors.blue[900],
                        fontSize: MediaQuery.of(context).size.width/15
                    ),),
                ],
              ),
              new ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith((color) => Colors.blue[900])
                  ),
                  onPressed: (){

                  },
                  child: new Text("VALIDER",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width/15,
                  ),))
            ],
          ),
          );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Commande"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        leading: new IconButton(
            onPressed: retour,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      //TODO faire en sorte que le truc puisse afficher les produits
      //Todo le singchildscrollView n'accepte pas le card vis versa
      body: new Column(
        //elevation: 1,
        children: [
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new Text("Produit",
                style: TextStyle(
                    color: Colors.black,
                    fontSize:  MediaQuery.of(context).size.width/15
                ),),
              new Text("Prix",
                style: TextStyle(
                    color: Colors.black,
                    fontSize:  MediaQuery.of(context).size.width/15
                ),),
              new Text("Quantité",
                style: TextStyle(
                    color: Colors.black,
                    fontSize:  MediaQuery.of(context).size.width/16
                ),)
            ],
          ),
          new Expanded(child: affiche_produit()),
          expanded_widget()
        ],
      ),
    );
  }
}

