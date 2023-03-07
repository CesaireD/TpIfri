import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kkiapay_flutter_sdk/kkiapay/app/app.dart';
import 'package:tp/modele/User.dart';
import 'package:tp/modele/produit.dart';
import 'package:tp/screens/paiement.dart';
import '../modele/Panier.dart';
import 'Home.dart';


class CommandeRow extends StatefulWidget {
  final num totalSansTaxe,tva,total;
  const CommandeRow({super.key, required this.totalSansTaxe,required this.total, required this.tva});


  
  @override
  State<StatefulWidget> createState() => _CommandeRow();
}

class _CommandeRow extends State<CommandeRow> {

  void retour() {
    Navigator.pop(context);
  }

  Widget expanded_widget(){
      return Expanded(
          flex: 0,
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
                  Text("${widget.total} FCA",
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
                  onPressed: ()async {
                    final mail = await FirebaseAuth.instance.currentUser!.email;
                    await Utilisateur.fetchByEmail(mail.toString());
                    final user = Utilisateur.user;
                    ProdString.name = user!.name!;
                    ProdString.e_mail = user.email;
                    ProdString.phone = user.tel!;
                    ProdString.amount = widget.total.toInt();
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return Paiement();
                  }));
                  },
                  child: Text("VALIDER",style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width/15,
                  ),))
            ],
          ),
          );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Commande"),
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
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Table(
            //border: TableBorder.all(),
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(250),
              1: FlexColumnWidth(),
              2: FlexColumnWidth()
            },

            defaultVerticalAlignment: TableCellVerticalAlignment.fill,
            children: <TableRow>[
              TableRow(
                  decoration: BoxDecoration(
                      color: Colors.grey[700]
                  ),
                  children: const[
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Text(
                          "Nom du produit",
                          style: TextStyle(
                            fontSize:  18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Text(
                          "PU",
                          style: TextStyle(
                            fontSize:  18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    TableCell(
                        verticalAlignment: TableCellVerticalAlignment.top,
                        child: Text(
                          "Qt",
                          style: TextStyle(
                            fontSize:  18,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    )
                  ]
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
                //gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: Panier.prod.length + 2,
                itemBuilder: (_, index) {
                  print('$index--------------');
                  final produits = Panier.prod;
                  return Table(
                    //border: TableBorder.all(),
                    columnWidths: const <int, TableColumnWidth>{
                      0: FixedColumnWidth(150),
                      1: FixedColumnWidth(10),
                      2: FixedColumnWidth(5)
                    },

                    defaultVerticalAlignment: TableCellVerticalAlignment.fill,
                    children: <TableRow>[
                      TableRow(
                        decoration: BoxDecoration(
                          color: Colors.grey[200]
                        ),
                        children: [
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: index == Panier.prod.length + 1 ?
                              const Text(
                                "TOTAL",
                                style: TextStyle(
                                  fontSize:  22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                                  :( index == Panier.prod.length ?
                              const Text(
                               "TVA",
                                 style: TextStyle(
                                fontSize:  18,
                                 fontWeight: FontWeight.normal,
                                ),
                               ):
                              Text(
                                produits[index].name,
                                style: const TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                          )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: index == Panier.prod.length + 1 ?
                              Text(
                                widget.total.toString(),
                                style: const TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                                  :( index == Panier.prod.length ?
                              Text(
                                widget.tva.toString(),
                                style: const TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ):Text(
                                produits[index].price.toString(),
                                style: const TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                          )),
                          TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: index == Panier.prod.length + 1 ?
                              const Text(
                                "-",
                                style: TextStyle(
                                  fontSize:  22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                                  :( index == Panier.prod.length ?
                              const Text(
                                "-",
                                style: TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ):Text(
                                produits[index].quantity.toString(),
                                style: const TextStyle(
                                  fontSize:  18,
                                  fontWeight: FontWeight.normal,
                                ),
                              )
                          ))
                        ]
                      ),

                    ],
                  );
                },
                ),
          ),

          expanded_widget()
        ],
      ),
    );
  }
}
