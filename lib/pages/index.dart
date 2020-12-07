import 'package:dalu_robot/pages/session/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './home/home.dart';
import '../main_state.dart';
import './me/me.dart';
import './messages/message.dart';

class IndexPage extends StatefulWidget {
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavigationBarItemList = [
    BottomNavigationBarItem(icon: Icon(Icons.android), label: "首页"),
    BottomNavigationBarItem(icon: Icon(Icons.message), label: "消息"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    MessagePage(),
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
