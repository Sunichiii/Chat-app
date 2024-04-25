
import 'package:banter_box/chat/chat_service.dart';
import 'package:banter_box/component/user_tile.dart';
import 'package:flutter/material.dart';

import '../component/my_drawer.dart';
import '../services/auth/auth_service.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  //chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() {
    //get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(child:  Text("Home",)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  //buld a list of user except for current logged in user

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        //return list view
        return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList());
      },
    );
  }

  //building individual list tile
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"]!= _authService.getCurrentuser()!.email){
      return UserTile(
          text: userData["email"],
          onTap: () {
            //goes to the chat page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receiverEmail: userData["email"],
                      receiverID: userData["uid"],
                    ),
                ),
            );
          },
      );
    }else{
      return Container();
    }

  }
}
