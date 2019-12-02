import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformScannerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PlatformScannerWidgetState();
  }
}

class _PlatformScannerWidgetState extends State<PlatformScannerWidget> {
  ///
  /// id
  String viewId = "view_type_id_scanner_view";

  MethodChannel _methodChannel =
      MethodChannel("view_type_id_scanner_view_method_channel");
  EventChannel _eventChannel =
      EventChannel("view_type_id_scanner_view_event_channel");

  StreamSubscription _streamSubscription;

  String _qrCode = "Unknown";

  @override
  void initState() {
    super.initState();
    /*
    Create
     */
  }

  @override
  void dispose() {
    /*
    Release.
     */
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("识别结果：$_qrCode"),
        Container(
          width: 200,
          height: 200,
          child: cameraView(),
        ),
        MaterialButton(
          onPressed: () {
            _startCamera();
          },
          child: Text("打开相机"),
        ),
        MaterialButton(
          onPressed: () {
            _stopCamera();
          },
          child: Text("关闭相机"),
        ),
        MaterialButton(
          onPressed: () {
            _startCameraPreview();
          },
          child: Text("打开预览(只有打开预览后，才会识别)"),
        ),
        MaterialButton(
          onPressed: () {
            _stopCameraPreview();
          },
          child: Text("关闭预览"),
        ),
      ],
    );
  }

  Widget cameraView() {
    TargetPlatform targetPlatform = Theme.of(context).platform;

    if (targetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: "view_type_id_scanner_view",
        onPlatformViewCreated: (int id) {
          print("onPlatformViewCreated");
        },
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (targetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: "view_type_id_scanner_view",
        onPlatformViewCreated: (int id) {},
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else {
      return Text("不支持的平台");
    }
  }

  _startCamera() async {
    String code = await _methodChannel.invokeMethod("startCamera");
    setState(() {
      _qrCode = code;
    });
  }

  _stopCamera() {
    _methodChannel.invokeMethod("stopCamera");
  }

  _startCameraPreview() async {
    String code = await _methodChannel.invokeMethod("resumeCameraPreview");
    setState(() {
      _qrCode = code;
    });
  }

  _stopCameraPreview() {
    _methodChannel.invokeMethod("stopCameraPreview");
  }
}
