import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Developer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    FirebaseFirestore.instance
        .collection('muscles')
        .doc('back')
        .collection('exercises')
        .add(
      {
        'name': 'lat pulldown',
        'cover':
            'https://i.pinimg.com/originals/3c/56/bd/3c56bd69292e8680478a2cf0ef14791b.png',
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(onPressed: () {}, child: Text('cloud')),
            TextButton(onPressed: () async {}, child: Text('upload')),
          ],
        ),
      ),
    );
  }
}
