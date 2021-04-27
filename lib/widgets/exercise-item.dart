import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:gym/screens/exercises-screen.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

class ExerciseItem extends StatefulWidget {
  final Exercise exercise;
  final String lastWeight;
  final ctx;

  ExerciseItem(
      {@required this.exercise, @required this.lastWeight, @required this.ctx});

  @override
  _ExerciseItemState createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  String newWeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.black54),
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -23,
            color: kShadowColor,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            String weight = "";
            await showDialog(
                context: context,
                barrierDismissible: true,
                builder: (ctx) => AlertDialog(
                      scrollable: true,
                      elevation: 10,
                      title: Text('add new weight'),
                      content: TextFormField(
                        maxLength: 4,
                        keyboardType: TextInputType.number,
                        initialValue: weight,
                        style: TextStyle(fontSize: 22),
                        onChanged: (val) {
                          weight = val;
                        },
                      ),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              try {
                                final uid = Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .gUser
                                    .id;
                                if (weight != "") {
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(uid)
                                      .update({widget.exercise.id: weight});
                                  setState(() {
                                    newWeight = weight;
                                  });
                                  Navigator.of(context).pop();
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
                                    content: Text(
                                        'error ! check network and try again')));
                              }
                            },
                            child:
                                Text('submit', style: TextStyle(fontSize: 18)))
                      ],
                    ));
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Text(
                    widget.exercise.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 6,
                  child: Container(
                    child: widget.exercise.cover == null
                        ? Image.asset(
                            'assets/images/gym-exercise-4-1104368.png')
                        : Image.network(
                            widget.exercise.cover,
                            fit: BoxFit.contain,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              print(exception);
                              return Container(
                                child: Image.asset(
                                    'assets/images/gym-exercise-4-1104368.png'),
                              );
                            },
                          ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 1,
                  child: Text(
                    "last weight ${newWeight == null ? widget.lastWeight : newWeight} KG",
                    style: TextStyle(fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
