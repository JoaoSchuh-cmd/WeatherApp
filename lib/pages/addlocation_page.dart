import 'package:flutter/material.dart';
import 'package:weatherapp/model/location.dart';
import 'package:weatherapp/service/locations_service.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  List<Location> _locationsList = [];
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _loadLocations();
  }

  Future<void> _loadLocations() async {
    setState(() {
      _locationsList = LocationsService().getLocations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Localidades",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(
                      context,
                      _locationsList
                          .firstWhere((element) => element.selected == true)
                          .cityName);
                });
              },
              icon: const Icon(Icons.arrow_back))),
      body: Container(
        padding:
            const EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.055,
                    child: Form(
                      child: TextField(
                        textAlign: TextAlign.start,
                        controller: _locationController,
                        decoration: InputDecoration(
                          hintText: "Adicione uma localização...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.black87,
                            ), // Cor da borda padrão
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                                color: Colors
                                    .lightBlue), // Cor da borda quando focado
                          ),
                          prefixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_locationsList.isNotEmpty) {
                        for (final e in _locationsList) {
                          if (e.selected) {
                            e.selected = false;
                          }
                        }
                      }
                      LocationsService().addLocation(Location(
                          cityName: _locationController.text, selected: true));
                    });
                    _locationController.text = "";
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _locationsList.length,
                itemBuilder: (context, index) {
                  final location = _locationsList[index];
                  return ListTile(
                    leading: const Icon(Icons.place),
                    title: Text(location.cityName),
                    trailing: Checkbox(
                      fillColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors
                              .lightBlue; // Cor de preenchimento quando selecionado
                        }
                        return Colors.white;
                      }),
                      value: location.selected,
                      onChanged: (value) {
                        setState(() {
                          if (_locationsList.isNotEmpty) {
                            for (final e in _locationsList) {
                              if (e.selected) {
                                e.selected = false;
                              }
                            }
                            location.selected = value!;
                          }
                        });
                      },
                    ),
                    onLongPress: () {
                      setState(() {
                        LocationsService()
                            .deleteLocation(_locationsList[index].id);
                      });
                    },
                    // subtitle: Text(
                    //   'Latitude: ${location.lat.toString()}, Longitude: ${location.lon.toString()}',
                    // ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
