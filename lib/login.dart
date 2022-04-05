import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_class/signup.dart';
import 'package:firestore_class/todo.dart';
import 'package:flutter/material.dart';
import 'home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  loginUser() async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passController.text);

      emailController.clear();
      passController.clear();
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
            // style: TextStyle(color: white),
            controller: emailController,
            autocorrect: true,
            // autofocus: true,
            // obscureText: true,

            keyboardType: TextInputType.name,
            // validator: (val) =>
            //     val!.isEmpty ? "This field must not be empty!" : null,
            decoration: InputDecoration(
              // prefixIconColor: Colors.white,

              labelText: "Email",
              // labelStyle: TextStyle(color: white),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              helperText: "rafay@gmail.com",
            ),
          ),
          const SizedBox(
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
              loginUser();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  MyTodo(),
                ),
              );
            },
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  Signup(),
                ),
              );
            },
            child: const Text("Go to Singup Screen"),
          ),
        ],
      ),
    ));
  }
}
