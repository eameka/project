import "package:cloud_firestore/cloud_firestore.dart";
import "package:get/get.dart";
import "user_model.dart";

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async{
   await _db.collection("Users").add(user.toJson());
  }
}

