// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dartx/dartx.dart';
import 'package:matjar/screens/activitesList.dart';
import 'package:matjar/screens/enrregistrer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    User? user;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    Future<(User?, Container)> _signInWithEmailAndPassword(String email, String password) async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        user = userCredential.user;
        return (user, Container(
          child: Text(
            "Sign in successful",
          )
        ));
      } catch (e) {
        User? u;
        u = null;
        return( u, Container(
          child: Text(
            "Sign in failed",
          )
        ));
      }
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Login',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.transparent,
        // centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
        alignment: Alignment.center,
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login_back.jpg"),
                fit: BoxFit.cover)),
        child: Container(
          alignment: Alignment.center,
          height: double.maxFinite,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: 275,
                child: Lottie.asset(
                    "assets/lottie/Animation - 1699915234989.json"),
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0)),
            Container(
              padding: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0.0, 0, 5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),
                        labelText: 'Login',
                        hintText: "mybenkhadda@example.com",
                        labelStyle: TextStyle(
                          color: Color(0xFF0057B9),
                        ),
                        suffixIcon: Icon(
                          Icons.mail,
                          color: Color(0xFF0057B9),
                        ),
                      ),
                      controller: _usernameController,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 5.0, 0, 0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Color(0xFF0057B9)),
                        ),
                        labelText: 'Mot de passe',
                        labelStyle: TextStyle(
                          color: Color(0xFF0057B9),
                        ),
                        suffixIcon: Icon(
                          Icons.password_rounded,
                          color: Color(0xFF0057B9),
                        ),
                      ),
                      controller: _passwordController,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                width: 280,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      child: Text('Se connecter',
                          style: TextStyle(
                            color: Color(0xFF0057B9),
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final login = _usernameController.text;
                        final password = _passwordController.text;
                        var c = await _signInWithEmailAndPassword(login, password);
                        User? u = c.$1;
                        Container container = c.$2;
                        if (u != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ActListPage(),
                            )
                          );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: container,
                            )
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text('S\'inscrire',
                          style: TextStyle(
                            color: Color(0xFF0057B9),
                          )
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Enrregistrer()),
                        );
                      }
                    )
                  ],
                ))
          ]),
        ),
      ),
    );
  }
}
