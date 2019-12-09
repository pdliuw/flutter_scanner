# flutter_scanner

A new qrCode barcode scanner Flutter plugin.
Note:Embed platform native scanner view in flutter.

## Getting Started

### Usage
```
Container(
                  color: Colors.black26,
                  width: cameraWidth,
                  height: cameraHeight,
                  child: PlatformScannerWidget(
                    platformScannerController: _scannerController,
                  ),
                ),
```