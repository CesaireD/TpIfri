import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/VoirTous.dart';


class Draweer extends StatefulWidget{
  const Draweer({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DrawerState();
  }
  
}
class DrawerState extends State<Draweer>{
  final user = FirebaseAuth.instance.currentUser!;

  Widget buildHeader(BuildContext context) => Material(
    color: Colors.blue.shade700,
    child: InkWell(
      onTap: () {

      },
      child: Container(
        color: Colors.blue.shade700,
        padding: EdgeInsets.only(bottom: 24,top: 24 +MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(''),
            ),
            //Text(user.displayName! == "" ? "":user.displayName!, style: const TextStyle(fontSize: 28, color: Colors.white),),
            const SizedBox(height: 12,),
            Text(user.email!, style: const TextStyle(fontSize: 16, color: Colors.white),)
          ],
        ),
      ),
    ),
  );
  
  Widget buildMenuItems(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => VoirTous()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {

          },
        ),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {

          },
        ),
        const Divider(color: Colors.black54,),
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: () {

          },
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Se deconnecter'),
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
        )
      ],
    ),
  );
  
  @override
  Widget build(BuildContext context) => Drawer(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    ),
  );
  
}