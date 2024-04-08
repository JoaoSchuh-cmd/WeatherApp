import 'package:flutter/material.dart';
import 'package:weatherapp/model/location.dart';
import 'package:weatherapp/service/locations_service.dart';
import 'package:weatherapp/widgets/rounded_text_form_field.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  List<Location>? locationsList = [
    Location(id: 0, cityName: "Curitiba", selected: false),
    Location(id: 1, cityName: "Floripa", selected: true)
  ];

  @override
  void initState() {
    super.initState();

    _loadLocations();
  }

  Future<void> _loadLocations() async {
    LocationsService()
        .addLocation(Location(id: 0, cityName: "Curitiba", selected: false));
    LocationsService()
        .addLocation(Location(id: 1, cityName: "Floripa", selected: true));

    setState(() {
      locationsList = LocationsService().getLocations();
      print("Tamanho da lista 1: ${locationsList?.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Tamanho da lista 2: ${locationsList?.length}");
    return Container(
      padding: const EdgeInsets.only(top: 50, bottom: 10, left: 10, right: 10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Localidades",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.055,
                  child: const Form(
                    child: RoundedTextFormField(
                      hintText: "Adicione uma localização...",
                      prefixIcon: IconData(0),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  // teste
                },
                icon: const Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          ListView.builder(
            itemCount: locationsList!.length,
            itemBuilder: (context, index) {
              final location = locationsList![index];
              return ListTile(
                leading: const Icon(Icons.place),
                title: Text(location.cityName),

                // subtitle: Text(
                //   'Latitude: ${location.lat.toString()}, Longitude: ${location.lon.toString()}',
                // ),
              );
            },
          ),
        ],
      ),
    );
  }
}
