import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  const TopPart({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Here the height of the container is 45% of our total height

      height: size.height * .35,

      decoration: BoxDecoration(
        color: Color(0xFFF5CEB8),
        image: DecorationImage(
          scale: 4,
          alignment: Alignment.centerRight,
          image: AssetImage("assets/images/Group_02.png"),
        ),
      ),
    );
  }
}
