
import 'dart:convert';

import 'package:dim/dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_im/pages/chat.dart';
import 'package:flutter_app_im/pages/user_frind_entity.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Dim _dim=new Dim();
  List<dynamic> list=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listFird();
  }

  Future<void>listFird()async{
    try{
      var result=await _dim.listFriends("user1");
      var map=json.decode(result.toString());
      setState(() {
        list=map.map((f)=>f).toList();
        list.map((f)=>print(f)).toList();
      });
    }on PlatformException{

    }
  }

  Future<void>getConversations()async{
    try{
      var result=await _dim.getConversations();
      print(result);
    }on PlatformException{

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: Text('消息'),actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: ()async{
            var res=await _dim.addFriend('user2');
            if(res=="addFriend success"){
              await listFird();
            }
            print(res);
          },
        )
      ],),
      body: ListView.builder(itemCount:list.length,itemBuilder: (context,index){
        return Container(height: 35,child: InkWell(
          child: Row(
            children: <Widget>[
              Text(list[index]['identifier'])
            ],
          ),
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage(user: list[index]['identifier'],))),
        ),);
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>getConversations(),
      ),
    );
  }
}
