import 'dart:async';
import 'package:auth_sign/loggedIn.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Bloc_Services.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool loggedIn=false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes:['email']);
  void _logout() {
    try {
      _googleSignIn.signOut();
    }
    catch(err){
      print(err);
    }
    }
  void _login() async{
    try{
      await _googleSignIn.signIn();
      getdata();

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoggedIn()), (Route<dynamic> route) => false,);

    }
    catch(err){
      print(err);
    }
  }


  final StreamController<int> _streamController= StreamController<int>();

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  @override
  Widget build(BuildContext context) {

    IncrementBloc incrementBloc = IncrementBloc();


    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body:Center(
        child: Column(
          children:<Widget> [
            const Text('SIGN IN',style:TextStyle(fontSize:24.0,color: Colors.black)),
           Padding(padding:EdgeInsets.all(10.0),
           child:MaterialButton(
               color: Colors.black87,
               child: Row(
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Icon(
                       Icons.email,
                       color: Colors.white,
                       size: 24.0,

                     ),
                   ),
                   const Text('Sign up with Google',style: TextStyle(color: Colors.white),)
                 ],), onPressed:(){
                   _login();
           })),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: MaterialButton(
                 color: Colors.black87,
                 child: Row(
               children: <Widget>[
                 const Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Icon(
                     Icons.login,
                     color: Colors.white,
                     size: 24.0,

                   ),
                 ),
                 Text('Logout',style: TextStyle(color: Colors.white),)
               ],), onPressed:(){
                   _logout();
             }),
           )

          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //
      //
      //
      //   child: const Icon(Icons.add),
      //   onPressed: (){
      //     incrementBloc.increment.add(null);
      //   },
      // ),
    );
  }

  void getdata()  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name',_googleSignIn.currentUser.displayName);
    await prefs.setString('email', _googleSignIn.currentUser.email.toString());
    await prefs.setString('image', _googleSignIn.currentUser.photoUrl.toString());



    print(prefs.getString('name'));
    print(prefs.getString('name'));

  }
}




// Center(
// // ignore: always_specify_types
// child: StreamBuilder(
// stream: incrementBloc.output,
// initialData: _counter,
// builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
// return Text('Testing Bock counter ${snapshot.data}');
// },
// ),)