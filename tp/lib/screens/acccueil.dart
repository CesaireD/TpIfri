import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Column(children: [ Row(
        children: [
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher',prefixIcon: Icon(Icons.search)
              ),
            ),
          ),
          IconButton(icon: const Icon(Icons.image,color: Colors.blue,),onPressed: (){

          } )
        ],
      ),
        const Text('Catégories',
          style:TextStyle(fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Icon(Icons.home),
                const Text('Home')
              ],
            ),
            Column(
              children: [
                const Icon(Icons.settings),
                const Text('Settings')
              ],
            ),
             Column(
              children: [
               const Icon(Icons.person),
               const Text('Profile')
              ],
            ),
            Column(
              children: [
                const Icon(Icons.help),
                const Text('Help')
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
            Text('Texte 1'),Text('Texte 2'),
        ],
        ),
        Row(
          children: [
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
          ],
        ),
        const Text('Découverte',
          style:TextStyle(fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
            Column(
              children: [
                Image.asset('assets/image1.jpg'),Text('Titre1',style:TextStyle(fontSize: 14.0)),Text('Sous-titre1',style:TextStyle(fontWeight:FontWeight.normal,fontSize: 12.0,)),Text('Sous-titre2',style:TextStyle(color: Colors.blue,fontSize: 14.0)),
              ],
            ),
          ],
        ),

        BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Handle shopping cart action
                },
              ),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Handle person action
                },
              ),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  // Handle settings action
                },
              ),
            ),
          ],
        ),

      ],
      ),
    );
  }
}
