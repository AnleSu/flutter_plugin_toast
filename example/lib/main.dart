import 'package:flutter/material.dart';
import 'package:ucar_flutter_toast/ucar_flutter_toast.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
  }

  void showLongToast() {
    UcarFlutterToast.makeToast(
      message: "This is Long Toast",
    );
  }

  void showColoredToast() {
    UcarFlutterToast.makeToast(
      message: "This is Colored Toast with android duration of 5 Sec",
        backgroundColor: Colors.red,
        );
  }

  void showShortToast() {
    UcarFlutterToast.makeToast(
        message: "This is Short Toast",
        messageColor: Colors.red);
  }

  void showTopShortToast() {
    UcarFlutterToast.makeToast(
      message: "This is Top Short Toast",
        position: ToastPosition.TOP,
        );
  }

  void showCenterShortToast() {
    UcarFlutterToast.makeToast(
        message: "This is Center Short Toast",
        position: ToastPosition.CENTER,
        messageFont: 20);
  }

  void cancelToast() {
    UcarFlutterToast.hideToast();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Toast'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Show Long Toast'),
                    onPressed: showLongToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Show Short Toast'),
                    onPressed: showShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Show Center Short Toast'),
                    onPressed: showCenterShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Show Top Short Toast'),
                    onPressed: showTopShortToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                    child: new Text('Show Colored Toast'),
                    onPressed: showColoredToast),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new RaisedButton(
                  child: new Text('Cancel Toasts'),
                  onPressed: cancelToast,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
