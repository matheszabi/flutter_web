import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web/main_screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String adminEmail = "";
  String adminPassword = "";

  allowToAdminLogin() async {
    SnackBar snackBar = const SnackBar(
      content: Text(
        "Checking credentials, please wait!",
        style: TextStyle(fontSize: 36, color: Colors.black38),
      ),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 4),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    User? currentAdmin;
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: adminEmail,
      password: adminPassword,
    )
        .then((fAuth) {
      //success
      currentAdmin = fAuth.user;
    }).catchError((onError) {
      // in case of error
      // display error message
      final snackBar = SnackBar(
        content: Text(
          "Error occurred" + onError.toString(),
          style: const TextStyle(
            fontSize: 36,
          ),
        ),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    // it is authenticated with email + password
    if (currentAdmin != null) {
      // check if that admin records also exits in the admins collection in firestore database
      await FirebaseFirestore.instance
          .collection("admins")
          .doc(currentAdmin!.uid)
          .get()
          .then((snap) {
        if (snap.exists) {
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const HomeScreen()));
        }
        else {
          // no record exists
          SnackBar snackBar = const SnackBar(
            content: Text(
              "No record found => you are not an admin",
              style: TextStyle(fontSize: 36, color: Colors.black38),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 6),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      );
    }
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.black38,
        body: Stack(
          children: [
            Center(
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //image:
                    Image.asset("images/admin.png"),

                    const SizedBox(
                      height: 10,
                    ),

                    // email text fiield
                    TextField(
                      onChanged: (value) {
                        adminEmail = value;
                      },
                      style: const TextStyle(fontSize: 16,
                          color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyanAccent,
                                width: 2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                                width: 2,
                              )),
                          hintText: "Email",
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          icon: Icon(
                            Icons.email,
                            color: Colors.cyanAccent,
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // password
                    TextField(
                      onChanged: (value) {
                        adminPassword = value;
                      },
                      obscureText: true,
                      style: const TextStyle(fontSize: 16,
                          color: Colors.white),
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.cyanAccent,
                                width: 2,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.pinkAccent,
                                width: 2,
                              )),
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.blueGrey),
                          icon: Icon(
                            Icons.ac_unit_outlined,
                            color: Colors.cyanAccent,
                          )),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    //button login:
                    ElevatedButton(
                      onPressed: () {
                        allowToAdminLogin();
                      },
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20)),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                              Colors.cyanAccent),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.pinkAccent)),
                      child: const Text("Login",
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 16,
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }
  }
