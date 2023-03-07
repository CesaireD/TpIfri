

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tp/modele/User.dart';
import 'package:tp/screens/update_profile.dart';

import '../helpers/style.dart';

class Profile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  File? pickedFile;
  ImagePicker imagePicker = ImagePicker();
  ok()async {
    await Utilisateur.fetchByEmail(FirebaseAuth.instance.currentUser!.email.toString());

  }
  @override
  void initState() {
    ok();
     user = Utilisateur.user;
    //_name=user!.name! == null ? "" : user!.name!;
    //_email=user!.email == null? "" : user!.email;
    //_phone=user!.tel! == null?  "": user!.tel!;
    //_password=user!.password;
    //_adresse = user!.adresse! ?? "";
     print(user);
    super.initState();
  }
  Utilisateur? user;
  String? _password = '';
  String _name = '';
  String _email = '';
  String _phone="" ;//= '+1 555-123-4567';
  String _bio = '';
  String _adresse ='';

  Widget buildTextField(String labelText, String placeholder, bool isPasswordTextField){
    bool isObscurePassword = true;

    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: TextField(
          obscureText: isPasswordTextField ?isObscurePassword:false,
          decoration: InputDecoration(
            suffixIcon: isPasswordTextField ?
                IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(Icons.remove_red_eye,color: Colors.grey,)
                ):null,
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: grey
            )
          ),
        )
    );
  }

  Widget bottomSheet(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.gallery);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.image,color: Colors.purple,),
                    SizedBox(height: 5,),
                    Text("Gallery",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),)
                  ],
                ),
              ),
              const SizedBox(width: 80,),
              InkWell(
                onTap: () {
                  takePhoto(ImageSource.camera);
                },
                child: Column(
                  children: const [
                    Icon(Icons.camera, color: Colors.deepPurple,),
                    SizedBox(height: 5,),
                    Text("Camera",style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),)
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Container(
            padding: const EdgeInsets.all(15),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: white),
                            boxShadow: [
                              BoxShadow(spreadRadius: 2,blurRadius: 10,color: black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                              NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2F10.png?alt=media&token=e310a71e-4622-4ed3-b9e8-35bd60d551e6"),
                            )
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(width: 4,color: white),
                                color: Colors.blue
                              ),
                              child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(context: context, builder: (context) => bottomSheet(context));
                                },
                                icon: const Icon(Icons.edit,color: white),
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  buildTextField("Nom & Prenoms",_name,false),
                  buildTextField("Email", _email, false),
                  buildTextField("Phone", _phone, false),
                  buildTextField("Password", _password!, true),
                  buildTextField("Adresse", _adresse, false),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlinedButton(
                          onPressed: (){

                          },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                          child: const Text("ANNULER",style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black,
                          )),
                      ),
                      ElevatedButton(
                          onPressed: () {

                          },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                          child: const Text("ENREGISTRER",style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.white,
                          )),
                      )
                    ],
                  )
                ],
              ),
            ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedImage = await imagePicker.pickImage(source: source, imageQuality: 100);
    pickedFile = File(pickedImage!.path);
  }
}
