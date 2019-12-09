import 'package:flutter/material.dart';
import 'package:flutter_scanner/flutter_scanner.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _qrCode = 'Unknown';
  bool _grant = false;

  ScannerController _platformScannerController;

  @override
  void initState() {
    super.initState();

    _platformScannerController = ScannerController(
      scannerResult: (String result) {
        setState(() {
          _qrCode = result;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _platformScannerController = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scanner Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Text('Result on: $_qrCode\n'),
            Text('Grant on: $_grant\n'),
            Container(
              color: Colors.blue,
              width: 200,
              height: 200,
              child: PlatformScannerWidget(
                platformScannerController: _platformScannerController,
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: Text("申请权限"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _platformScannerController.startCamera();
              },
              child: Text("打开相机"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _platformScannerController.stopCamera();
              },
              child: Text("关闭相机"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _platformScannerController.startCameraPreview();
              },
              child: Text("打开预览(只有打开预览后，才会识别)"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _platformScannerController.stopCameraPreview();
              },
              child: Text("关闭预览"),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                _platformScannerController.toggleFlash();
              },
              child: Text("切换手电筒"),
            ),
          ],
        )),
      ),
    );
  }
}
