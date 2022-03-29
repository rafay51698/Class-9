import 'dart:io';
import 'package:path/path.dart' as paths;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageStorage extends StatefulWidget {
  const ImageStorage({Key? key}) : super(key: key);

  @override
  State<ImageStorage> createState() => _ImageStorageState();
}

class _ImageStorageState extends State<ImageStorage> {
  var imagePath;

  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);

    // imagePath = image!.path;
    setState(() {
      imagePath = image?.path;
      print('imagepath $imagePath');
    });
  }

  // String? myurl;

  submit() async {
    FirebaseStorage storage = FirebaseStorage.instance;

    String imageName = paths.basename(imagePath);

    Reference ref = FirebaseStorage.instance.ref('Users/$imageName');

    File file = File(imagePath);
    await ref.putFile(file);
    String downloadURL = await ref.getDownloadURL();
    // setState(() {
    //   // myurl = downloadURL;
    //   // print(myurl);
    // });

    print(downloadURL);
    print("file is uploaded successfully");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              selectImage();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_a_photo,
                  color: Colors.orange,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  " Select Your Profile Picture",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
                ElevatedButton(
                    onPressed: () {
                      submit();
                    },
                    child: const Text("Submit")),
            //     if (imagePath != null)
            // Container(
            //   child: Image.file(
            //     File(imagePath),
            //   ),
            // ),

            Image.network("https://cdn.motor1.com/images/mgl/8e8Mo/s1/most-expensive-new-cars-ever.webp")
              ],
            )),
      ),
    );
  }
}
