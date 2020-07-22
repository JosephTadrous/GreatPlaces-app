import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('No Location Chosen', textAlign: TextAlign.center)
              : Image.network(_previewImageUrl),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          FlatButton.icon(
            onPressed: () {},
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
          ),
          FlatButton.icon(
            onPressed: () {},
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.map),
            label: Text('Select Location'),
          ),
        ])
      ],
    );
  }
}
