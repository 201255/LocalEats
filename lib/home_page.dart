import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'login.dart';

class LocalDestacado {
  final String imagen;
  final String texto;
  final String textoAdicional;

  LocalDestacado({
    required this.imagen,
    required this.texto,
    required this.textoAdicional,
  });
}

class Locales {
  final String imagen;
  final String texto;
  final String textoAdicional;
    final int rating;


  Locales({
    required this.imagen,
    required this.texto,
    required this.textoAdicional,
        required this.rating,

  });
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? _currentPosition;
  String _currentAddress = 'Cargando...';

  List<LocalDestacado> localesDestacados = [
    LocalDestacado(
      imagen: 'assets/local1.jpg',
      texto: 'Fonda El Panalito',
      textoAdicional: ' Mexicana ◦ Especies',
    ),
    LocalDestacado(
      imagen: 'assets/local2.jpg',
      texto: 'Ciudad Bocado',
      textoAdicional: ' Mexicana ◦ Callejera',
    ),
    LocalDestacado(
      imagen: 'assets/locales.jpg',
      texto: 'Las Brisas',
      textoAdicional: ' Mexicana ◦ Callejera',
    ),
  ];

  List<Locales> locales =[
      Locales(
      imagen: 'assets/1.jpg',
      texto: 'La Juquilita',
      textoAdicional: ' Mexicana ◦ Especies',
            rating: 5,

    ),
    Locales(
      imagen: 'assets/2.jpg',
      texto: 'A la Mexicana',
      textoAdicional: ' Mexicana ◦ Callejera',
            rating: 5,

    ),
    Locales(
      imagen: 'assets/3.jpg',
      texto: 'El Chaparrito',
      textoAdicional: ' Mexicana ◦ Callejera',
            rating: 5,

    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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

      List<Location> locations = await locationFromAddress("Chiapas, Mexico");
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
      setState(() {
        _currentAddress = 'Error al obtener la ubicación';
      });
    }
  }

  void navigateToAccountView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Login(),
      ),
    );
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
                backgroundImage: AssetImage('assets/download5.jpg'),
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
                navigateToAccountView();
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
            child: Container(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                scrollDirection: Axis.horizontal,
                itemCount: localesDestacados.length,
                itemBuilder: (BuildContext context, int index) {
                  LocalDestacado local = localesDestacados[index];
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
                              image: AssetImage(local.imagen),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: deviceWidth * 0.8,
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            local.texto,
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
                            local.textoAdicional,
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
          const SizedBox(height: 20.0),
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
          Expanded(
            child: Center(
            child: Container(
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
                              image: AssetImage(local.imagen),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: deviceWidth * 0.8,
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            local.texto,
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
                            local.textoAdicional,
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
