
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tp/modele/User.dart';

import '../helpers/common.dart';
import '../helpers/style.dart';
import '../modele/app.dart';
import '../utils/Constant.dart';
import '../widgets/custom_text.dart';
import '../widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp/modele/produit.dart';
import 'package:transparent_image/transparent_image.dart';

import 'cart.dart';

class ProductDetails extends StatefulWidget {
  final Produit? product;

  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      body: SafeArea(
          child: Container(
        //color: Colors.black.withOpacity(0.9),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.center,
                  child: Loading(),
                )),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: widget.product!.picture,
                    fit: BoxFit.fill,
                    height: 400,
                    width: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            //Colors.black.withOpacity(0.7),
                            //Colors.black.withOpacity(0.5),
                            //Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: 400,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            //Colors.black.withOpacity(0.8),
                            //Colors.black.withOpacity(0.6),
                            //Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.07),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container())),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.product!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '${widget.product!.price} cfa',
                              textAlign: TextAlign.end,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        changeScreen(context, CartScreen());
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.shopping_cart),
                            ),
                          )),
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () {
                        print("CLICKED");
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(35))),
                        child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white70,
                          offset: Offset(2, 5),
                          blurRadius: 10)
                    ]),
                child: Column(
                  children: [


                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                             'Description:\n${widget.product!.description}\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s  Lorem Ipsum has been the industry standard dummy text ever since the 1500s ',
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9),
                      child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.blue,
                          //elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async {
                              final  app = AppProvider();
                              //final user = Utilisateur();
                              final id = FirebaseAuth.instance.currentUser!.uid;
                              app.changeIsLoading();
                              bool success = await Utilisateur.ajouterAuPanier(widget.product!, id);
                              print("----------------------------------------------------------------");
                              if (success) {
                                Constant.showSnackBar("Ajouter avec succes");
                                app.changeIsLoading();
                                print("----------------------------------------------------------------");
                                return;
                              } else {
                                Constant.showSnackBar("Echec ...");
                                /*_key.currentState.showSnackBar(SnackBar(
                                    content: Text("Not added to Cart!")));*/
                                app.changeIsLoading();
                                return;
                              }

                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: AppProvider.isLoading1
                                ? Loading()
                                : const Text(
                                    "Ajouter au panier",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                       // color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
