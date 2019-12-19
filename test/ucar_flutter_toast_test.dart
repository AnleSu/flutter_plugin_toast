import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ucar_flutter_toast/ucar_flutter_toast.dart';

void main() {
  const MethodChannel channel = MethodChannel('ucar_flutter_toast');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await UcarFlutterToast.platformVersion, '42');
  });
}
