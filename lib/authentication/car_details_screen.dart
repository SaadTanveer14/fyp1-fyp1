import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_dutch/global/global.dart';
import 'package:go_dutch/splashScreen/splash_screen.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen({Key? key}) : super(key: key);

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {


  TextEditingController vehiclemodeltextEditingController = TextEditingController();
  TextEditingController vehiclenumbertextEditingController = TextEditingController();
  TextEditingController vehiclecolortextEditingController = TextEditingController();
  List<String> vehicleTypeList = ["car","van","motor-bike","bicycle"];
  String? selectedvehicletype;


  saveCardetails()
  {
    Map usersvehicleinfomap={
      "vehicle_model" : vehiclemodeltextEditingController.text.trim(),
      "vehicle_number" : vehiclenumbertextEditingController.text.trim(),
      "vehicle_color": vehiclecolortextEditingController.text.trim(),
      "vehicle_type" : selectedvehicletype,
    };

    DatabaseReference usersref =  FirebaseDatabase.instance.ref().child("Users");
    usersref.child(currentfirebaseuser!.uid).child("vehicle_details").set(usersvehicleinfomap);
    
    Fluttertoast.showToast(msg: "Congrats! Your vehicle details have been saved");
    Navigator.push(context, MaterialPageRoute(builder: (c)=> const MySplashScreen()));

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
              const SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/car.png",width: 300,height: 200,),

              ),
              const SizedBox(height: 5,),
              Align(
                alignment: Alignment(0,0),
                child: Text(
                  "Vehicle Details!",
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
              const SizedBox(height: 10,),
              TextField(
                controller: vehiclemodeltextEditingController,
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


                    hintText: "Model",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    )

                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: vehiclenumbertextEditingController,
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


                    hintText: "Number",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    )

                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: vehiclecolortextEditingController,
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


                    hintText: "Color",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                    )

                ),
              ),
              SizedBox(height: 10,),

              DropdownButton(
                dropdownColor: Colors.white,
                hint: const Text(
                  "Please choose Vehicle Type",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                value: selectedvehicletype,
                onChanged: (newValue){
                  setState(() {
                    selectedvehicletype = newValue.toString();
                  });
                },
                items: vehicleTypeList.map((vehicle){
                  return DropdownMenuItem(
                      child: Text(
                        vehicle,
                        style: const TextStyle(
                          color: Colors.black
                        ),
                      ),
                    value: vehicle,
                  );

                }).toList(),
              ),
              SizedBox(height: 10,),
              Container(
                height: 50.0,
                margin: EdgeInsets.all(10),
                child: RaisedButton(
                  onPressed: () {

                    if(vehiclemodeltextEditingController.text.isNotEmpty
                        && vehiclenumbertextEditingController.text.isNotEmpty
                        && vehiclecolortextEditingController.text.isNotEmpty
                        && selectedvehicletype !=null){
                      saveCardetails();
                    }

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
                        "Save Now",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ),

            ],

    ),
        ),
    ),
    );
  }
}
