import 'package:flutter/material.dart';

import '../helpers/style.dart';

class Categorie extends StatelessWidget{

  final String categorie;
  const Categorie({Key? key, required this.categorie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Stack(
            children: [
              Positioned(
                  top: 10,
                  right: 20,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.search,),
                    ),
                  )
              ),
              Positioned(
                  top: 10,
                  right: 40,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Text("${categorie}",style: textStyle),
                    ),
                  )
              ),
              Positioned(
                  top: 10,
                  right: 100,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {

                      },
                      child: Icon(Icons.arrow_back_ios_new_outlined,),
                    ),
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
