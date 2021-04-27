import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:gym/widgets/top-part2.dart';
import 'package:provider/provider.dart';
import '../widgets/bottom-bar.dart';

class NewExerciseScreen extends StatefulWidget {
  @override
  _NewExerciseScreenState createState() => _NewExerciseScreenState();
}

class _NewExerciseScreenState extends State<NewExerciseScreen> {
  var userID = "";
  String _name = "";

  String _muscle = "biceps";

  String _lastWeight = "0";
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    userID = Provider.of<AuthProvider>(context).gUser.id;
    final size = MediaQuery.of(context).size;
    // final _islandscape =
    //     MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TopPart2(size: size),
          SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              margin: EdgeInsets.only(top: size.height * 0.18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Add Exercise",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Exercise name',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 100,
                            child: TextFormField(
                              maxLength: 15,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'exercise name can\'t be empty';
                                }
                                return '';
                              },
                              initialValue: _name,
                              onChanged: (val) {
                                _name = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('muscle', style: TextStyle(fontSize: 18)),
                          Container(
                            margin: EdgeInsets.only(
                              right: 20,
                            ),
                            child: DropdownButton<String>(
                              items: [
                                'biceps',
                                'triceps',
                                'shoulders',
                                'back',
                                'chest',
                                'legs'
                              ].map((value) {
                                return DropdownMenuItem<String>(
                                  child: new Text(value),
                                  value: value,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _muscle = value;
                                });
                              },
                              elevation: 10,
                              value: _muscle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'last weigt',
                            style: TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 30,
                            child: TextFormField(
                              maxLength: 4,
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'exercise name can\'t be empty';
                                }
                                return '';
                              },
                              initialValue: _lastWeight,
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                _lastWeight = val;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    _isLoading
                        ? CircularProgressIndicator()
                        : TextButton(
                            onPressed: () async {
                              if (_name == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration: Duration(milliseconds: 500),
                                        content: Text(
                                            'exercise name can\'t be empty')));
                                return;
                              }
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                final db = FirebaseFirestore.instance;
                                final ex = await db
                                    .collection('muscles')
                                    .doc(_muscle)
                                    .collection('userExercises')
                                    .doc(userID)
                                    .collection('exercises')
                                    .add({
                                  'name': _name,
                                });
                                await db
                                    .collection('users')
                                    .doc(userID)
                                    .update({ex.id: _lastWeight});
                                Navigator.of(context)
                                    .pushReplacementNamed('home-screen');
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('error ! check network')));
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            },
                            child:
                                Text('submit', style: TextStyle(fontSize: 22))),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
