import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp/modele/User.dart';
import 'package:tp/screens/update_profile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser!;
  String? _firstName ;
  String _lastName = '';
  String _email = '';
  String _phone="" ;//= '+1 555-123-4567';
  String _bio = '';

  @override
  Widget build(BuildContext context) {
    _firstName=user.displayName!;
    _email=user.email!;
    _phone=user.phoneNumber.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              '$_firstName $_lastName',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              _email,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _phone,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Editer le Profile'),
              trailing: Icon(Icons.navigate_next),
              onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                 return Text("data");
                 //EditProfilePage();
               }));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              trailing: Icon(Icons.navigate_next),
              title: Text('Bio'),
              subtitle: Text(_bio),
              onTap: () {
                // TODO: navigate to edit bio page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              trailing: Icon(Icons.navigate_next),
              title: Text('Changer de mot de passe'),
              onTap: () {
                // TODO: navigate to change password page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              trailing: Icon(Icons.navigate_next),
              title: Text('Se déconnecter'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}