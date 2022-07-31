import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../helpers/location_helper.dart';
import '../screens/maps_screen.dart';

class LocationInput extends StatefulWidget {

  final Function onSelectPlace;

  const LocationInput({required this.onSelectPlace});


  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
 String? _previewImageUrl;

 Future<void> _getCurrentUserLocation() async {
   try {
     final locData = await Location().getLocation();
     _showPreview(locData.latitude!, locData.longitude!);
   }catch(error){
     return;
   }
 }

 void _showPreview(double lat, double lng){
   final staticMapImageUrl = LocationHelper.generateLocationPreviewImage(latitude: lat, longitude: lng);

   setState(() {
     _previewImageUrl = staticMapImageUrl;
   });
   widget.onSelectPlace(lat, lng);

 }

 Future<void> _selectOnMap() async{
  final LatLng? selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
          fullscreenDialog: true ,
          builder:
       (ctx) => MapScreen(
          isSelecting: true,
   )));

  if(selectedLocation == null){
    return;
  }
  _showPreview(selectedLocation.latitude, selectedLocation.longitude);
  widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
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
