import 'dart:async';
import 'dart:ffi';
import 'dart:wasm';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

enum ToastPosition { TOP, BOTTOM, CENTER }
///默认在屏幕中间弹出 toast
class UcarFlutterToast {
  static const MethodChannel _channel =
      const MethodChannel('ucar_flutter_toast');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<bool> hideToast() async {
    bool result = await _channel.invokeMethod('hideToast');
    return result;
  }

  static Future<bool> makeToast({
    @required String message,
    ToastPosition position,
    double duration,
    Color backgroundColor,
//    Color titleColor,
    Color messageColor,
//    double titleFont,
    double messageFont,
  }) async {

    String postionStr = "center";
    if (position == ToastPosition.TOP) {
      postionStr = "top";
    } else if (position == ToastPosition.BOTTOM) {
      postionStr = "bottom";
    } else {
      postionStr = "center";
    }

    final Map<String, dynamic> params = <String, dynamic>{
      'message': message,
      'position': postionStr,
      'duration': duration!= null ? duration : null,
      'backgroundColor': backgroundColor!= null ? backgroundColor.value : null,
//      'titleColor': titleColor != null ? titleColor.value : null,
      'messageColor': messageColor != null ? messageColor.value : null,
//      'titleFont': titleFont!= null ? titleFont : null,
      'messageFont':messageFont!= null ? messageFont : null
    };

    bool res = await _channel.invokeMethod('makeToast', params);
    return res;
  }
}
