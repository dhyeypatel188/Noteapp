import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mynotes1/addnote.dart';

class EditNote extends StatefulWidget {
  // EditNote({super.key});

  DocumentSnapshot docToEdit;
  EditNote({required this.docToEdit});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController title = TextEditingController();

  TextEditingController content = TextEditingController();

  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit['title']);
    content = TextEditingController(text: widget.docToEdit['note']);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              widget.docToEdit.reference.update({
                'title': title.text,
                'note': content.text,
              }).whenComplete(() => Navigator.pop(context));

              // ref.add({
              //   'title': title.text,
              //   'note': content.text,
              // }).whenComplete(() => Navigator.pop(context));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey,
            ),
            child: buildText('Save'),
          ),
          TextButton(
            onPressed: () {
              widget.docToEdit.reference
                  .delete()
                  .whenComplete(() => Navigator.pop(context));

              // ref.add({
              //   'title': title.text,
              //   'note': content.text,
              // }).whenComplete(() => Navigator.pop(context));
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: Colors.blueGrey,
            ),
            child: buildText('Delete'),
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
