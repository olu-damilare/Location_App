import 'package:flutter/material.dart';
import 'package:places_app/models/place.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/maps_screen.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  const PlaceDetailScreen({Key? key}) : super(key: key);

  static const routeName = '/place-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context, listen: false).findById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(children: [
        Container(height: 250,
        width: double.infinity,
          child: Image.file(
            selectedPlace.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        SizedBox(height: 10),
        Text(selectedPlace.location!.address, textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.blueGrey
        ),
        ),
        SizedBox(height: 10,),
        FlatButton(
          child: Text('View onMap'),
          textColor: Theme.of(context).primaryColor,
          onPressed: (){
             Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
                builder: (ctx) => MapScreen(
                  initialLocation: selectedPlace.location as PlaceLocation,
                  isSelecting: false
                )
            )
            );
          } ,
        )
      ],),
    );
  }
}
