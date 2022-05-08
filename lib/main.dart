import 'package:flutter/material.dart';
import 'package:go_dutch/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '/blocs/app_blocs.dart';


void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp(
        child: MaterialApp(
          
          title: 'goDutch',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MySplashScreen() ,
          debugShowCheckedModeBanner: false,
        ),

      ));
}

class MyApp extends StatefulWidget {

  final Widget? child;
  MyApp({this.child});


  static void restartApp(BuildContext context){
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Key key = UniqueKey();
  void restartApp(){

    setState(() {
      key = UniqueKey();
    });
  }



  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(

        key: key,
        child: widget.child!,
    );
  }
}

