import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cosmeto/model/user_model.dart';

class UserRepository{
  final instance= FirebaseFirestore.instance.collection('users').withConverter(fromFirestore: (snapshot , options) => UserModel.fromJson(snapshot.data() as Map<String , dynamic>), toFirestore: (UserModel value , options) => value.toJson());

  Future<dynamic> saveUsers(UserModel data) async{
    try {
      final result  = await instance.add(data);
      return result;
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    return null;
  }

}