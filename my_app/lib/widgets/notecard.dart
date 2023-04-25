// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard(
    Function()? onTap, QueryDocumentSnapshot doc, BuildContext context) {
  return InkWell(
    onTap: onTap,
    child: Container(
      // height: 200,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            doc['notes_title'] ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 10),
          Text(
            doc['current_date'] ?? "",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              doc['note_content'] ?? '',
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                // icon: Icon(Icons.favorite),
                icon: doc['fav'] == false
                    ? const Icon(Icons.favorite_border_sharp)
                    : const Icon(Icons.favorite_sharp),
                tooltip: "Favorite",
                onPressed: () async {
                  if (doc['fav'] == true) {
                    await FirebaseFirestore.instance
                        .collection("Notes")
                        .doc(doc.id)
                        .update({
                      "fav": false,
                    }).then(
                      (value) => {
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
                        .doc(doc.id)
                        .update({
                      "fav": true,
                    }).then(
                      (value) => {
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
              IconButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("Notes")
                      .doc(doc.id)
                      .set(
                    {
                      'passFor': "hey",
                    },
                    SetOptions(merge: true),
                  );
                },
                iconSize: 20,
                icon: const Icon(Icons.lock_open),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Do you want to delete"),
                        actions: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          const SizedBox(width: 15),
                          InkWell(
                            onTap: () async {
                              if (doc['fav'] == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "Cannot delete the Favourite Note!"),
                                  ),
                                );
                                Navigator.pop(context);
                              } else {
                                Navigator.pop(context);
                                await FirebaseFirestore.instance
                                    .collection("Notes")
                                    .doc(doc.id)
                                    .delete()
                                    .then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Deleted Successfully"),
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))
            ],
          ),
        ],
      ),
    ),
  );
}
