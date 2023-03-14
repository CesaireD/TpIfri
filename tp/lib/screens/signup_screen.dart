import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tp/screens/Home.dart';
import 'package:tp/screens/signup_screen.dart';
import '../helpers/common.dart';
import '../main.dart';
import '../modele/Authentification.dart';
import '../modele/User.dart';
import 'Login.dart';
import '../utils/Constant.dart';
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phonController =TextEditingController();

  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  _signup(email, password) async {
    isLoading ? showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    ) : null;
    try{
      nameController.text = nameController.text.toUpperCase();
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

      final u = Utilisateur(id: res.user!.uid,email: emailController.text.trim(),password: passwordController.text.trim(),name: nameController.text.trim(),tel: phonController.text.trim(),date: DateTime.now());
      u.add();
      Constant.showSnackBar("Compte cree\nEn attente de verification...");
      //final doc = FirebaseFirestore.instance.collection('user').
      setState(() {
        isLoading = true;
      });
      changeScreen(context,EmailVerificationScreen());
      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EmailVerificationScreen()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      if (e.code == 'email-already-in-use') {
        Constant.showSnackBar("Un compte existe deja pour ce email");
      }
    } catch (e) {
      Constant.showSnackBar(e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
    //navigatorKey.currentState!.popUntil(ModalRoute.withName('/HomePage'));

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => initWidget();

  Widget initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
            color: Color.fromARGB(239, 236, 237, 240),
            gradient: LinearGradient(
              colors: [
                (Color.fromRGBO(236, 238, 241, 1)),
                Color.fromARGB(255, 237, 240, 243)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: ClipOval(
                  child: Image.asset(
                    "assets/logo.jpg",
                    //'https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Flogo.jpg?alt=media&token=8dd15a07-8b23-493c-81fa-ce0c8294be5a',
                    alignment: Alignment.center,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, top: 20),
                alignment: Alignment.bottomRight,
                child: const Text(
                  "S'inscrire",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              )
            ],
          )),
        ),

                Form(
            key: formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],

                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        hintText: "Nom&Prenoms",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.person, color: Color.fromARGB(255, 49, 98, 231),)
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (name) => name == null || name == "" ? "Champs obligatoire" : null,
                    cursorColor: const Color.fromARGB(255, 49, 98, 231),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextFormField(
                    controller: phonController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: "Telephone",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.phone, color: Color.fromARGB(255, 49, 98, 231),)
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (name) => name == null || name == "" ? "Champs obligatoire" : null,
                    //validator: (phone) => phone != null && !EmailValidator.validate(phone) ? "cHAMPS VIDE" : null,
                    cursorColor: const Color.fromARGB(255, 49, 98, 231),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: "Email",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        icon: Icon(Icons.email, color: Color.fromARGB(255, 49, 98, 231),)
                    ),
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => email != null && !EmailValidator.validate(email) ? "Email invalide" : null,
                    cursorColor: const Color.fromARGB(255, 49, 98, 231),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color(0xffEEEEEE),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)),
                    ],
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      focusColor: const Color.fromARGB(255, 49, 98, 231),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Mot de passe",
                      labelText: "Mot de passe",
                      icon: const Icon(Icons.vpn_key, color: Color.fromARGB(255, 49, 98, 231),),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible =
                            !_passwordVisible;
                          });
                        },
                        icon: _passwordVisible ? const Icon(
                            Icons.visibility_off) : const Icon(
                            Icons.visibility),
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value !=null && value.length < 6 ? "le mot de passe doit contenir au moins 6 caracteres" : null,
                    cursorColor: const Color.fromARGB(255, 49, 98, 231),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    if (!isLoading && formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                     await _signup(emailController.text,passwordController.text);
                     // print('+++++++++++on++++++++++++++');
                      //final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());

                      //final u = Utilisateur(id: res.user!.uid,email: emailController.text.trim(),password: passwordController.text.trim(),name: nameController.text.trim(),tel: phonController.text.trim(),date: DateTime.now());
                      //u.add();
                      //Constant.showSnackBar("Compte cree avec succes");
                      //final doc = FirebaseFirestore.instance.collection('user').
                     // print('+++++++++++on++++++++++++++');
                    }else{
                      print('++++++++++++off+++++++++++++');
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        (Color.fromARGB(255, 124, 151, 224)),
                        Color.fromARGB(255, 65, 141, 228)
                      ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)),
                      ],
                    ),
                    child: const Text(
                      "S'INSCRIRE",
                    style: TextStyle(color: Colors.white),
                  ),
                  ),
                ),
              ],
            )
        ),

                Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Vous êtes déjà membre ?  "),
              GestureDetector(
                child: const Text(
                  "Connexion",
                  style: TextStyle(color: Color.fromARGB(255, 49, 98, 231)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                    return Login();
                  }));
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}


class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified) {
      sendEmailVerefied();
      timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
    }


  }

  Future sendEmailVerefied() async {
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Constant.showSnackBar(e.toString());
    }
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Constant.showSnackBar("Email Successfully Verified");

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? HomePage() : SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Verefiez votre \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Un email de verification vous a ete envoye par ${FirebaseAuth.instance.currentUser?.email}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verification du email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.email),
                  label: const Text('Renvoyer',style: TextStyle(fontSize: 24),),
                  onPressed: canResendEmail ? sendEmailVerefied : null,
                ),
              ),
              const SizedBox(height: 8,),
              TextButton(
                  onPressed: () => changeScreen(context, Login()),//FirebaseAuth.instance.signOut(),
                  child: Text("Retour", style: TextStyle(fontSize: 24),)
              )
            ],
          ),
        ),
      ),
    );
  }
}
