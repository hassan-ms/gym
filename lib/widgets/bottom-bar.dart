import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatelessWidget {
  final ctx;
  const BottomBar({
    this.ctx,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('home-screen');
              },
            ),
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .signOut();
                  Navigator.of(context).pushReplacementNamed('login');
                }),
          ],
        ),
      ),
    );
  }
}
