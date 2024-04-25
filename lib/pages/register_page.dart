
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../component/my_button.dart';
import '../component/my_text_field.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {

  //email and password controller

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });

  void register(BuildContext context) {
    //get auth service
    final _auth = AuthService();

    if (_passwordController.text == _confirmPasswordController.text){
      try{
        _auth.signUpWithEmailPassword(
            _emailController.text,
            _passwordController.text);
      }catch(e) {
        showDialog(
          context: context,
          builder: (context)=> AlertDialog(
              title: Text(e.toString()) ,
            ),
        );
      }

    }
    else{
      showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text("Passwords don't match"),
      ) ,
    );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
            Text("Let's create a new account for you",
              style: TextStyle(
                color: Theme.of(context).colorScheme
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
              height: 10,
            ),

            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            //password text field


            const SizedBox(
              height: 25,
            ),


            //login
            MyButton(
              text: "Register",
              onTap:()=> register(context),
            ),
            const SizedBox(
              height: 10,
            ),
            //login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? ",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .primary,
                    )),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now ",
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
