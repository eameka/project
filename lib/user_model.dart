class UserModel{
  final String? id;
  final String name;
  final String password;
  final String email;
  final String contact;

  const UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.contact,

  });

  toJson(){
    return{
      "Household name": name,      
      "Password": password,      
      "Email": email,
      "Contact": contact,
    };
  }
}

class WasteModel{
  final String? id;
  final String name;
  final String password;
  final String email;
  final String contact;

  const WasteModel({
    this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.contact,

  });

  toJson(){
    return{
      "Household name": name,      
      "Password": password,      
      "Email": email,
      "Contact": contact,
    };
  }
}