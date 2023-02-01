// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vethouse/map_page.dart';
import 'package:vethouse/navpage.dart';
import 'package:vethouse/services/authentication.dart';

class Uploadphoto extends StatefulWidget {
  final email;
  final password;
  final username;
  final file;

  const Uploadphoto(
      {super.key, this.email, this.password, this.username, this.file});

  @override
  State<Uploadphoto> createState() => _UploadphotoState();
}

class _UploadphotoState extends State<Uploadphoto> {
  ImagePicker picker = ImagePicker();
  XFile? image;
  Uint8List? uniImage;

  @override
  Widget build(BuildContext context) {
    var username = widget.username;
    var password = widget.password;
    var email = widget.email;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(40, 10, 30, 0),
                child: Text(
                  "VetME",
                  style: TextStyle(fontSize: 50, fontFamily: "Billabong"),
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Container(
                  alignment: Alignment.center, // This is needed
                  child: Image.asset(
                    'assets/images/house-pet-gradient.png',
                    width: 80,
                    height: 60,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Hello, ${username} Welcome to Holbegram. ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              // ignore: prefer_const_constructors
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Choose an image from your gallery or take a new one.",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    image == null
                        ? Container(
                            height: 200,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 80,
                              child: Image.asset(
                                'assets/images/avtar.jpg',
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(File(image!.path))),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              image = (await picker.pickImage(
                                  source: ImageSource.gallery))!;

                              setState(() {});
                              image!.readAsBytes();
                            },
                            child: Text("gallery")),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              image = (await picker.pickImage(
                                  source: ImageSource.camera))!;

                              setState(() {
                                image!.readAsBytes();
                              });
                            },
                            child: Text("camera")),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                // ignore: sort_child_properties_last
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.cabin(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onPressed: () async {
                  uniImage = await image!.readAsBytes();

                  final newUser = await AuthMethods().signUpUser(
                    email: email,
                    password: password,
                    username: username,
                    file: uniImage,
                  );
                  print("-------------------------------------");
                  print(email);
                  print(password);
                  print(username);
                  print(uniImage);
                  print("-------------------------------------");
                  if (newUser != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Navpage(),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 214, 56, 45)),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
