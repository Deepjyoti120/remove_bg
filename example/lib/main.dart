import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remove_bg/remove_bg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double linearProgress = 0.0;
  File? file;
  String? fileName;
  Future pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null) return;
      // final Uint8List imageTemp = result.files.first.bytes!;
      setState(() {
        fileName = result.files.first.name;
        file = File(result.files.single.path!);
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Uint8List? bytes;

  /// please use File Picker or Image Picker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Remove.bg"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(url2),
                if (bytes != null) Image.memory(bytes!),
                if (file != null)
                  SizedBox(
                    height: 240,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Card(
                                child: Image.file(
                                  file!,
                                  height: 200,
                                  width: double.infinity,
                                ),
                              ),
                              Text("FileName: $fileName"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: linearProgress),
                const SizedBox(height: 10),
                const Text(
                  'Remove.bg Upload Progress',
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: const Text("Select Image"),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
          ).then((data) async {
            /// Get your uploaded Image file link from [ImageKit.io]
            /// then save it anywhere you want. For Example- [Firebase, MongoDB] etc.
            if (kDebugMode) {
              print(data);
            }
            // bytes = await File("filename.png").writeAsString(data);
            // Directory appDocumentsDirectory =
            //     await getApplicationDocumentsDirectory(); // 1
            // String appDocumentsPath = appDocumentsDirectory.path; // 2
            // String filePath = '$appDocumentsPath/demoTextFile.png'; // 3
            // File file = File(filePath); // 1
            // file.writeAsString(data); // 2
            // String fileContent = await file.readAsString(); // 2

            // print('File Content: $fileContent');
            bytes = data;
            setState(() {});
          });
        },
        tooltip: 'Submit',
        child: const Icon(Icons.add),
      ),
    );
  }
}
