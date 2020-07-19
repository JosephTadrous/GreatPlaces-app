import 'dart:io';

import 'package:flutter/material.dart';

class InputImage extends StatelessWidget {
  File storedImage;
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        child: storedImage == null
            ? Text(
                'No Image Taken',
                textAlign: TextAlign.center,
              )
            : Image.file(
                storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
                alignment: Alignment.center,
              ),
        alignment: Alignment.center,
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: FlatButton.icon(
          onPressed: () {},
          icon: Icon(Icons.camera),
          label: Text('Add Photo'),
          textColor: Theme.of(context).primaryColor,
        ),
      ),
    ]);
  }
}
