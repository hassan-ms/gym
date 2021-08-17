import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/fitness/v1.dart';
import 'package:provider/provider.dart';
import '../providers/auth-provider.dart';

class Developer extends StatefulWidget {
  @override
  _DeveloperState createState() => _DeveloperState();
}

class _DeveloperState extends State<Developer> {
  var client;
  @override
  void initState() {
    client = Provider.of<AuthProvider>(context, listen: false).client;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    // FirebaseFirestore.instance
    //     .collection('muscles')
    //     .doc('back')
    //     .collection('exercises')
    //     .add(
    //   {
    //     'name': 'lat pulldown',
    //     'cover':
    //         'https://i.pinimg.com/originals/3c/56/bd/3c56bd69292e8680478a2cf0ef14791b.png',
    //   },
    // );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Provider.of<AuthProvider>(context, listen: false).signOut();
                  Navigator.pushReplacementNamed(context, 'login');
                },
                child: Text('out')),
            TextButton(
                onPressed: () async {
                  final sessions =
                      await FitnessApi(client).users.dataset.aggregate(
                          AggregateRequest.fromJson({
                            "aggregateBy": [
                              {
                                "dataTypeName": "com.google.weight",
                              }
                            ],
                            // "bucketByTime": {
                            //     "durationMillis":
                            //         Duration(days: 5).inMilliseconds.toString()
                            // },
                            "startTimeMillis": DateTime.now()
                                .subtract(Duration(days: 10))
                                .millisecondsSinceEpoch
                                .toString(),
                            "endTimeMillis": DateTime.now()
                                .add(Duration(days: 3))
                                .millisecondsSinceEpoch
                                .toString(),
                          }),
                          'me');
                  sessions.bucket.forEach((element) {
                    print("steps:........." +
                        element.dataset[0].point[0].value[0].fpVal.toString());
                    final date = int.parse(element.startTimeMillis);
                    print("day:..........." +
                        DateTime.fromMillisecondsSinceEpoch(date).toString());

                    // print("name2: .........." +
                    //     element.dataset[0].point[0].value[0].intVal.toString());
                  });
                },
                child: Text('upload')),
          ],
        ),
      ),
    );
  }
}
