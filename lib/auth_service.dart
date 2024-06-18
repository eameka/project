import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final _auth = FirebaseAuth.instance;
 // final GoogleSignIn _googleSignIn = GoogleSignIn();




  Future<User?> createUserWithEmailAndPassword(
    String email, String password) async {
      try{
        final cred = await  _auth.createUserWithEmailAndPassword(email: email, password: password);    
    return cred.user;
      }catch(e){
        ('Something went wrong');
      }
    return null;
    }

    Future<User?> loginUserWithEmailAndPassword(
    String email, String password) async {
      try{
        final cred = await  _auth.signInWithEmailAndPassword(email: email, password: password);    
    return cred.user;
      }catch(e){
        ('Incorrect e-mail or password');
      }
    return null;
    }

    Future<void> signout() async{
      try {
        await _auth.signOut();
      }catch(e){
         ('Something went wrong');
      }
    }

    Future<void> sendPasswordResetLink(String email) async{
      try {
        await _auth.sendPasswordResetEmail(email: email);
      }catch(e){
         ('Something went wrong');
      }
    }

    
}