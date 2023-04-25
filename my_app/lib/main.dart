import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/addnotescreen.dart';
import 'package:my_app/info_page.dart';
import 'package:my_app/mainScreen.dart';

import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
        ),
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // if (snapshot.hasData) {
          return Builder(builder: (context) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 70,
                centerTitle: true,
                title: const Text(
                  "App Note",
                  style: TextStyle(
                    fontSize: 28,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: IconButton(
                      iconSize: 30,
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const InfoPage()));
                      },
                      icon: const Icon(Icons.question_mark_outlined),
                      color: Colors.white,
                      tooltip: 'Info',
                    ),
                  ),
                ],
              ),
              body: const SafeArea(
                child: MainScreen(),
              ),
              floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Colors.orange.shade400,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => AddNoteScreen()));
                },
                label: const Text("Add Note"),
                icon: const Icon(
                  Icons.add,
                ),
              ),
            );
          });
          // } else {
          //   return const LoginForm();
          // }
        },
      ),
    );
  }
}
