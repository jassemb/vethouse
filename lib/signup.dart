import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vethouse/login.dart';

import 'addphoto.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  final _password = TextEditingController();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _confirm = TextEditingController();
  final _firstName = TextEditingController();
  final _secondName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  TextFormField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.person_outline,
                            size: IconTheme.of(context).size,
                            color: IconTheme.of(context).color),
                        labelText: 'Username',
                        counterText: '',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      maxLength: 70,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Second Name cannot be Empty");
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username.text = value!;
                      },
                      controller: _username),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email,
                          size: IconTheme.of(context).size,
                          color: IconTheme.of(context).color),
                      labelText: 'E-Mail...',
                      counterText: '',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    maxLength: 70,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please Enter Your Email");
                      }
                      // reg expression for email validation
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Please Enter a valid email");
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _firstName.text = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock,
                          size: IconTheme.of(context).size,
                          color: IconTheme.of(context).color),
                      labelText: 'Password...',
                      counterText: '',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _password,
                    maxLength: 70,
                    obscureText: true,
                    validator: (value) {
                      // ignore: unnecessary_new
                      RegExp regex = new RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Enter Valid Password(Min. 6 Character)");
                      }
                    },
                    onSaved: (value) {
                      _firstName.text = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock,
                          size: IconTheme.of(context).size,
                          color: IconTheme.of(context).color),
                      labelText: 'confirm-Password...',
                      counterText: '',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _password,
                    maxLength: 70,
                    obscureText: true,
                    validator: (value) {
                      if (_confirm.text != _password.text) {
                        return "Password don't match";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _confirm.text = value!;
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(top: 3, left: 3),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Uploadphoto(
                          username: _username.text,
                          password: _password.text,
                          email: _email.text,
                        ),
                      ),
                    );
                  },
                  color: Color(0xff0095FF),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  // ignore: prefer_const_constructors
                  child: Text(
                    "Sign up",
                    // ignore: prefer_const_constructors
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _email.text, password: _password.text)
                          .then((value) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      });
                    },
                    // ignore: prefer_const_constructors
                    child: Text("Login",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
