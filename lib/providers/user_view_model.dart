import 'package:cosmeto/model/user_model.dart';
import 'package:cosmeto/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier{
  Future<void> save(UserModel data) async{
    try {
      var a = await UserRepository().saveUsers(data);
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }

  }
}