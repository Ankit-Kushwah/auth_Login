import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:google_sign_in/google_sign_in.dart';






class IncrementBloc implements BlocBase{
  int _counter;
  bool loggedIn=false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes:['email']);

  final StreamController<int> _counterController= StreamController<int>();
  StreamSink<int> get _add => _counterController.sink;
  Stream<int> get output => _counterController.stream;


  //stream for events
   final StreamController<int> _eventController = StreamController<int>();
   StreamSink get increment => _eventController.sink;

   IncrementBloc(){
     _counter=0;
     _eventController.stream.listen(_onData);
   }

  // IncrementBloc() {
  //   try{
  //      _googleSignIn.signIn();
  //
  //     loggedIn=true;
  //
  //   }
  //   catch(err){
  //     print(err);
  //   }
  // }
  void _onData(int event) {
    _counter +=1;
    _add.add(_counter);
  }
  // void _onData(int event) {
  //   try{
  //     _googleSignIn.signIn();
  //     loggedIn=true;
  //   }
  //   catch(err){
  //     print(err);
  //   }
  // }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _eventController.close();
    _counterController.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }





}



