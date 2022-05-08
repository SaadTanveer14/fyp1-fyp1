import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_dutch/authentication/signup_screen.dart';
import 'package:go_dutch/splashScreen/splash_screen.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';


class LoginScreen extends StatefulWidget {


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();




  validateform()
  {

    if(!emailtextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "email is not correct!");
    }else if(passwordtextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "password is required!");
    }else{
      loginusernow();
    }
  }
  loginusernow() async {
    showDialog(
        context : context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Processing Please wait...",);
        }
    );
    final User? firebaseUser = (
        await firebaseAuth.signInWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error" + msg.toString());
        })
    ).user;

    if(firebaseUser!=null){

      currentfirebaseuser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfull!");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));


    }else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error occured during Login..");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/car.png",width: 300,height: 200,),

              ),
              const SizedBox(height: 5,),
              Align(
                alignment: Alignment(-0.88,0),
                child: Text(
                  "Lets Get Start!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mulish',
                    letterSpacing: 0,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: emailtextEditingController,
                keyboardType: TextInputType.emailAddress,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,

                ),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(
                        Radius.circular(20)
                    ),
                        borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2
                        )

                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(
                        Radius.circular(20)
                    ),
                        borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2
                        )

                    ),


                    hintText: "Email",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    )

                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: passwordtextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,

                ),
                decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white70,
                    enabledBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(
                        Radius.circular(20)
                    ),
                        borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2
                        )

                    ),
                    focusedBorder: OutlineInputBorder(borderRadius: const BorderRadius.all(
                        Radius.circular(20)
                    ),
                        borderSide: BorderSide(
                            color: Colors.orangeAccent,
                            width: 2
                        )

                    ),


                    hintText: "Password",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    )

                ),
              ),
              SizedBox(height: 10,),
              Container(
                height: 50.0,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {

                    validateform();
                    //Navigator.push(context, MaterialPageRoute(builder: (c)=> CarDetailScreen()));

                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints:
                      BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),

              TextButton(
                child: const Text(
                  "Don't have an account? SignUp here..",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> SignUpScreen()));
                },
              )





            ],
          ),
        ),
      ),
    );
  }
}
