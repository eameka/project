// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecowaste/auth_service.dart';
// import 'package:ecowaste/houselogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Educate extends StatefulWidget {
   const Educate({
    super.key,
  });
  @override
   State<Educate> createState() => _EducateState();
}

class _EducateState extends State<Educate> {
//  final _auth = AuthService();
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;

// final _db = FirebaseFirestore.instance;

 //  String _mobileNumber = " ";
//   String _name = " ";
//   String _mail = " ";

  /* @override
  void initState() {
    super.initState();
    _retrieveMobileNumber();
    _retrieveName();
    _retrieveMail();
  }

  @override
  void dispose() {
    super.dispose();
    _retrieveMobileNumber();
    _retrieveMail();
    _retrieveName();
  }


  _retrieveMobileNumber() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mobileNumber = snapshot.get('Contact').toString();
      });
    }
  }

   _retrieveName() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _name = snapshot.get('Household name').toString();
      });
    }
  }

   _retrieveMail() async {
    final DocumentReference ref =  _db.collection("Users").doc('id');
    final DocumentSnapshot snapshot = await ref.get();

    if (snapshot.exists) {
      setState(() {
        _mail = snapshot.get('Email').toString();
      });
    }
  }
*/

   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Educate', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
     
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri('https://en.wikipedia.org/wiki/Waste_management'),
              ),
              onWebViewCreated: (InAppWebViewController controller){
                inAppWebViewController = controller;
              },
              onProgressChanged: (InAppWebViewController controller , int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1 ? Container(
              child: LinearProgressIndicator(
                value: _progress,
              )
            ): const SizedBox(),
          ],
        ),
      ),
    );
  }
}