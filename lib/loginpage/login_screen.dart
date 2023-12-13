import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../common_widgets/common_text_field.dart';
import '../registration/registration_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName='/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool visibility=true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,

      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Email",
                style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, fontFamily: 'Bebas Neue Regular')),
            Padding
              (
              padding: const EdgeInsets.only(top: 10),
              child: CommonTextField(
                obscureText: false,
                hintText: "Enter Email",
                controller: emailController,
                prefixIcon:const Icon(Icons.mail),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Password",
                      style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18, fontFamily: 'Bebas Neue Regular')),
                ],
              ),
            ),

            Padding
              (
              padding: const EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: passwordController,
                obscureText: visibility,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.key),
                  suffixIcon: InkWell(
                      onTap: (){
                        visibility=!visibility;
                      },
                      child: visibility==true? Icon(Icons.visibility_off):Icon(Icons.visibility)),
                  hintText: "Enter password",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.grey,width: 2
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                          color: Colors.green,width: 2
                      )
                  ),




                ),

              ),
            ),
            TextFormField(
              controller: TextEditingController(),
            ),
            Container(
              width: 500,
              child: ElevatedButton(
                  onPressed: () {}, child: Text("Login")),
            ),
            Align(
                alignment: Alignment.centerRight,
                child:
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                  child: const Text("Register now"),
                )

            ),

          ],
        ),
      ),
    );
  }
}