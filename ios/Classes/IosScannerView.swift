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
    
    var scannerView: UIView!
    var scanner:MTBBarcodeScanner!
    var methodChannel:FlutterMethodChannel?;
    var flutterResult:FlutterResult?;
    var binaryMessenger:FlutterBinaryMessenger!;
    /*
     Constructor.
     */
    init(binaryMessenger: FlutterBinaryMessenger) {
        //Call parent init constructor.
        super.init();
        self.binaryMessenger = binaryMessenger;
        /*
         Method Channel
         */
        initMethodChannel();
        /*
         Scanner
         */
        scannerView = UIView();
        //        scannerView.frame(forAlignmentRect: CGRect.init(x: 0, y: 0, width: 100, height: 150))
        scanner = MTBBarcodeScanner(previewView: scannerView);
    }
    
    
    
    func view() -> UIView {
        
        let label = UILabel()
        label.text="Ios UILabel++"
        label.textColor = UIColor.green
        
        let button = UIButton();
        button.setTitle("title", for: UIControl.State.normal)
        
        scannerView.addSubview(button);
        scannerView.addSubview(label);
        return scannerView;
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
                self.flutterResult?("method:\(call.method) not implement");
            }
        }
    }
    
    
    
    func startCamera(){
        
    }
    func stopCamera(){
        //        self.scanner?.stopScanning()
    }
    func resumeCameraPreview(){
        if(self.scanner.isScanning()){
            return;
        }
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                if(self.flutterResult != nil){
                                    self.flutterResult?("\(stringValue)");
                                }
                                
                                print("Found code: \(stringValue)")
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning error:\(error)")
                    self.flutterResult?("Unable to start scanning error:\(error)");
                }
            } else {
                self.flutterResult?("Unable to start scanning This app does not have permission to access the camera");
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
    }
    
    func stopCameraPreview(){
        if(self.scanner.isScanning()){
            self.scanner.stopScanning()
            
        }
        
    }
    func openFlash(){
        //        scanner?.setTorchMode(MTBTorchMode.on)
    }
    func closeFlash(){
        //        scanner?.setTorchMode(MTBTorchMode.off)
    }
    func toggleFlash(){
        scanner?.toggleTorch();
    }
}
