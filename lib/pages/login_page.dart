
import 'package:banter_box/component/my_button.dart';
import 'package:banter_box/component/my_text_field.dart';
import 'package:flutter/material.dart';

import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {

  //email and password controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //tap to go to register pafe
  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap});

  void login(BuildContext context) async {
    //auth service
    final authService = AuthService();

    //try login
    try {
      await authService.signInWithEmailPassword(
          _emailController.text, _passwordController.text);
    }
    //catch error
    catch(e){
      showDialog(context: context, builder: (context)=>
      AlertDialog(
        title: Text(e.toString()) ,
      ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(Icons.message,
              size: 70,
              color: Theme
                  .of(context)
                  .colorScheme
                  .primary,
            ),

            const SizedBox(
              height: 50,
            ),
            //welcomeback message
            Text("Welcome back, you've been missed!!",
              style: TextStyle(
                color: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
              ),
            ),

            const SizedBox(
              height: 30,
            ),


            // email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),
            //password text field

            const SizedBox(
              height: 10,
            ),

            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(
              height: 25,
            ),


            //login
            MyButton(
              text: "Login",
              onTap: () => login(context),
            ),
            const SizedBox(
              height: 10,
            ),
            //register
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member? ",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    )),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    ),),
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }
}
