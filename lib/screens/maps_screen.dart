import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  MapScreen(
  {this.initialLocation = const PlaceLocation(
    latitude: 37.422,
    longitude: -122.084,
  ), this.isSelecting = true}) ;


  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedLocation;

  void _selectLocation(LatLng position){
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Map"),
        actions: [
          if(widget.isSelecting) IconButton(
            icon: Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                 : (){
              Navigator.of(context).pop(_pickedLocation);
            },
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            target: LatLng(
                widget.initialLocation.latitude,
                widget.initialLocation.longitude
            ),
          zoom: 15,
        ),
       onTap: widget.isSelecting ? _selectLocation : null,
        myLocationEnabled: false,
        markers: _pickedLocation == null  && widget.isSelecting ? {} : {
          Marker(
              markerId: MarkerId('m1'),
              position: _pickedLocation ?? LatLng(
                  widget.initialLocation.latitude,
                  widget.initialLocation.longitude
              )
          )
        },
      ),
    );
  }
}
