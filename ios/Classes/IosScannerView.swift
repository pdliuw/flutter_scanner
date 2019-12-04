//
//  IOSScannerView.swift
//  flutter_scanner
//
//  Created by JamesAir on 2019/12/3.
//

import Foundation
import Flutter
import MTBBarcodeScanner

class IosScannerView:NSObject,FlutterPlatformView{
    
    @IBOutlet var scannerView: UIView!
    var scanner:MTBBarcodeScanner!
    var methodChannel:FlutterMethodChannel?;
    var flutterResult:FlutterResult?;
    var binaryMessenger:FlutterBinaryMessenger!;
    /*
     Constructor.
     */
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.binaryMessenger = binaryMessenger;
        
        /*
         Scanner
         */
        scanner = MTBBarcodeScanner(previewView: scannerView);
        //Call parent init constructor.
        super.init();
    }
    
    
    
    func view() -> UIView {
        
        initMethodChannel();
        
        let label = UILabel()
        label.text="Ios UILabel++"
        label.textColor = UIColor.green
        
//        let button = UIButton();
//        button.setTitle("title", for: UIControl.State.focused)
//        let uiView = UIView();
//        uiView.addSubview(label)
//        uiView.addSubview(button)
        
        return label;
    }
    
    func initMethodChannel(){
        /*
         MethodChannel.
         */
        methodChannel = FlutterMethodChannel.init(name: "view_type_id_scanner_view_method_channel", binaryMessenger: binaryMessenger)
        methodChannel?.setMethodCallHandler { (call :FlutterMethodCall, result:@escaping FlutterResult)  in
            /*
             Save flutter result.
             */
            self.flutterResult = result;
            
            switch(call.method){
            case "startCamera":
                /*
                 打开相机
                 */
                self.startCamera();
                break;
            case "stopCamera":
                /*
                 关闭相机
                 */
                self.stopCamera();
                break;
                /*
                 预览相机
                 */
                case "resumeCameraPreview":
                    self.resumeCameraPreview();
                break;
                /*
                 停止预览
                 */
                case "stopCameraPreview":
                    self.stopCameraPreview();
                break;
                /*
                 打开手电筒
                 */
                case "openFlash":
                    self.openFlash();
                break;
                /*
                 关闭手电筒
                 */
                case "closeFlash":
                    self.closeFlash();
                break;
                /*
                 切换手电筒
                 */
                case "toggleFlash":
                    self.toggleFlash();
                break;
            default:
                /*
                 默认启动相机
                 */
                self.startCamera();
            }
        }
    }
    
    
    
    func startCamera(){
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                self.flutterResult?(stringValue);
                                print("Found code: \(stringValue)")
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
    }
    func stopCamera(){
        self.scanner?.stopScanning()
    }
    func resumeCameraPreview(){
        
    }
    
    func stopCameraPreview(){
        
    }
    func openFlash(){
//        scannerView?.setTorchMode(MTBTorchMode.on, error: NSNull)
    }
    func closeFlash(){
//        scannerView?.setTorchMode(MTBTorchMode.off, error: NSNull)
    }
    func toggleFlash(){
        scanner?.toggleTorch();
    }
}
