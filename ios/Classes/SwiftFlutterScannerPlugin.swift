import Flutter
import UIKit

public class SwiftFlutterScannerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_scanner", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterScannerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    /*
     Register scanner
     */
    registrar.register(IosScannerViewFactory(flutterBinaryMessenger: registrar.messenger()), withId: "view_type_id_scanner_view");
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS事实上 " + UIDevice.current.systemVersion)
    
  }
}
