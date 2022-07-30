import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/maps_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
 String? _previewImageUrl;

 Future<void> _getCurrentUserLocation() async {
  final locData = await Location().getLocation();
  final staticMapImageUrl = LocationHelper.generateLocatoinPreviewImage(latitude: locData.latitude, longitude: locData.longitude);

  setState(() {
    _previewImageUrl = staticMapImageUrl;
  });
 }

 Future<void> _selectOnMap() async{
 print("invoked");
  final selectedLocation = await Navigator.of(context).push(MaterialPageRoute(builder:
       (ctx) => MapScreen(
          isSelecting: true,
   )));

  if(selectedLocation == null){
    return;
  }
 }

  @override
  Widget build(BuildContext context) {
    return Column(
     children: [
       Container(
        height: 170,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey
          )
        ),
        child: _previewImageUrl == null ? const Text(
          'No location chosen', 
          textAlign: TextAlign.center,
        )
            : Image.network(_previewImageUrl!, fit: BoxFit.cover, width: double.infinity,)
      ),
       Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
         FlatButton.icon(
             onPressed: _getCurrentUserLocation,
             icon: Icon(Icons.location_on),
               label: Text('Current Location'),
           textColor: Theme.of(context).primaryColor,
         ),
         FlatButton.icon(
           onPressed: _selectOnMap,
           icon: Icon(Icons.map),
           label: Text('Select on Map'),
           textColor: Theme.of(context).primaryColor,
         )
       ],)
    ]
    );
  }
}
