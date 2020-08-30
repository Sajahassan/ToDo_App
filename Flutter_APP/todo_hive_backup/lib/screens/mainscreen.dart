import 'package:flutter/material.dart';
import 'package:todo_hive/screens/complete.dart';
import 'package:todo_hive/screens/homepage.dart';
import 'package:todo_hive/screens/incomplete.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  int myIndex = 0;
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              Homepage(),
              Complete(),
              InComplete(),
            ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: myIndex,
          onTap: (value) {
            myIndex = value;
            _tabController.animateTo(value);
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 35,
                ),
                title: Text(
                  'Homepage',
                  style: TextStyle(color: Colors.black),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_add_check,
                  size: 35,
                ),
                title: Text('Complete', style: TextStyle(color: Colors.black))),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.playlist_play,
                  size: 35,
                ),
                title:
                    Text('InComplete', style: TextStyle(color: Colors.black))),
          ]),
    );
  }
}
