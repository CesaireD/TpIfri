

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    id = FirebaseAuth.instance.currentUser!.uid;
    final a = await Utilisateur.fetchByEmail(id);
    user = Utilisateur.user;
    _name.text= user!.name!;
    _email.text=user!.email;
    _phone.text= user!.tel!;
    _password.text=user!.password;
    _adresse.text = user!.adresse ?? "";
    photo = user!.picture;
    _date = user!.date;
    print(user!.name);
  }
  @override
  void initState() {
    ok();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();
  late String id;
  late DateTime _date;
  bool bom = true;
  Utilisateur? user;
  final _password = TextEditingController();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone= TextEditingController();
  String? photo;
  final _adresse = TextEditingController();

  Widget buildTextField(String labelText, TextEditingController placeholder){
    bool isObscurePassword = true;
    //print(placeholder);

    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: placeholder,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: grey
            )
          ),
            validator: (value) {return value == null || value == ""? "Ce champs est obligatoire": null;}

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
        title: const Text('Profil'),
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
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            border: Border.all(width: 4, color: white),
                            boxShadow: [
                              BoxShadow(spreadRadius: 2,blurRadius: 10,color: black.withOpacity(0.1))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: photo == null 
                                  ? const NetworkImage("https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Flogo.jpg?alt=media&token=71396168-cb49-4569-bc68-86865480f6d4")
                                  : NetworkImage(photo!),
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
                  Form(
                      key: formKey,
                      child: Column(
                        children: [
                          buildTextField("Nom & Prenoms",_name),
                          buildTextField("Email", _email),
                          buildTextField("Phone", _phone),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: _password,
                                obscureText: bom,
                                decoration: InputDecoration(
                                    suffixIcon:
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          bom = false;
                                        });
                                      },
                                      icon: bom
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    contentPadding: const EdgeInsets.only(bottom: 3),
                                    labelText: "Password",
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                    hintStyle: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: grey
                                    )
                                ),
                                validator: (value) {return value == null || value == ""? "Ce champs est obligatoire": null;}
                              )
                          ),
                          //buildTextField("Password", _password!, true),
                          buildTextField("Adresse", _adresse),
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
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    Utilisateur u = Utilisateur(email: _name.text, password: _password.text, id: id, tel: _phone.text, name: _name.text, adresse: _adresse.text,date: _date);
                                    await FirebaseFirestore.instance.collection('user').doc(id).update(u.toJson());
                                  }
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
                      )
                  ),


                ],
              ),
            ),
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    /*final pickedImage = await imagePicker.pickImage(source: source, imageQuality: 100);
    pickedFile = File(pickedImage!.path);
    print(pickedFile);
    setState(() {
      photo = pickedFile.toString();
    });*/
    await FirebaseAuth.instance.currentUser!.updateDisplayName(_name.text);
    String? profile = await FirebaseAuth.instance.currentUser!.displayName;
    print("-------$profile");
    //final a = PhoneAuthCredential().
    //await FirebaseAuth.instance.currentUser!.updatePhoneNumber(.text);
    profile = await FirebaseAuth.instance.currentUser!.phoneNumber;
    print("-------$profile");
    //await FirebaseAuth.instance.currentUser!.updateDisplayName(_name.text);
    profile = await FirebaseAuth.instance.currentUser!.photoURL;
    print("-------$profile");

  }
}
