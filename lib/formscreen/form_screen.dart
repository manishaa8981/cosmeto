import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const String routeName='/form_screen';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final TextEditingController fname=TextEditingController();
  final TextEditingController lname=TextEditingController();
  final TextEditingController email=TextEditingController();
  final TextEditingController contact=TextEditingController();
  final TextEditingController address=TextEditingController();

  final database = FirebaseDatabase.instance;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Form(
        key: _key,
        child: Column(
          children: [

            dataretrive garna

            //futurebuilder la tyo update na hune data rakhna

            //stream builder ma xai update hune wala wa update garna milna lai xai rakhna

            StreamBuilder(stream: database.ref('user').onValue, builder: (context,snapshot){
              print(snapshot.data!.snapshot.value);
              return Text("data");
            }),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value == null ){
                  return "Enter fname";
                }
                return null;
              },
              controller: fname,
              decoration: InputDecoration(label: Text("fname")),

            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value == null ){
                  return "Enter Lname";
                }
                return null;
              },
              controller: lname,
              decoration: InputDecoration(label: Text("lname")),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value == null ){
                  return "Enter email";
                }
                return null;
              },
              controller: email,
              decoration: InputDecoration(label: Text("email")),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value == null ){
                  return "Enter contact";
                }
                return null;
              },
              controller: contact,
              decoration: InputDecoration(label: Text("contact")),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value){
                if(value == null ){
                  return "address";
                }
                return null;
              },
              controller: address,
              decoration: InputDecoration(label: Text("address")),
            ),
            ElevatedButton(onPressed: () async {
              if(_key.currentState!.validate()){
                var datas = {
                  "fname":fname.text,
                  "lname":lname.text,
                  "email":email.text,
                  "contact":contact.text,
                  "address":address.text,
                };
                await database.ref().child("users").push().set(datas).then((value){
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Success")));
                }).onError((error, stackTrace) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              }
            },
                child: Text("Submit"))
          ],
        ),
      ) ,
    );
  }
}
