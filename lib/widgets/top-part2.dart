import 'package:flutter/material.dart';

class TopPart2 extends StatelessWidget {
  const TopPart2({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * .32,
      width: double.infinity,
      decoration: BoxDecoration(
        // color: Color(0xFFF5CEB8),
        image: DecorationImage(
          fit: BoxFit.cover,
          scale: 1,
          alignment: Alignment.centerRight,
          image: AssetImage(
              "assets/images/blurred-background-rows-black-dumbbells-rack-gym_42687-402.jpg"),
        ),
      ),
      // child: Image.asset("assets/images/blurred-background-rows-black-dumbbells-rack-gym_42687-402.jpg"),
    );
  }
}
