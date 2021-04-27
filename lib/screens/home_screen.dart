import 'package:flutter/material.dart';
import '../widgets/category_card.dart';
import '../widgets/top-part.dart';
import '../widgets/bottom-bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    var _islandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      // bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          _islandscape ? Container() : TopPart(size: size),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.09,
                  ),
                  Text(
                    "Welcome\nto GYM",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: size.height * 0.08),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: _islandscape ? 2 : .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Biceps",
                          imgSrc: "assets/images/biceps.png",
                        ),
                        CategoryCard(
                          title: "Triceps",
                          imgSrc: "assets/images/864.png",
                        ),
                        CategoryCard(
                          title: "Legs",
                          imgSrc: "assets/images/legs.png",
                        ),
                        CategoryCard(
                          title: "shoulders",
                          imgSrc: "assets/images/shoulders.png",
                        ),
                        CategoryCard(
                          title: "Chest",
                          imgSrc: "assets/images/chest.png",
                        ),
                        CategoryCard(
                          title: "Back",
                          imgSrc: "assets/images/back.png",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomBar(ctx: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed('new-exercise-screen');
        },
      ),
    );
  }
}
