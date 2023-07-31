import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('API Example with Dio'),
        ),
        body: Center(
          child: ImageFromAPI(),
        ),
      ),
    );
  }
}

class ImageFromAPI extends StatefulWidget {
  @override
  _ImageFromAPIState createState() => _ImageFromAPIState();
}

class _ImageFromAPIState extends State<ImageFromAPI> {
  String? _imageName;
  String? _imageUrl;

  Future<void> getImageNameFromAPI() async {
    final apiUrl = 'http://localhost:3000/api/local/viewAll';

    try {
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        // La solicitud fue exitosa, y el cuerpo de la respuesta debe contener el nombre de la imagen.
        final responseData = response.data;
        if (responseData is List && responseData.isNotEmpty) {
          setState(() {
            _imageName = responseData[1]['imagen'];
          });
          print('Nombre de la imagen: $_imageName');
        } else {
          print('Error: La respuesta de la API no contiene una lista con el nombre de la imagen');
        }
      } else {
        // Manejar errores en caso de que la solicitud no sea exitosa
        print('Error en la solicitud de obtener el nombre: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar excepciones
      print('Error en la solicitud de obtener el nombre: $e');
    }
  }

  void getImageUrl() {
    if (_imageName != null) {
      _imageUrl = 'http://localhost:3000/api/local/view_img?img1=$_imageName';
      setState(() {});
    } else {
      print('Error: No se ha obtenido el nombre de la imagen.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            getImageNameFromAPI();
          },
          child: Text('Obtener nombre de imagen'),
        ),
        ElevatedButton(
          onPressed: () {
            getImageUrl();
          },
          child: Text('Cargar imagen'),
        ),
        if (_imageUrl != null)
          Image.network(
            _imageUrl!,
            width: 200,
            height: 200,
          ),
      ],
    );
  }
}
