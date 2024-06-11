import 'package:ecowaste/auth_service.dart';
import 'package:ecowaste/houselogin.dart';
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
  final _auth = AuthService();
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Educate', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 202, 255, 204),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Dojo',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Mobile Number'),
              subtitle: const Text('0507971715'),
              leading: const Icon(Icons.phone),
              onTap: () {
                // Call API or perform action here
              },
            ),
           
            ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                // Call API or perform action here
                await _auth.signout();
                 Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHouseLogin(),
          ));
              },
            ),
          ],
        ),
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