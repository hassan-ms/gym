import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:gym/widgets/top-part2.dart';
import 'package:provider/provider.dart';
import '../widgets/exercise-item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final id;
  final name;
  final cover;

  Exercise({
    @required this.id,
    @required this.name,
    @required this.cover,
  });
}

class ExcercisesScreen extends StatefulWidget {
  @override
  _ExcercisesScreenState createState() => _ExcercisesScreenState();
}

class _ExcercisesScreenState extends State<ExcercisesScreen> {
  List<Exercise> _exercises = [];
  bool _isLoading = false;
  String muscleName = "";
  Map<String, dynamic> weights = {"": ""};
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      final userID = Provider.of<AuthProvider>(context, listen: false).gUser.id;
      muscleName = ModalRoute.of(context).settings.arguments as String;
      setState(() {
        _isLoading = true;
      });
      try {
        final db = FirebaseFirestore.instance;
        final res = await db
            .collection('muscles')
            .doc(muscleName.toLowerCase())
            .collection('exercises')
            .get();
        res.docs.forEach((element) {
          _exercises.add(Exercise(
            id: element.id,
            name: element.data()['name'],
            cover: element.data()['cover'],
          ));
        });
        final res2 = await db
            .collection('muscles')
            .doc(muscleName.toLowerCase())
            .collection('userExercises')
            .doc(userID)
            .collection('exercises')
            .get();

        res2.docs.forEach((element) {
          _exercises.add(Exercise(
            id: element.id,
            name: element.data()['name'],
            cover: element.data()['cover'],
          ));
        });

        final res3 = await db.collection('users').doc(userID).get();
        weights = res3.data();

        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('error ! check network and try again')));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool _islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  TopPart2(size: size),
                  SafeArea(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 0.5),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30))),
                    padding: EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 20),
                    margin: EdgeInsets.only(top: size.height * 0.18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${muscleName} Exercises",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(fontWeight: FontWeight.w900),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio: 5 / 7,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (ctx, index) => ExerciseItem(
                              ctx: context,
                              lastWeight: weights[_exercises[index].id] == null
                                  ? '0'
                                  : weights[_exercises[index].id],
                              exercise: _exercises[index],
                            ),
                            itemCount: _exercises.length,
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ));
  }
}
