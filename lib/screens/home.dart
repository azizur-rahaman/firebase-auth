import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_test/services/auth_service.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () async {
              AuthService().signOut();
            },
            icon: const Icon(Icons.logout),
            label: Text('Logout'),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                CollectionReference users =
                    firebaseFirestore.collection('users');

                users.doc('Azizur Rahaman').set({
                  'name': 'Azizur',
                  'Institute': 'KCPSC',
                  'Batch': 'HSC-21',
                });
              },
              child: const Text('Add data to firebase'),
            ),
            ElevatedButton(
                onPressed: () async {
                  CollectionReference users =
                      firebaseFirestore.collection('users');
                  // QuerySnapshot allResults = await users.get();

                  // allResults.docs.forEach((DocumentSnapshot element) {
                  //   print(element.data());
                  // });

                  print('--------------------------');
                  DocumentSnapshot result =
                      await users.doc('Azizur Rahaman').get();

                  print(result.data());

                  print('--------------------------');
                  // users.doc('Azizur Rahaman').snapshots().listen((result) {
                  //   print(result.data());
                  // });
                },
                child: Text('Read data from firebase')),
            ElevatedButton(
                onPressed: () async {
                  CollectionReference users =
                      await firebaseFirestore.collection('users');

                  users.doc('Azizur Rahaman').update({
                    'name': 'Azizur Rahaman Akash',
                  });
                },
                child: Text('Update data')),
            ElevatedButton(
                onPressed: () async {
                  CollectionReference users =
                      firebaseFirestore.collection('users');

                  users.doc('Azizur Rahaman').delete();
                },
                child: Text('Delete data')),
          ],
        ),
      ),
    );
  }
}
