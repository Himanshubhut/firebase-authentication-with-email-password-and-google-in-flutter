import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/pages/Homepage.dart';
import 'package:firebase_setup/pages/sign_up.dart';
import 'package:firebase_setup/user_auth/firebase_auth_services.dart';
import 'package:firebase_setup/wigdets/form_container.dart';
import 'package:firebase_setup/wigdets/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:io';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _issignin = false;
  final Firebaseauthservice _auth = Firebaseauthservice();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _emailnamecontroller = TextEditingController();
  TextEditingController _passwordamecontroller = TextEditingController();

  @override
  void dispose() {
    _emailnamecontroller.dispose();
    _passwordamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 209, 137),
        title: const Text("login"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FormContainer(
                controller: _emailnamecontroller,
                hintText: "Email",
                ispasswordfield: false,
              ),
              const SizedBox(height: 10),
              FormContainer(
                controller: _passwordamecontroller,
                hintText: "Password",
                ispasswordfield: true,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _signin,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 59, 209, 137),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _issignin
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Login",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  _signwithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 15, 15),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.google,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Signin with google",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUp()),
                            (route) => false);
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                            fontSize: 22),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signin() async {
    setState(() {
      _issignin = true;
    });
    String email = _emailnamecontroller.text;
    String password = _passwordamecontroller.text;

    User? user = await _auth.signinwithemailandpassword(email, password);
    setState(() {
      _issignin = false;
    });

    if (user != null) {
      showToast(message: "account login successfully");
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    } else {
      showToast(message: "please enter valid email and password");
    }
  }

  _signwithGoogle() async {
    final GoogleSignIn _googlesignin = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googlesignin.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Homepage()));
      }
    } catch (e) {
      showToast(message: "error");
    }
  }
}
