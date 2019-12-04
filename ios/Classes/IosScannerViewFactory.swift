//
//  IosScannerViewFactory.swift
//  flutter_scanner
//
//  Created by JamesAir on 2019/12/3.
//

import Foundation

class IosScannerViewFactory:NSObject,FlutterPlatformViewFactory{
    
    var binaryMessenger:FlutterBinaryMessenger;
    
    init(flutterBinaryMessenger : FlutterBinaryMessenger) {
    
        binaryMessenger = flutterBinaryMessenger;
    
    }
    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return IosScannerView(binaryMessenger:binaryMessenger);
    }
}
