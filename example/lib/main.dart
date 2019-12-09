import 'package:flutter/material.dart';
import 'package:flutter_route/flutter_route.dart';
import 'package:flutter_scanner_example/task_next_page.dart';
import 'package:flutter_scanner_example/task_scanner_page.dart';

void main() => runApp(
      MaterialApp(
        home: Scaffold(
          body: App(),
        ),
        //routes
        routes: RouteManager.initializeRoutes(
          routes: <String, WidgetBuilder>{
            "/TaskScannerPage": (BuildContext context) => TaskScannerPage(),
            "/TaskNextPage": (BuildContext context) => TaskNextPage(),
          },
        ),
        navigatorObservers: [
          RouteManager.getInstance(),
        ],
      ),
    );

///
/// App
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

///
/// _AppState
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("条码扫描"),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            /*
              跳转页面
               */
            RouteManager.getInstance().pushNamed("/TaskScannerPage");
          },
          textColor: Colors.white,
          color: Colors.blue,
          child: Text("启动相机"),
        ),
      ),
    );
  }
}
