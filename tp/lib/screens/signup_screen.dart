import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tp/screens/signup_screen.dart';
import '../main.dart';
import '../modele/Authentification.dart';
import 'Login.dart';
import '../utils/Constant.dart';
class SignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InitState();
}

class InitState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;
  /*_signup(email, password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(),)
    );
    try{
      //await Authentification.signUp(email, password);
      setState(() {
        isLoading = true;
      });
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    } on FirebaseAuthException catch (e) {
      print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
      print(e);
      Constant.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil(ModalRoute.withName('/HomePage'));
  }*/

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => value !=null && value.length < 6 ? "le mot de passe doit contenir au moins 6 caracteres" : null,
                    cursorColor: const Color.fromARGB(255, 49, 98, 231),
                  ),
                ),

                GestureDetector(
                  onTap: () async {
                    if (!isLoading && formKey.currentState!.validate()) {
                     // await _signup(emailController.text,passwordController.text);
                      print('+++++++++++on++++++++++++++');
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim());
                      print('+++++++++++on++++++++++++++');
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



        /*Container(
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
          child: const TextField(
            cursorColor: Color.fromARGB(255, 49, 98, 231),
            decoration: InputDecoration(
              icon: Icon(
                Icons.person,
                color: Color.fromARGB(255, 49, 98, 231),
              ),
              hintText: "Votre Nom et Prénom",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey[200],
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            cursorColor: Color.fromARGB(255, 49, 98, 231),
            decoration: InputDecoration(
              icon: Icon(
                Icons.email,
                color: Color.fromARGB(255, 49, 98, 231),
              ),
              hintText: "Email",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            cursorColor: Color.fromARGB(255, 49, 98, 231),
            decoration: InputDecoration(
              focusColor: Color.fromARGB(255, 49, 98, 231),
              icon: Icon(
                Icons.phone,
                color: Color.fromARGB(255, 49, 98, 231),
              ),
              hintText: "Téléphone",
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xffEEEEEE),
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 20),
                  blurRadius: 100,
                  color: Color(0xffEEEEEE)),
            ],
          ),
          child: TextField(
            obscureText: true,
            cursorColor: Color.fromARGB(255, 49, 98, 231),
            decoration: InputDecoration(
              focusColor: Color.fromARGB(255, 49, 98, 231),
              icon: Icon(
                Icons.vpn_key,
                color: Color.fromARGB(255, 49, 98, 231),
              ),
              labelText: 'Mot de passe',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),*/

        Container(
          margin: EdgeInsets.only(top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Vous êtes déjà membre ?  "),
              GestureDetector(
                child: Text(
                  "Connexion",
                  style: TextStyle(color: Color.fromARGB(255, 49, 98, 231)),
                ),
                onTap: () {
                  // Write Tap Code Here.
                  Navigator.pop(context);
                },
              )
            ],
          ),
        )
      ],
    )));
  }
}
