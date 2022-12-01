// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar(
    int indexPage, {
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;
  int indexPage = 0;

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.indexPage,
      fixedColor: Colors.green[400],
      onTap: (int page) {
        setState(() {
          widget.indexPage = page;
        });
        widget.controller.animateToPage(
          widget.indexPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.draw),
          label: 'Principal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_activity_rounded),
          label: 'Tarefas',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_reaction_outlined),
          label: 'Diversão',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.games),
          label: 'Jogos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people_outline),
          label: 'Amigos',
        ),
      ],
    );
  }
}
