import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_signature_view/flutter_signature_view.dart';

void main() => runApp(InitialApp());

class InitialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List _resultExportSignature;

  SignatureView _signatureView = SignatureView();

  void _resetSignature() {
    _signatureView.clear();
  }

  void _confirmSignature() async {
    if (_signatureView.isEmpty) {
      print('Provided Signature ');
      return null;
    }
    final result = await _signatureView.exportBytes();
    setState(() {
      _resultExportSignature = result;
    });
    print(_resultExportSignature);
  }

  @override
  Widget build(BuildContext context) {
    _signatureView = SignatureView(
      backgroundColor: Theme.of(context).primaryColor,
      penStyle: Paint()
        ..color = Colors.white
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Signature Example'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              child: _resultExportSignature == null
                  ? SizedBox()
                  : Image.memory(
                      _resultExportSignature,
                      color: Theme.of(context).primaryColor,
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: _resetSignature,
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _confirmSignature,
                ),
              ],
            ),
            Container(
              constraints: BoxConstraints.expand(height: 200),
              child: _signatureView,
            )
          ],
        ),
      ),
    );
  }
}
