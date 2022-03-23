import 'package:flutter/material.dart';
import 'package:sqflite/modules/new_tasks/new_tasks_screen.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('TODO'),
      ),
      body: NewTasksScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child:const Icon(Icons.add),
      ),
      bottomNavigationBar:BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index)
        {
         setState(() {
           currentIndex = index;
         });
        },
        items:const
        [
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.menu,
              ),
            label: 'Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.check_circle_outline,
              ),
            label: 'Done'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  Icons.archive_outlined,
              ),
            label: 'Archived'
          ),
        ],
      ),
    );
  }
}
