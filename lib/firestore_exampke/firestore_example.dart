import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmeto/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_kit/overlay_kit.dart';

class FireStoreExample extends StatefulWidget {
  const FireStoreExample({super.key});
  static const String routeName = '/firestoreexample';

  @override
  State<FireStoreExample> createState() => _FireStoreExampleState();
}

class _FireStoreExampleState extends State<FireStoreExample> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool loading = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text("Email"),
          TextFormField(controller: emailController),
          Text("Fname"),
          TextFormField(controller: fnameController),
          Text("Lname"),
          TextFormField(controller: lnameController),
          loading == true ? CircularProgressIndicator() :
          ElevatedButton(
              onPressed: () async {
                OverlayLoadingProgress.start();
                UserModel model= UserModel(email: emailController.text ,firstname: fnameController.text , lastname: lnameController.text);
                await firestore
                    .collection('users')
                    .doc()
                    .set(model.toJson())
                    .then((value) {
                  clearData();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Data Submitted")));
                  setState(() {
                    OverlayLoadingProgress.stop();
                  });
                }).onError((error, stackTrace) {
                  setState(() {
                    OverlayLoadingProgress.stop();
                  });
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.toString())));
                });
              }, child: Text("Submit"))
        ],
      ),
    );
  }
  void clearData() {
    emailController.clear();
    fnameController.clear();
    lnameController.clear();
  }
}
