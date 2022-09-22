import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/pageViews/one_page.dart';
import 'package:flutter_application_1/pages/todo_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int indexBottomNavigationBar = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'App do Murílo',
          textAlign: TextAlign.center,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Murilo'),
              accountEmail: Text('murilo@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Text('M'),
              ),
            ),
            ListTile(
              title: const Text('Desenhos'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(0);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 0;
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Aventuras'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(1);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 1;
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Turma'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(2);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 2;
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Diversão'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(3);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 3;
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Jogos'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(4);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 4;
                  },
                );
              },
            ),
            ListTile(
              title: const Text('Amigos'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _pageController.jumpToPage(5);
                Navigator.pop(context);
                setState(
                  () {
                    indexBottomNavigationBar = 5;
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          const OnePage(),
          const TodoListPage(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.amber[600],
          ),
          Container(
            color: Colors.cyanAccent[600],
          ),
          Container(
            color: Colors.deepOrange[600],
          ),
          Container(
            color: Colors.deepOrange[600],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBottomNavigationBar,
        fixedColor: Colors.green[400],
        onTap: (int page) {
          setState(() {
            indexBottomNavigationBar = page;
          });
          _pageController.animateToPage(
            indexBottomNavigationBar,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.draw),
            label: 'Desenhos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_rounded),
            label: 'Aventuras',
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
      ),
    );
  }
}
