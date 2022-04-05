import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_class/login.dart';
import 'package:firestore_class/todo.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Signup extends StatelessWidget {
  Signup({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  createUser() async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailController.text, password: passController.text);

      emailController.clear();
      passController.clear();
      print("Done signup");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            controller: nameController,
            autocorrect: true,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "Username",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              helperText: "Abdul Rafay",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: emailController,
            autocorrect: true,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: "Email",
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              helperText: "rafay@gmail.com",
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            // style: TextStyle(color: white),
            controller: passController,
            autocorrect: true,
            // autofocus: true,
            // obscureText: true,

            keyboardType: TextInputType.name,
            // validator: (val) =>
            //     val!.isEmpty ? "This field must not be empty!" : null,
            decoration: InputDecoration(
              // prefixIconColor: Colors.white,

              labelText: "Password",
              // labelStyle: TextStyle(color: white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              // helperText: "Abdul Rafay",
            ),
          ),
          ElevatedButton(
            onPressed: () {
              createUser();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyTodo(),
                ),
              );
            },
            child: const Text("Signup"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
            child: const Text("Go to login Screen"),
          ),
        ],
      ),
    ));
  }
}
