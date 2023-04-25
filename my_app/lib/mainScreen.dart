import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_app/Notereader.dart';
import 'package:my_app/widgets/notecard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Recent Notes",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          // sizedBox
          const SizedBox(height: 10),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection("Notes").snapshots(),
              // initialData: null,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                  // return const Center(child: CircularProgressIndicator());
                }
                return GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  children: snapshot.data!.docs
                      .map(
                        (note) => noteCard(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => NoteReaderScreen(note),
                            ),
                          );
                        }, note, context),
                      )
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
