// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   static String uid = '';

//   @override
//   void initState() {
//     super.initState();
//     getuid();
//   }

//   getuid() async {
//     User? user = FirebaseAuth.instance.currentUser;
//     // uid = user!.uid;
//     setState(() {
//       uid = user!.uid;
//     });
//   }

//   // ignore: prefer_final_fields
//   Stream<DocumentSnapshot> _usersStream =
//       FirebaseFirestore.instance.collection("users").doc(uid).snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: StreamBuilder<DocumentSnapshot>(
//             stream: _usersStream,
//             builder: (BuildContext context,
//                 AsyncSnapshot<docum> snapshot) {
//               if (snapshot.hasError) {
//                 return Text('Something went wrong');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Text("Loading");
//               } else {
//                 final docs = snapshot.data!.get({});
//                 return ListView.builder(
//                     itemCount: docs.length,
//                     itemBuilder: ((context, index) {
//                       return ListTile(
//                           title: Text(docs[index]['email']),
//                           subtitle: Text(docs[index]['username']));
//                     }));
//               }
//             }),
//       ),
//     );
//   }
// }
