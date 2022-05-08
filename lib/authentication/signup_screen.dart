import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_dutch/authentication/car_details_screen.dart';
import 'package:go_dutch/authentication/login_screen.dart';
import 'package:go_dutch/global/global.dart';
import 'package:go_dutch/widgets/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController cnictextEditingController = TextEditingController();



  validateform(){

    if(nametextEditingController.text.length < 3){
      Fluttertoast.showToast(msg: "name must be atleast 3 characters!!");
    }else if(!emailtextEditingController.text.contains("@")){
      Fluttertoast.showToast(msg: "email is not correct!");
    }else if(passwordtextEditingController.text.length <6){
      Fluttertoast.showToast(msg: "password must be atleast 6 characters!!");
    }else if(phonetextEditingController.text.isEmpty){
      Fluttertoast.showToast(msg: "phonenumber is mandatory!!");

    }else if(phonetextEditingController.text.length >11){
      Fluttertoast.showToast(msg: "phone number must be 11 numbers!");
    }else if(cnictextEditingController.text.length >13){
      Fluttertoast.showToast(msg: "cnic must be 13 numbers!");
    }
    else{
      saveInfotofirebase();

    }
  }

  saveInfotofirebase() async {
    showDialog(
        context : context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(message: "Processing Please wait...",);
        }
    );
    final User? firebaseUser = (
        await firebaseAuth.createUserWithEmailAndPassword(
          email: emailtextEditingController.text.trim(),
          password: passwordtextEditingController.text.trim(),
        ).catchError((msg){
          Navigator.pop(context);
          Fluttertoast.showToast(msg: "Error" + msg.toString());
        })
    ).user;

    if(firebaseUser!=null){

      Map usersmap={
        "id":firebaseUser.uid,
        "name": nametextEditingController.text.trim(),
        "email": emailtextEditingController.text.trim(),
        "password" : passwordtextEditingController.text.trim(),
        "phone" : phonetextEditingController.text.trim(),
        "cnic"  :cnictextEditingController.text.trim(),
      };
      DatabaseReference usersref =  FirebaseDatabase.instance.ref().child("Users");
      usersref.child(firebaseUser.uid).set(usersmap);


      currentfirebaseuser = firebaseUser;
      Fluttertoast.showToast(msg: "Accout has been created");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> CarDetailScreen()));


    }else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Accout has not been created");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 60,),
              Align(
                alignment: Alignment(-0.75,1),
                child: const Text(
            "Welcome to GoDutch",
            textAlign: TextAlign.left,
            style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Mulish',
                  letterSpacing: 0,
                  height: 1,
                  decoration: TextDecoration.none,
            ),
          ),
              ),
              SizedBox(height: 8,),
              Align(
                alignment: Alignment(-0.6,1),
                child: Text(
                  "Share a secure ride with your neighbors!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Mulish',
                    letterSpacing: 0,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment(0,0),
                child: Text(
                  "Create an Account!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Mulish',
                    letterSpacing: 0,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: nametextEditingController,
                keyboardType: TextInputType.text,
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


                    hintText: "Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15
                  )

                ),
              ),
              SizedBox(height: 10,),
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
              TextField(
                controller: phonetextEditingController,
                keyboardType: TextInputType.phone,
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

                    hintText: "Phone Number",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15
                  )

                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: cnictextEditingController,
                keyboardType: TextInputType.number,
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


                  hintText: "CNIC",
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
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  "Already have an account? Login here..",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
