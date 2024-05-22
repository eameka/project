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
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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