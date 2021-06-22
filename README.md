# draw_on_image_plugin

Flutter plugin for drawing text on images. 

## Getting Started

Just create plugin instance
```dart
DrawOnImagePlugin _plugin = DrawOnImagePlugin();
```
Then create data class with draw parameters like font size, padding, color and so on:
```dart
var writeData = WriteImageData(
  text, 
  imageBytes,
  left: left,
  right: right,
  top: top,
  bottom: bottom,
  color: color.value,
  fontSize: size
)
```
Only two paramaters : text and imageBytes are required the rest are optional.
After that just pass that data to plugin:
```dart
String path = await _plugin.writeTextOnImage(writeData);
```
You will receive a path to new image with your text above it.

More details in [example](https://github.com/Nikolaiko/DrawOnImagePlugin/tree/main/example).
