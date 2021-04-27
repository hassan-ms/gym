import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:gym/screens/exercises-screen.dart';
import 'package:gym/screens/home_screen.dart';
import 'package:gym/screens/login-screen.dart';
import 'package:gym/screens/new-exercise-screen.dart';
import 'package:provider/provider.dart';
import './constants.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Gym',
        theme: ThemeData(
          fontFamily: "Cairo",
          scaffoldBackgroundColor: kBackgroundColor,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: kTextColor),
        ),
        home: LoginScreen(),
        routes: {
          'excercises-screen': (ctx) => ExcercisesScreen(),
          'new-exercise-screen': (ctx) => NewExerciseScreen(),
          'home-screen': (ctx) => HomeScreen(),
          'login': (ctx) => LoginScreen(),
        },
      ),
    );
  }
}
