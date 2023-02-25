![Logo](https://ik.imagekit.io/u4sugnhfi/Brand/remove.bg.svg?ik-sdk-version=javascript-1.4.3&updatedAt=1671628487187)

## Usage

Lets take a look at how to use [Remove.bg](https://www.remove.bg/) Flutter Package.

```dart
  Remove.bg(
    file,
    privateKey: "PrivateKey", // (Keep Confidential)
    onUploadProgress: (progressValue) {
      if (kDebugMode) {
        print(progressValue);
      }
    },
  ).then((String url) {
    // Get your uploaded Image file link from Remove.bg
    //Now you can save it anywhere you want using ImageKit.io to For Example- Firebase, MongoDB etc.
    if (kDebugMode) {
      print(url);
    }
  });
``` 

## Examples
- [Remove.bg ](https://github.com/Deepjyoti120/remove_bg/tree/master/example)
`Select Image` and Upload on `Remove.bg` then you will received Converted image file from `Remove.bg`

## Maintainers
- [Deepjyoti Baishya](https://www.instagram.com/deepjyoti_sam/)
#### Thank you