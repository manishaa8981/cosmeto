import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmeto/model/user_model.dart';
import 'package:cosmeto/providers/user_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:provider/provider.dart';

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
  FirebaseStorage storage = FirebaseStorage.instance;
  ImagePicker picker = ImagePicker();

  File ? image;
  String ? url;

  late UserViewModel userViewModel;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      userViewModel = Provider.of(context, listen: false);
      super.initState();
    });
  }

  void pickImage( ImageSource source) async{
    var selected = await picker.pickImage(source: source , imageQuality:100 );
   if (selected == null){
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No image selected")));
   }
   else{
     setState(() {
       image = File(selected.path);
       saveToStorage();
     });
   }
  }

  void saveToStorage( ) async {
    String name= image!.path.split('/').last;

    final photo = await storage.ref().child('users').child(name).putFile(File(image!.path));
    String tempUrl = await photo.ref.getDownloadURL();
    setState(() {
      url= tempUrl;
    });
  }

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

          image == null ? SizedBox() : Image.file(image!),

          ElevatedButton(onPressed: (){
            showDialog(context: context, builder: (context) =>
            AlertDialog(
              title: Text("Choose image"),
              content: Container(
                height: 200,
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(// presssable banauxa inkwell la
                        onTap:(){
                          pickImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Image.asset("assets/images/cam.png",
                            height: 100,
                            width: 100,),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                      onTap: (){
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      }
                      ,
                        child: Column(
                          children: [
                            Image.asset("assets/images/cam2.png",
                              height: 100,
                              width: 100,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }, child: Text("Browse Image")),
          loading == true ? CircularProgressIndicator() :
          Consumer<UserViewModel>(
            builder: (context, userViewModel , child) {
              return ElevatedButton(
                  onPressed: () async {
                    OverlayLoadingProgress.start();
                    UserModel model= UserModel(email: emailController.text ,firstname: fnameController.text , lastname: lnameController.text);
                    userViewModel.save(model)
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
                  }, child: Text("Submit"));
            }
          )
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
