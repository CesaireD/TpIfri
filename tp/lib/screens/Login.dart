import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tp/screens/MotdepasseOublie.dart';
import 'package:tp/screens/signup_screen.dart';
import '../main.dart';
import '../modele/Authentification.dart';
import 'package:http/http.dart';

import '../utils/Constant.dart';
import 'Home.dart';

class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
  
}
class LoginState extends State<Login>{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  _login(email, password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );
    try{

      await Authentification.signIn(email, password);
      //final prefs = await SharedPreferences.getInstance();
      //prefs.setString(Constant.USER_ID_PREF_KEY, authenticatedUser.user!.username!);
      setState(() {
        isLoading = true;
      });
      print('\n\naaa\n\n');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    
    //navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  initWidget() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 300,
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
                              child: Image.network(
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
                              "Login",
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
                            validator: (value) {
                              return value == null || value == ""
                                  ? "Ce champs est obligatoire"
                                  : null;
                            },
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
                              hintText: "Entrez votre mot de passe",
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
                            validator: (value) {
                              return value == null || value == ""
                                  ? "Ce champs est obligatoire"
                                  : null;
                            },
                            cursorColor: const Color.fromARGB(255, 49, 98, 231),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MotdepasseOublie()));
                            },
                            child: const Text("Mot de passe oublié?"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await _login(emailController.text,
                                  passwordController.text);
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
                                "CONNEXION",
                                style: TextStyle(color: Colors.white),
                              ),
                          ),
                        ),
                      ],
                    )
                ),


                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Vous n'avez pas de compte ?  "),
                      GestureDetector(
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(color: Color(0xffF5591F)),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return initWidget();
  }

  
  
}