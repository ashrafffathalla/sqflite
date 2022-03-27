import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/archive_tasks/archive_tasks_screen.dart';
import '../modules/done_tasks/done_tasks_screen.dart';
import '../modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchiveTasksScreen(),
  ];
  List<String> titles = ['New Tasks', 'Done Tasks', 'Archive Tasks'];
  Database? database;
  @override
  void initState() {
    super.initState();
    createDatabase();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var name = await getName();
          print(name);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_outline,
              ),
              label: 'Done'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.archive_outlined,
              ),
              label: 'Archived'),
        ],
      ),
    );
  }

  Future<String> getName() async {
    return 'Ahmed Ali';
  }

  void createDatabase()async
  {
     database  = await openDatabase(
      'to_to',
      version: 1,
      onCreate:(database,version)
      {
        print('database created');
         database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, date TEXT, time TEXT, status TEXT)').then((value){
           print('table created');
         }).catchError((error){print('error when create table ${error.toString()}');});
      },
      onOpen: (database){
        print('database Opend');
      }
    );
  }
  void insertToDatabase()
  {
    database!.transaction((txn)
    {
      txn.rawInsert('').then((value){}).catchError((error){});
      return null;
    });
  }


}
