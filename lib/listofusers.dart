import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:vethouse/providers/user_provider.dart';

import 'detailpage.dart';
import 'models/user.dart';

class listofusers extends StatefulWidget {
  const listofusers({super.key});

  @override
  State<listofusers> createState() => _listofusersState();
}

class _listofusersState extends State<listofusers> {
  @override
  Widget build(BuildContext context) {
    User_h user = Provider.of<UserProvider>(context, listen: false).getUser;

    FirebaseFirestore.instance.collection("users").snapshots();
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where('type', isEqualTo: 'doctor')
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index) => getRow(index),
                    );
            }));
  }

  Widget getRow(int index) {
          FirebaseFirestore.instance.collection("users").snapshots();

            
    return StreamBuilder(
    stream: FirebaseFirestore.instance
                .collection("users")
                .where('type', isEqualTo: 'doctor')
                .snapshots(),
          
         builder: (context, snapshot) {
           DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];
          return Card(
          child: ListTile(
            onTap: () {
              // Navigate to Next Details
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detailpage(),
                  ));
            },
            leading: CircleAvatar(
              radius: 21,
              backgroundColor: Colors.red,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                backgroundImage: NetworkImage(snap['profileImage']),
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snap['username'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('Dog: testttt'),
              ],
            ),
          ),
        );
      }
    );
  }
}
