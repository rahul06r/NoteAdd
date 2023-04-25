// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  DateTime txdate = DateTime.now();

  late String d = DateFormat.yMd().add_jms().format(txdate);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note Here"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade400,
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "notes_title": title.text,
            "current_date": d,
            "note_content": description.text,
            'fav': false,
          }).then((value) {
            Navigator.pop(context);
          }).catchError(
            (e) => ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Noted Added Successfully"),
              ),
            ),
          );
        },
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Add NOTE",
              ),
            ),
            const SizedBox(height: 10),
            Text(
              d,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Add Content",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ],
        ),
      ),
    );
  }
}
