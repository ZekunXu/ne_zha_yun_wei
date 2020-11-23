import 'package:dalu_robot/redux/actions/session_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../main_state.dart';
import '../../services/session_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import '../index.dart';


class LoginPage extends StatefulWidget {
  _LoginPageState createState ()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  Map loginInfo = {"username": "", "password": ""};

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(18),
          child: Column(
            children: [
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: "username",
                  enabledBorder: InputBorder.none,
                ),
                onChanged: (e){
                  this.setState(() {
                    loginInfo["username"] = e;
                  });
                },
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  icon: Icon(Icons.cloud_circle),
                  labelText: "password",
                  enabledBorder: InputBorder.none,
                ),
                onChanged: (e){
                  this.loginInfo["password"] = e;
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StoreConnector<MainState, _viewModel>(
                  converter: (store) => _viewModel.create(store),
                  builder: (context, viewModel){
                    return RaisedButton(
                      child: Text("登录"),
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
              )
            ],
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