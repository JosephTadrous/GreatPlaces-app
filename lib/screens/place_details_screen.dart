import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/great_places.dart';
import '../screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routeName = '/place-details';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
        Text(
          selectedPlace.location.address,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 20),
        ),
        SizedBox(height: 10),
        FlatButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MapScreen(
                initialPosition: selectedPlace.location,
                isSelecting: false,
              ),
            ),
          ),
          child: Text('View on Map'),
          textColor: Theme.of(context).primaryColor,
        )
      ]),
    );
  }
}
