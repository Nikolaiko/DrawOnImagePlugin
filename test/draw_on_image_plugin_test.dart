import 'package:draw_on_image_plugin/consts/name_constst.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:draw_on_image_plugin/draw_on_image_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel(channelName);

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch(methodCall.method) {
        case drawMethodName: {
          return "image001.png";          
        }
        default: {
          return MissingPluginException("Missing implementation for ${methodCall.method}");
        }
      }
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('wrong method name test', () async {
    expect(channel.invokeMethod("some_dummy_method"), throwsA(MissingPluginException));
  });
}
