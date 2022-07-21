import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your places"),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? Center(
          child: CircularProgressIndicator()
        )
        : Consumer<GreatPlaces>(
          child: Center(
            child: const Text('No places yet, start adding some.'),
        ),
          builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                 ?  ch as Widget
                  : ListView.builder(
            itemCount: greatPlaces.items.length,
              itemBuilder: (ctx, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    greatPlaces.items[i].image
                  ),
                ),
                title: Text(greatPlaces.items[i].title),
                onTap: () {},
              )
          ),
        ),
      ),
    );
  }
}
