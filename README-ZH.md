# flutter_scanner

一个用于扫描 '一维条码'和'二维条码'的条码支持Android、IOS移动端使用扫描插件
注意:本插件用于在flutter中以widget的形式嵌入使用！

## 开始

## 用法
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