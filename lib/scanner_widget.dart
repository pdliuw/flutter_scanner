import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///
/// PlatformScannerWidget
class PlatformScannerWidget extends StatefulWidget {
  ///
  ///Controller.
  ScannerController _platformScannerController;

  ///
  /// Constructor.
  PlatformScannerWidget(
      {@required ScannerController platformScannerController}) {
    this._platformScannerController = platformScannerController;
  }

  @override
  State<StatefulWidget> createState() {
    return _PlatformScannerWidgetState();
  }
}

///
/// _PlatformScannerWidgetState
class _PlatformScannerWidgetState extends State<PlatformScannerWidget> {
  ///
  /// id
  String _viewId = "view_type_id_scanner_view";

  StreamSubscription _streamSubscription;

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
    return _cameraView();
  }

  Widget _cameraView() {
    TargetPlatform targetPlatform = Theme.of(context).platform;

    if (targetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: _viewId,
        onPlatformViewCreated: (int id) {
          print("onPlatformViewCreated");
        },
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (targetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: _viewId,
        onPlatformViewCreated: (int id) {},
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else {
      return Text("不支持的平台");
    }
  }
}

///
/// PlatformScannerController
class ScannerController {
  ///
  /// Channel
  MethodChannel _methodChannel =
      MethodChannel("view_type_id_scanner_view_method_channel");
  EventChannel _eventChannel =
      EventChannel("view_type_id_scanner_view_event_channel");

  ///
  /// Result
  Function _scannerResult;

  ///
  /// Constructor.
  ScannerController({
    @required scannerResult(String result),
  }) {
    this._scannerResult = scannerResult;
  }

  ///
  /// Start camera without open QRCode、BarCode scanner,this is just open camera.
  startCamera() async {
    _methodChannel.invokeMethod("startCamera");
  }

  ///
  /// Stop camera.
  stopCamera() async {
    _methodChannel.invokeMethod("stopCamera");
  }

  ///
  /// Start camera preview with open QRCode、BarCode scanner,this is open code scanner.
  startCameraPreview() async {
    String code = await _methodChannel.invokeMethod("resumeCameraPreview");
    _scannerResult(code);
  }

  ///
  /// Stop camera preview.
  stopCameraPreview() async {
    _methodChannel.invokeMethod("stopCameraPreview");
  }

  ///
  /// Open camera flash.
  openFlash() async {
    _methodChannel.invokeMethod("openFlash");
  }

  ///
  /// Close camera flash.
  closeFlash() async {
    _methodChannel.invokeMethod("closeFlash");
  }

  ///
  /// Toggle camera flash.
  toggleFlash() async {
    _methodChannel.invokeMethod("toggleFlash");
  }
}
