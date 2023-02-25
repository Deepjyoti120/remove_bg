import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef OnUploadProgressCallback = void Function(double valueProgress);

class Remove {
  final Dio dio = Dio();
  Future<Uint8List?> bg(
    File file, {
    required String privateKey,
    required OnUploadProgressCallback onUploadProgressCallback,
  }) async {
    String apiUrl = "https://api.remove.bg/v1.0/removebg";
    // String username = 'V4jfAbeYFHg58sEBazqAXzCM';
    // String password = '';
    // String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    String fileName = file.path.split('/').last;
    var formData = FormData.fromMap({
      'image_file': await MultipartFile.fromFile(file.path, filename: fileName),
      'size': "auto",
    });
    try {
      Response response = await dio.post(
        apiUrl,
        data: formData,
        options: Options(
          headers: {
            'X-API-Key': privateKey,
            // 'Accept': 'image/png',
          },
          responseType: ResponseType.bytes,
        ),
        onSendProgress: (count, total) {
          double progress = count / total;
          onUploadProgressCallback(progress);
        },
      );
      final getApi = response.data;

      /// Received `Bytes` Response
      return getApi;
    } on DioError catch (e) {
      debugPrint(e.message);
    }
    return null;
  }
}










// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;

// // to received image file Uploading Status during Remove.bg() Function Call.
// typedef OnUploadProgressCallback = void Function(double progressValue);

// /// Add file from File Picker with `Remove.bg` private api key.
// class Remove {
//   static HttpClient getHttpClient() {
//     HttpClient httpClient = HttpClient()
//       ..connectionTimeout = const Duration(seconds: 10)
//       ..badCertificateCallback =
//           ((X509Certificate cert, String host, int port) => true);
//     return httpClient;
//   }

//   /// This will return your uploaded Image/Video single link
//   static Future bg(
//     File? file, {

//     /// Recomended to use `setState(() {})` OR use your Fevrate
//     /// `State Management technique` to Preview Live Uploading status on your app.
//     OnUploadProgressCallback? onUploadProgress,
//     required String privateKey,
//   }) async {
//     assert(file != null);
//     String apiKey = privateKey; // (Keep Confidential)
//     String basicAuth = apiKey;
//     const url = 'https://api.remove.bg/v1.0/removebg';
//     // String fileName = file!.path.split('/').last;
//     final httpClient = getHttpClient();
//     final request = await httpClient.postUrl(Uri.parse(url));
//     request.headers.add('X-API-Key', basicAuth);
//     int byteCount = 0;
//     var requestMultipart = http.MultipartRequest("POST", Uri.parse(url));
//     var multipart = await http.MultipartFile.fromPath("image_file", file!.path);

//     /// Required: this is your `file`
//     requestMultipart.files.add(multipart);

//     /// Required: this is your `size`
//     requestMultipart.fields["size"] = "auto";
//     var msStream = requestMultipart.finalize();
//     var totalByteLength = requestMultipart.contentLength;
//     request.contentLength = totalByteLength;
//     request.headers.set(HttpHeaders.contentTypeHeader,
//         requestMultipart.headers[HttpHeaders.contentTypeHeader]!);
//     Stream<List<int>> streamUpload = msStream.transform(
//       StreamTransformer.fromHandlers(
//         handleData: (data, sink) {
//           sink.add(data);
//           byteCount += data.length;
//           double valueTotal = byteCount / totalByteLength;
//           if (onUploadProgress != null) {
//             /// if `OnUploadProgressCallback` is null you will not received any progress Status.
//             onUploadProgress(valueTotal);
//           }
//         },
//         handleError: (error, stack, sink) {
//           throw error;
//         },
//         handleDone: (sink) {
//           sink.close();
//         },
//       ),
//     );
//     await request.addStream(streamUpload);
//     final httpResponse = await request.close();
//     var statusCode = httpResponse.statusCode;
//     if (statusCode ~/ 100 != 2) {
//       throw Exception(
//           'Error uploading file, Status code: ${httpResponse.statusCode}');
//     } else {
//       var data = await readResponseAsString(httpResponse);
//       var jsons = json.decode(data);
//       var profileImage = Image.memory(data.bodyBytes).image;
//       return profileImage;
//     }
//   }

//   static Future<String> readResponseAsString(HttpClientResponse response) {
//     var completer = Completer<String>();
//     var contents = StringBuffer();
//     response.transform(utf8.decoder).listen((String data) {
//       contents.write(data);
//     }, onDone: () => completer.complete(contents.toString()));
//     return completer.future;
//   }
// }
