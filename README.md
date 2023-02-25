![Logo](https://ik.imagekit.io/u4sugnhfi/Brand/remove.bg.svg?ik-sdk-version=javascript-1.4.3&updatedAt=1671628487187)

## Usage

Lets take a look at how to use [Remove.bg](https://www.remove.bg/) Flutter Package.

```dart
          Remove().bg(
            file!,
            privateKey: "privateKey", // (Keep Confidential)
            onUploadProgressCallback: (progressValue) {
              if (kDebugMode) {
                print(progressValue);
              }
              setState(() {
                linearProgress = progressValue;
              });
            },
          ).then((Uint8List? data) async {
            if (kDebugMode) {
              print(data);
            }
            bytes = data;
            setState(() {});
          });
```

## Examples

- [Remove.bg ](https://github.com/Deepjyoti120/remove_bg/tree/master/example)
  `Select Image` and Upload on `Remove.bg` then you will received Converted image file from `Remove.bg`

## Maintainers

- [Deepjyoti Baishya](https://www.instagram.com/deepjyoti_sam/)

#### Thank you
