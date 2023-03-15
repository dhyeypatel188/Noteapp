import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNote extends StatefulWidget {
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              ref.add({
                'title': title.text,
                'note': content.text,
              }).whenComplete(() => Navigator.pop(context));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey,
            ),
            child: buildText('Save'),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(children: [
          Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextFormField(
              controller: title,
              decoration: InputDecoration(hintText: 'Title'),
              style: TextStyle(color: Colors.white),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(border: Border.all()),
            child: TextFormField(
              controller: content,
              maxLines: null,
              expands: true,
              decoration: InputDecoration(hintText: 'Note'),
            ),
          ))
        ]),
      ),
    );
  }
}

buildText(String text) => Text(
      text,
      style: TextStyle(fontSize: 20),
    );
