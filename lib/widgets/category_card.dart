import 'package:flutter/material.dart';
import '../constants.dart';

class CategoryCard extends StatelessWidget {
  final String imgSrc;
  final String title;
  const CategoryCard({
    Key key,
    this.imgSrc,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
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
          onTap: () {
            Navigator.of(context)
                .pushNamed('excercises-screen', arguments: title);
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Spacer(),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    width: _size.width,
                    height: _size.height * 0.5,
                    child: Image.asset(
                      imgSrc,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
