import 'package:dalu_robot/redux/actions/session_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../main_state.dart';
import '../../services/session_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../index.dart';
import '../../widgets/common_text_field.dart';
import '../../widgets/common_button_with_icon.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState ()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Map loginInfo = {"username": "", "password": ""};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(26, 77, 26, 30),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                  child: LoginPageTitle(
                    text: "WELCOME",
                    fontSize: 32,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: LoginPageTitle(
                    text: "username",
                  ),
                ),
                MyTextField(
                  hintText: "username",
                  onChanged: (value){
                    setState(() {
                      this.loginInfo["username"] = value;
                    });
                  },
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                  width: double.maxFinite,
                  child: LoginPageTitle(
                    text: "password",
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: MyTextField(
                    hintText: "password",
                    onChanged: (value){
                      setState(() {
                        this.loginInfo["password"] = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                StoreConnector<MainState, _viewModel>(
                  converter: (store) => _viewModel.create(store),
                  builder: (context, viewModel){
                    return MyButtonWithIcon(
                      text: "登录",
                      onPressed: (){
                        if(loginInfo["username"] == "" || loginInfo["password"] == ""){
                          Fluttertoast.showToast(msg: "请出入用户名或密码", textColor: Colors.white, backgroundColor: Colors.black);
                          return null;
                        }

                        handleLogin(loginInfo).then((value){
                          var response = json.decode(value.data);
                          print(response["Username"]);
                          viewModel.onsetUsername(response["Username"]);
                          viewModel.onsetLoginState(true);
                          Fluttertoast.showToast(msg: "登录成功", textColor: Colors.white, backgroundColor: Colors.black);
                          Navigator.of(context).pushAndRemoveUntil(
                              new MaterialPageRoute(builder: (context) => IndexPage()),
                                  (route) => route == null
                          );
                        }).catchError((err){
                          Fluttertoast.showToast(msg: "error: $err", textColor: Colors.white, backgroundColor: Colors.black);
                        });

                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _viewModel {
  Function(bool) onsetLoginState;
  Function(String) onsetUsername;

  _viewModel({this.onsetLoginState, this.onsetUsername});

  factory _viewModel.create(Store<MainState> store){
    _onSetLoginState(bool isLogin){
      store.dispatch(setLoginStateAction(isLogin: isLogin));
    }

    _onsetUsernameState(String username){
      store.dispatch(setUsernameAction(username: username));
    }

    return _viewModel(
      onsetLoginState: _onSetLoginState,
      onsetUsername: _onsetUsernameState,
    );
  }
}

class LoginPageTitle extends StatefulWidget {

  final String text;
  final double fontSize;

  LoginPageTitle({Key key, @required this.text, this.fontSize}) : super(key: key);
  _LoginPageTitleState createState ()=> _LoginPageTitleState();
}

class _LoginPageTitleState extends State<LoginPageTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: widget.fontSize ?? 16,
          fontWeight: FontWeight.bold),
    );
  }

}