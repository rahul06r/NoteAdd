import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Notereader.dart';
import 'package:my_app/main.dart';
import 'package:my_app/mainScreen.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({
    super.key,
    required this.titlesdit,
    required this.descriptionedit,
    required this.id,
  });
  final String titlesdit;
  final String descriptionedit;
  final String id;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  DateTime txdate = DateTime.now();

  late String d = DateFormat.yMd().add_jms().format(txdate);

  late TextEditingController title;
  late TextEditingController description;
  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.titlesdit);
    description = TextEditingController(text: widget.descriptionedit);
  }

  @override
  void dispose() {
    super.dispose();
    title.dispose();
    description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").doc(widget.id).update({
            "notes_title": title.text,
            "current_date": d,
            "note_content": description.text,
            "color_id": 0,
          }).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Updated Successfully"),
              ),
            );

            // Navigator.of(context, rootNavigator: true).pop();
            Navigator.of(context).pop();
          }).catchError(
            (e) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$e'),
              ),
            ),
          );
        },
        backgroundColor: Colors.orange.shade400,
        child: const Icon(Icons.save),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Edit Title",
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                d,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: description,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Add NOTE",
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
