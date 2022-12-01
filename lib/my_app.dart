import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/views/pages/blob_page.dart';
import 'package:flutter_application_1/src/views/pages/circular_canvas_page.dart';
import 'package:flutter_application_1/src/views/pages/home_page.dart';
import 'package:flutter_application_1/src/views/pages/todo_list_page.dart';
import 'package:flutter_application_1/src/views/widgets/one_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/one': (context) => const OnePage(),
        '/particles': (context) => const CircularCanavasPage(),
        '/todo': (context) => const TodoListPage(),
        '/blob': (context) => const BlobPage()
      },
      //home: const HomePage(),
    );
  }
}
