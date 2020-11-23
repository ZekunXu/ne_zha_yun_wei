import 'package:dalu_robot/pages/session/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './home/home.dart';
import '../main_state.dart';
import './me/me.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavigationBarItemList = [
    BottomNavigationBarItem(icon: Icon(Icons.android), title: Text("首页")),
    BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    MePage(),
  ];

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<MainState>(
      builder: (context, store) {
        return store.state.sessionState.isLogin
            ? Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedIconTheme: IconThemeData(
              color: Color.fromARGB(117, 117, 117, 1)
            ),
            selectedIconTheme: IconThemeData(
              color: Color.fromARGB(63, 81, 181, 1)
            ),
            items: this.bottomNavigationBarItemList,
            currentIndex: this.currentPageIndex,
            onTap: (int index){
              setState(() {
                this.currentPageIndex = index;
              });
            },
          ),
          body: IndexedStack(
            index: this.currentPageIndex,
            children: this.tabBodies,
          ),
        )
            : LoginPage();
      },
    );
  }
}
