import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/places_list_screen.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';
import './providers/great_places.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => GreatPlaces(),
      child: MaterialApp(
          title: 'Great Places',
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.amber,
          ),
          home: PlacesList(),
          routes: {
            AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
            PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
          }),
    );
  }
}
