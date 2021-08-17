import 'package:flutter/material.dart';
import 'package:gym/providers/auth-provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      try {
        setState(() {
          _isLoading = true;
        });

        final auth = Provider.of<AuthProvider>(context, listen: false);
        await auth.silentSignin();
        if (auth.gUser != null) {
          Navigator.of(context).pushReplacementNamed('developer-screen');
        }
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
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          'assets/images/Hybrid-People-Product-500.png',
          // fit: BoxFit.fitHeight,
          height: size.height * 0.5,
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'GYM',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          _isLoading
              ? Container()
              : FlatButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      final user = await Provider.of<AuthProvider>(context,
                              listen: false)
                          .signInWithGoogle();
                      if (user != null) {
                        await Provider.of<AuthProvider>(context, listen: false)
                            .checkExist();
                        Navigator.of(context)
                            .pushReplacementNamed('developer-screen');
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text('error ! check network and try again')));
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Card(
                    child: Container(
                      height: 40,
                      width: 130,
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/icons/Gicon.png',
                            height: 32,
                            width: 28,
                          ),
                          Text(
                            '  Sign In',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    elevation: 8,
                  )),
          SizedBox(
            height: 80,
          )
        ],
      ),
    ]));
  }
}
