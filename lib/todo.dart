import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyTodo extends StatefulWidget {
  const MyTodo({Key? key}) : super(key: key);

  @override
  State<MyTodo> createState() => _MyTodoState();
}

class _MyTodoState extends State<MyTodo> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  addTodo() async {
    if (titleController.text != "" && descriptController.text != "") {
      var time = DateTime.now();
      await FirebaseFirestore.instance
          .collection('todos')
          .doc(uid)
          .collection("mytasks")
          .doc(time.toString())
          .set({
        'title': titleController.text,
        'description': descriptController.text,
        'time': time.toString(),
        'timestamp': time,
        'ischecked': false,
      });
      titleController.clear();
      descriptController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Task Added "),
        duration: Duration(seconds: 3),
      ));
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No title or description added"),
        ),
      );
    }
  }

  String uid = '';
  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    User? user = FirebaseAuth.instance.currentUser;
    // uid = user!.uid;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('todos')
              .doc(uid)
              .collection('mytasks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text("An error occured here");
            }
            if (!snapshot.hasData) {
              return Text("3rd");
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(docs[index]['title']),
                    subtitle: Text(docs[index]['description']),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Text("Add Todo"),
                                // contentPadding: EdgeInsets.all(10),
                                content: Container(
                                  // color: Colors.white70,
                                  height:
                                      MediaQuery.of(context).size.height * 0.28,
                                  width: 400,
                                  child: Column(
                                    children: [
                                      TextField(
                                        controller: titleController,
                                        decoration: const InputDecoration(
                                          hintText: "Title",
                                        ),
                                      ),
                                      TextField(
                                        controller: descriptController,
                                        decoration: const InputDecoration(
                                          hintText: "Description",
                                        ),
                                      ),
                                      ButtonBar(
                                        alignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancel"),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              var time = DateTime.now();

                                              FirebaseFirestore.instance
                                                  .collection('todos')
                                                  .doc(uid)
                                                  .collection("mytasks")
                                                  .doc(docs[index]['time'])
                                                  .update({
                                                'title': titleController.text,
                                                'description':
                                                    descriptController.text,
                                                'time': time.toString(),
                                                'timestamp': time,
                                                'ischecked': false,
                                              });
                                              titleController.clear();
                                              descriptController.clear();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text("Task Added "),
                                                duration: Duration(seconds: 3),
                                              ));
                                            },
                                            child: const Text("Add"),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.edit),
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: const Text("Add Todo"),
                  // contentPadding: EdgeInsets.all(10),
                  content: Container(
                    // color: Colors.white70,
                    height: MediaQuery.of(context).size.height * 0.28,
                    width: 400,
                    child: Column(
                      children: [
                        TextField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            hintText: "Title",
                          ),
                        ),
                        TextField(
                          controller: descriptController,
                          decoration: const InputDecoration(
                            hintText: "Description",
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: addTodo,
                              child: const Text("Add"),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
