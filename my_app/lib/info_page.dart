import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: const [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 15),
                  Text(
                    "This is used to add a note as favourites",
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.favorite),
                  SizedBox(width: 15),
                  Flexible(
                    child: Text(
                      "It means this is a favourite note, then it cannot  be deleted untill it is removed as favourite",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Text(
                    "It is used to delete a note",
                    // maxLines: 2,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Icon(Icons.lock_open),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "It is used to add a lock {Password} to particular note",
                      // maxLines: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                "LOCK -still to be implemented!!!!!!!",
                style: TextStyle(color: Colors.red, fontSize: 20),
                // maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
