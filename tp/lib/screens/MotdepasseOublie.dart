import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../modele/Authentification.dart';
import '../utils/Constant.dart';
import 'Login.dart';
/*
class MotdepasseOublie extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MotdepasseOublieState();
  }
  
}
class MotdepasseOublieState extends State<MotdepasseOublie>{
  final emailController = TextEditingController();

  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  _resetPassword(email) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );
    try{
      await Authentification.resetPassword(email);
      setState(() {
        isLoading = true;
      });
      Constant.showSnackBar("Email  de recuperation de mot de password envoye avec succes");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      print(e);
      Constant.showSnackBar(e.message);
      Navigator.of(context).pop();
    }

    navigatorKey.currentState!.popUntil(ModalRoute.withName('/HomePage'));
  }

  @override
  void dispose() {
    emailController.dispose();
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
                    color: Color.fromARGB(242, 247, 247, 248),
                    gradient: LinearGradient(
                      colors: [
                        (Color.fromARGB(253, 249, 249, 250)),
                        Color.fromARGB(255, 255, 255, 255)
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
                                'https://firebasestorage.googleapis.com/v0/b/elite-conquest-371806.appspot.com/o/tp%2Flogo.jpg?alt=media&token=8dd15a07-8b23-493c-81fa-ce0c8294be5a',
                                alignment: Alignment.center,
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 20, top: 20),
                            alignment: Alignment.bottomRight,
                            child: const Text(
                              "S'inscrire",
                              style: TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ),

                Form(
                    key: formKey,
                    child: Column(
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: "Entrez votre e-mail",
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
                        GestureDetector(
                          onTap: () async {
                            if (!isLoading && formKey.currentState!.validate()) {
                              await _resetPassword(emailController.text);
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
                              "Changer le mot de passe",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                ),

              ],
            )));
  }
  
}

 */