import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/editScreen.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen(this.doc, {super.key});

  final DocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  late String ids;
  void fc() {
    ids = widget.doc.id;
  }

  @override
  void initState() {
    super.initState();
    fc();
    setState(() {
      widget.doc['fav'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange.shade400,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditScreen(
              titlesdit: widget.doc['notes_title'],
              descriptionedit: widget.doc['notes_title'],
              id: ids,
            ),
          ));
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          // IconButton(
          //   color: Colors.red,
          //   tooltip: "Delete",
          //   onPressed: () async {
          //     showDialog(
          //       context: context,
          //       builder: (BuildContext context) => AlertDialog(
          //         title: const Text("Do you want to delete"),
          //         actions: [
          //           InkWell(
          //             onTap: () {
          //               Navigator.pop(context);
          //             },
          //             child: const Text("No"),
          //           ),
          //           const SizedBox(width: 15),
          //           InkWell(
          //             onTap: () async {
          //               if (widget.doc['fav'] == true) {
          //                 ScaffoldMessenger.of(context).showSnackBar(
          //                   const SnackBar(
          //                     content:
          //                         Text("Cannot delete the Favourite Note!"),
          //                   ),
          //                 );
          //                 Navigator.pop(context);
          //               } else {
          //                 Navigator.pop(context);
          //                 await FirebaseFirestore.instance
          //                     .collection("Notes")
          //                     .doc(widget.doc.id)
          //                     .delete()
          //                     .then(
          //                   (value) {
          //                     Navigator.pop(context);
          //                     ScaffoldMessenger.of(context).showSnackBar(
          //                       const SnackBar(
          //                         content: Text("Deleted Successfully"),
          //                       ),
          //                     );
          //                   },
          //                 );
          //               }
          //             },
          //             child: const Text("Yes"),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          //   icon: const Icon(Icons.delete),
          // ),
          IconButton(
            icon: widget.doc['fav'] == false
                ? const Icon(Icons.favorite_border_sharp)
                : const Icon(Icons.favorite_sharp),
            tooltip: "Favorite",
            onPressed: () async {
              if (widget.doc['fav'] == true) {
                await FirebaseFirestore.instance
                    .collection("Notes")
                    .doc(widget.doc.id)
                    .update({
                  "fav": false,
                }).then(
                  (value) => {
                    Navigator.pop(context),
                    setState(() {
                      // widget.doc['fav'] == false;
                    }),
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Removed from Favourite"),
                      ),
                    )
                  },
                );
              } else {
                await FirebaseFirestore.instance
                    .collection("Notes")
                    .doc(widget.doc.id)
                    .update({
                  "fav": true,
                }).then(
                  (value) => {
                    Navigator.pop(context),
                    setState(() {
                      // widget.doc['fav'] == true;
                    }),
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added As Favourite"),
                      ),
                    )
                  },
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot<Map>>(
            stream: FirebaseFirestore.instance
                .collection("Notes")
                .doc(widget.doc.id)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Data"),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      snapshot.data?['notes_title'] ?? 'null',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Text(
                        snapshot.data?['current_date'] ?? "null",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    snapshot.data?['note_content'] ?? "null",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
