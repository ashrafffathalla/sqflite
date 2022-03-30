import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_to/shared/components/components.dart';

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

  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheetShow = false;
  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
        ),
      ),
      body: screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //insertToDatabase();
          if(isBottomSheetShow)
          {
            Navigator.pop(context);
            isBottomSheetShow = false;
            setState(() {
              fabIcon = Icons.edit;
            });
          }else{
            scaffoldKey.currentState!.showBottomSheet(
                  (context) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultFormField(
                            controller: titleController,
                            type: TextInputType.text,
                            validate: (value){
                              if(value!.isNotEmpty)
                                {
                                  return 'title must not be empty';
                                }
                              return null;
                            },
                            label: 'Task Title',
                            prefix: Icons.title,
                        )
                      ],
                    ),
                  )
            );
            isBottomSheetShow = true;
            setState(() {
              fabIcon = Icons.add;
            });
          }

        },
        child: Icon(fabIcon),
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

  void createDatabase() async {
    database =
        await openDatabase('do_do', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when create table ${error.toString()}');
      });
    }, onOpen: (database) {
      print('database Opend');
    });
  }

  void insertToDatabase() {
    database.transaction((txn) {
      var ris = txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("first task","0222","10","new")')
          .then((value) {
        print("$value insert successfully");
      }).catchError((error) {
        print('Error when insert ${error.toString()}');
      });
      return ris;
    });
  }
}
