import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;


  Future<void> _getCurrentUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locData = await location.getLocation();
    String staticMapImageUrl = LocationHelper.getLocationPreviewImage(
        longitude: _locData.longitude, latitude: _locData.latitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(_locData.latitude, _locData.longitude);
  }

  Future<void> _selectOnMap() async {
    // wait for the screen to be popped
    final LatLng selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(builder: (ctx) => MapScreen(isSelecting: true)),
    );
    if (selectedLocation == null) {
      return;
    }
    String staticMapImageUrl = LocationHelper.getLocationPreviewImage(
        longitude: selectedLocation.longitude, latitude: selectedLocation.latitude);
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

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
              : Image.network(_previewImageUrl, fit: BoxFit.cover),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          FlatButton.icon(
            onPressed: _getCurrentUserLocation,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
          ),
          FlatButton.icon(
            onPressed: _selectOnMap,
            textColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.map),
            label: Text('Select Location'),
          ),
        ])
      ],
    );
  }
}
