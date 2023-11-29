import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/pages/Homepage.dart';
import 'package:firebase_setup/pages/login_page.dart';
import 'package:firebase_setup/user_auth/firebase_auth_services.dart';
import 'package:firebase_setup/wigdets/form_container.dart';
import 'package:firebase_setup/wigdets/toast.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _issignup = false;
  final Firebaseauthservice _auth = Firebaseauthservice();
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailnamecontroller = TextEditingController();
  TextEditingController _passwordamecontroller = TextEditingController();

  @override
  void dispose() {
    _usernamecontroller.dispose();
    _emailnamecontroller.dispose();
    _passwordamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 209, 137),
        title: const Text("Sign Up"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              FormContainer(
                controller: _usernamecontroller,
                hintText: "User Name",
                ispasswordfield: false,
              ),
              const SizedBox(height: 10),
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
                onTap: () {
                  _signup();
                  showToast(message: "account created successfully");
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 59, 209, 137),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: _issignup
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : const Text(
                            "Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account?",
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
                                builder: (context) => const Login()),
                            (route) => false);
                      },
                      child: const Text(
                        "Login",
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

  void _signup() async {
    setState(() {
      _issignup = true;
    });
    String username = _usernamecontroller.text;
    String email = _emailnamecontroller.text;
    String password = _passwordamecontroller.text;

    User? user = await _auth.signupwithemailandpassword(email, password);
    setState(() {
      _issignup = false;
    });

    if (user != null) {
      showToast(message: "account created successfully");
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Homepage()));
    } else {
      showToast(message: "some error happend");
    }
  }
}
