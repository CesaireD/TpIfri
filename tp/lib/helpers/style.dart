import 'package:flutter/material.dart';

const Color primary = Colors.deepOrange;
const  red = Colors.red;
const  yellow = Colors.yellow;
const Color white = Colors.white;
const Color black = Colors.black;
const Color grey = Colors.grey;
const Color green = Colors.green;
const textStyle = TextStyle(fontSize: 22,fontWeight: FontWeight.bold);

/*
ElevatedButton(
                  onPressed: () {
                    final docProd = FirebaseFirestore.instance.collection('ifri').doc("2PaxuLA8LrREFQ9cQzAa");
                    docProd.update({
                      'price': 5
                    });
                  },
                  child: Text('Update')
              ),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                  onPressed: () {
                    final docProd = FirebaseFirestore.instance.collection('ifri').doc("2PaxuLA8LrREFQ9cQzAa");
                    docProd.delete();
                  },
                  child: Text('Delete')
              ),

              FutureBuilder<Produit?>(
                future: Produit.fetchByID('produits'),
                  builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text('');
                  }else if(snapshot.hasData) {
                     final produit = snapshot.data;
                     return produit == null ? Center(child: Text("Ce produit n'existe pas")) : buildProduit(produit);
                   }else{
                     return Center(child: CircularProgressIndicator(),);
                   }
                  }
              ),

              StreamBuilder<List<Produit>>(
                stream: Produit.fetch(),
                  builder: (context, snapshot) {
                   if(snapshot.hasError){
                     return Text('');
                   }else if(snapshot.hasData){
                     final produits = snapshot.data!;
                     return ListView(
                       children: produits.map(buildProduit).toList(),
                     );
                   }else{
                     return Center(child: CircularProgressIndicator());
                   }
                  }
              ),
              const SizedBox(height: 30.0,),
 */