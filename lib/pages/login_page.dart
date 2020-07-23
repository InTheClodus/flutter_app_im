import 'package:dim/dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_im/pages/chat.dart';

import 'chatList.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userName = TextEditingController(); //用户名
  final _userPwd = TextEditingController(); //密码

  GlobalKey _globalKey = new GlobalKey<FormState>(); //用于检查输入框是否为空
  Dim _dim = new Dim();

  String _result = "";

  Future<void> login()async {
    try{
      var result=await _dim.imLogin(_userName.text, _userPwd.text);
      print(result);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatList()));
      setState(() {
        this._result = result;
      });
    }on PlatformException{
      print('登录失败');
    }
  }

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Center(
        child: Form(
          key: _globalKey,
          autovalidate: true, //自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _userName,
                decoration: InputDecoration(
                    labelText: "账号",
                    hintText: "输入你的账号",
                    icon: Icon(Icons.person)),
                validator: (v) {
                  return v.trim().length > 0 ? null : "用户名不能为空";
                },
              ),
              TextFormField(
                controller: _userPwd,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "输入你的密码",
                  icon: Icon(Icons.lock),
                ),
                validator: (v) {
                  return v.trim().length > 5 ? null : "密码不低于6位";
                },
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              SizedBox(
                width: 120.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: () {
                    login();
                  },
                  child: Text(
                    "登录",
                    style: TextStyle(color: Colors.white), //字体白色
                  ),
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
