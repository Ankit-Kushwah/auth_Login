import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoggedIn extends StatefulWidget {

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  String email='';
  String userName='';
  String imgUrl='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loggedin'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:108.0),
          child: Text(email),
        ),
      ),
    );
  }

  void getdata() async{

      SharedPreferences preferences=await SharedPreferences.getInstance();
      userName=await preferences.getString('name')??'';
      email=await preferences.getString('email');
      print(email +'anki');

  }
}
