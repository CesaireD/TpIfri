import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class AjouterProduit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AjouterProduitState();
  }
  
}
class AjouterProduitState extends State<AjouterProduit> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'image/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Download link: $urlDownload');
    setState(() {
      uploadTask = null;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(child: Text(
                  '${(100*progress).roundToDouble()}%',
                  style: const TextStyle(color: Colors.white),
                ),)
              ],
            ),
          );
        }else{
          return const SizedBox(height: 50,);
        }
      });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(pickedFile != null)
            Expanded(
                child: Container(
                  color: Colors.blue[100],
                  child: Image.file(
                    File(pickedFile!.path!),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                )
            ),
          ElevatedButton(
              onPressed: selectFile,
              child: const Text('Choisir une image')
          ),
          const SizedBox(height: 32,),
          ElevatedButton(
              onPressed: uploadFile,
              child: const Text('Ajouter une image')
          ),
          const SizedBox(height: 32,),
          buildProgress()
        ],
      ),
    );
  }
}
