import 'package:flutter/material.dart';
import 'package:mynotes1/addnote.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mynotes1/editnote.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Myapp());
}

// const primaryColor = Color(0xFF151026);

class Myapp extends StatelessWidget {
  const Myapp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        // scaffoldBackgroundColor: Color.fromARGB(255, 6, 3, 3)
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  // HomePage({super.key});

  final ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TGD Notes"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          //To GO TO NEXT PAGE
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => AddNote()),
            );
          },
        ),
        body: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => EditNote(
                                  docToEdit: snapshot.data!.docs[index],
                                )),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(1.5),
                      height: 150,
                      color: Color.fromARGB(255, 52, 50, 50),
                      child: Column(children: [
                        Text(
                          snapshot.data?.docs[index]['note'],
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(snapshot.data?.docs[index]['title'],
                            style: TextStyle(color: Colors.white)),
                      ]),
                    ),
                  );
                },
              );
            }));
  }
}
