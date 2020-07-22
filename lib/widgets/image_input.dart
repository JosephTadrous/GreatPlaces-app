import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class InputImage extends StatefulWidget {
  final Function onSelectImage;

  InputImage(this.onSelectImage);

  @override
  _InputImageState createState() => _InputImageState();
}

class _InputImageState extends State<InputImage> {
  File _storedImage;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if(pickedFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(pickedFile.path);
    });
    // saving the file on device storage
    // getting the documents directory
    final appDir = await syspath.getApplicationDocumentsDirectory();
    // getting the file name
    final fileName = path.basename(pickedFile.path);
    // copying and saving the file to the device storage at the specified path
    final savedFile = await File(pickedFile.path).copy('${appDir.path}/$fileName');
    widget.onSelectImage(savedFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        child: _storedImage == null
            ? Text(
                'No Image Taken',
                textAlign: TextAlign.center,
              )
            : Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
        alignment: Alignment.center,
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: FlatButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.camera),
          label: Text('Add Photo'),
          textColor: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }
}
