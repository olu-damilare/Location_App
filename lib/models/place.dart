import 'dart:io';

class Place{
  final String id;
  final String title;
  final PlaceLocation? location;
  final File image;

  Place({required this.id,
  required this.title,
  required this.image,
  required this.location});
}

class PlaceLocation{
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address = ""});
}