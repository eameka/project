import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecowaste/screens/sensoruser/sensor_model.dart";
import "package:get/get.dart";

class SensorRepository extends GetxController{
  static SensorRepository get instance => Get.find();

  final _sdb = FirebaseFirestore.instance;

  createUser(SensorUserModel suser) async{
    await _sdb.collection('Sensor_Household').add(suser.toJson());
  }
}