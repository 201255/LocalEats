// ignore_for_file: unused_local_variable, prefer_const_declarations, no_leading_underscores_for_local_identifiers, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';
import 'local_page.dart';
import 'comentarios.dart';
import 'profile_page.dart';

class LocalDestacado {
  final String imagen;
  final String namelocal;
  final String genero;

  LocalDestacado({
    required this.imagen,
    required this.namelocal,
    required this.genero,
  });

  factory LocalDestacado.fromJson(Map<String, dynamic> json) {
    return LocalDestacado(
      imagen: json['imagen'] != null ? json['imagen'].toString() : '',
      namelocal: json['namelocal'] != null ? json['namelocal'].toString() : '',
      genero: json['genero'] != null ? json['genero'].toString() : '',
    );
  }
}

class Locales {
  final String imagen;
  final String namelocal;
  final String genero;
  final int rating;

  Locales({
    required this.imagen,
    required this.namelocal,
    required this.genero,
    required this.rating,
  });

  factory Locales.fromJson(Map<String, dynamic> json) {
    return Locales(
      imagen: json['imagen'] != null ? json['imagen'].toString() : '',
      namelocal: json['namelocal'] != null ? json['namelocal'].toString() : '',
      genero: json['genero'] != null ? json['genero'].toString() : '',
      rating: json['rating'] != null ? json['rating'] as int : 0,
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<bool> _access;
  
  Position? _currentPosition;
  String _currentAddress = 'Cargando...';

  void navigateToAccountView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
  }

  void navigateToLocalView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Local(),
      ),
    );
  }

  List<LocalDestacado> localesDestacados = [];
  List<Locales> locales = [];

  @override
  void initState() {
    super.initState();

_access = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('userLogeado') ?? false);
    }); 

    _getCurrentLocation();
    _loadLocalesData();
  }


  Future<List<Locales>> fetchLocalesData(String location) async {

    final url = 'http://localhost:3000/api/local/viewAll'; // Replace with the actual API URL
    
    final dio = Dio();

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;

        List<Locales> locales = List<Locales>.from(data.map((json) => Locales.fromJson(json)));
        
        return locales;
      } else {
        throw Exception('Failed to load locales');
      }
    } catch (e) {
      throw Exception('Error fetching locales data: $e');
    }
  }

  void _loadLocalesData() async {
    try {
      List<Locales> localesData = await fetchLocalesData("Suchiapa, Mexico");
      setState(() {
        localesDestacados = localesData
            .map((local) => LocalDestacado(
                  imagen: local.imagen,
                  namelocal: local.namelocal,
                  genero: local.genero,
                ))
            .toList();
        locales = localesData;
      });
    } catch (e) {
      // Handle error if the API call fails
      print("Error fetching locales data: $e");
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _currentAddress = 'Servicios de ubicación deshabilitados';
        });
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            _currentAddress = 'Permiso denegado para acceder a la ubicación';
          });
          return;
        }
      }

      List<Location> locations = await locationFromAddress("Suchiapa, Mexico");
      if (locations.isNotEmpty) {
        Location location = locations.first;
        _currentPosition = Position.fromMap({
          'latitude': location.latitude,
          'longitude': location.longitude,
        });

        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark placemark = placemarks.first;
          setState(() {
            _currentAddress = placemark.locality ?? 'Ubicación desconocida';
          });
        } else {
          setState(() {
            _currentAddress = 'Ubicación desconocida';
          });
        }
      } else {
        setState(() {
          _currentAddress = 'Ubicación no encontrada';
        });
      }
    } catch (e) {
      setState(() => _currentAddress = 'Error al obtener la ubicación');
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;


    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        toolbarHeight: 100,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 221, 220, 220),
                  width: 2.0,
                ),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage('assets/1.jpg'),
                radius: 16,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: const Text(
                      'LocalEats',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.my_location,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        _currentAddress,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // Acción al hacer clic en el botón de cuenta
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 18.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Locales Destacados',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                        if (index >= localesDestacados.length) {
                            return null; 
                        }
                  LocalDestacado local = localesDestacados[index];
                  return InkWell(
                    onTap: () {
                      // Acción al hacer clic en la imagen
                      // Agrega aquí el código que deseas ejecutar al hacer clic en la imagen
                      // navigateToLocalView();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: deviceWidth * 0.8,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage('http://localhost:3000/api/local/view_img?img1=' + (local.imagen)), 
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  // Acción al hacer clic en la imagen
                                  // Agrega aquí el código que deseas ejecutar al hacer clic en la imagen
                                  navigateToLocalView();
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            width: deviceWidth * 0.8,
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              local.namelocal,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Container(
                            width: deviceWidth * 0.8,
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              local.genero,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 2),
          const Padding(
            padding: EdgeInsets.only(top: 0.0, left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Todos los locales',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            child: Center(
              child: SizedBox(
                width: deviceWidth * 30000.20,
                height: 400,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 2.0, left: 25.0),
                  scrollDirection: Axis.vertical,
                  itemCount: locales.length,
                  itemBuilder: (BuildContext context, int index) {
                    Locales local = locales[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: deviceWidth * 0.8,
                            height: 150,
                           decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: NetworkImage('http://localhost:3000/api/local/view_img?img1=' + (local.imagen)),// Reemplaza esta URL con la dirección real de la imagen web
                                fit: BoxFit.cover,
                              ),
//coloca tu imagen
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Container(
                            width: deviceWidth * 0.8,
                            padding: const EdgeInsets.all(3.0),
                            child: Text(
                              local.namelocal,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Container(
                            width: deviceWidth * 0.8,
                            padding: const EdgeInsets.all(0.0),
                            child: Text(
                              local.genero,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: Colors.grey[300],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.black,
                ),
                Text(
                  'Locales',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                Text(
                  'Buscar',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                // Acción al hacer clic en el botón de cuenta
                navigateToAccountView();
              },
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  Text(
                    'Cuenta',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
