import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  String _firstName = 'John';
  String _lastName = 'Doe';
  String _email = 'johndoe@example.com';
  String _phone = '+1 555-123-4567';
  String _bio = 'Hello, I am John Doe!';

  @override
  Widget build(BuildContext context) {
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
              title: Text('Edit Profile'),
              onTap: () {
                // TODO: navigate to edit profile page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Bio'),
              subtitle: Text(_bio),
              onTap: () {
                // TODO: navigate to edit bio page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text('Change Password'),
              onTap: () {
                // TODO: navigate to change password page
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // TODO: log out the user
              },
            ),
          ],
        ),
      ),
    );
  }
}