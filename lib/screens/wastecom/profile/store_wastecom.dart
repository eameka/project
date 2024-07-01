import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecowaste/screens/wastecom/profile/wastecom_model.dart";
import "package:get/get.dart";

class WasteRepository extends GetxController{
  static WasteRepository get instance => Get.find();

  final _wdb = FirebaseFirestore.instance;

  createUser(WasteModel wuser) async{
    await _wdb.collection('Waste_Companies').add(wuser.toJson());
  }
}