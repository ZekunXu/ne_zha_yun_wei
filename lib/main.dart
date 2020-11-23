import 'package:dalu_robot/configs/configure_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import './pages/index.dart';
import 'main_state.dart';
import 'package:redux/redux.dart';
import 'package:fluro/fluro.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './services/session_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  _load() async {
    getSessionCookie().then((value) {
      if (value.length > 0) {
        this.setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*
  设置redux里面，store的初始值
   */
    final store = Store<MainState>(mainReducer,
        initialState: MainState.initialState(this.isLogin));

    /*
  初始化路由配置
   */
    final router = FluroRouter();
    MyRoutes.configureRoutes(router);
    Application.router = router;

    return StoreProvider(
      store: store,
      child: StoreBuilder<MainState>(
        builder: (context, store) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: store.state.themeState.themeData,
            home: IndexPage(),
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );
  }
}
