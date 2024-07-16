class SensorUserModel{
  final String? id;
  final String name;
  final String password;
  final String email;
  final String contact;

  const SensorUserModel({
    this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.contact,

  });

  toJson(){
    return{
      "Sensor Household name": name,      
      "Password": password,      
      "Email": email,
      "Contact": contact,
    };
  }
}


