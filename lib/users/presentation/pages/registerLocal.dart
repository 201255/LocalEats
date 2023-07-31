import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class Rlocal extends StatefulWidget {
  const Rlocal({Key? key}) : super(key: key);

  @override
  State<Rlocal> createState() => _RlocalState();
}

class _RlocalState extends State<Rlocal> {
  File? _imageFile;
  final TextEditingController _nameLocalController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _menuController = TextEditingController();

  Future<void> _selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    final dio = Dio();
    const url = 'http://localhost:3000/api/local/createLocal'; // Reemplaza esto con la URL de tu endpoint para subir imágenes

    // Agregar el archivo de imagen
    String fileName = _imageFile!.path.split('/').last;
    FormData formData = FormData.fromMap({
      'imagen': await MultipartFile.fromFile(_imageFile!.path, filename: fileName),
      'namelocal': _nameLocalController.text,
      'genero': _genderController.text,
      'descripcion': _descriptionController.text,
      'ubicacion': _locationController.text,
      'menu': _menuController.text,
    });

    try {
      Response response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        print('¡Imagen y datos del formulario subidos exitosamente!');
      } else {
        print('Error al subir la imagen y los datos del formulario. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al subir la imagen y los datos del formulario: $e');
    }
  }

  void _goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: _imageFile != null
                                ? Image.file(
                                    _imageFile!,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.add,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: _selectImage,
                                splashColor: Colors.black.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            TextFormField(
                              controller: _nameLocalController,
                              decoration: InputDecoration(labelText: 'Nombre del Local'),
                            ),
                            TextFormField(
                              controller: _genderController,
                              decoration: InputDecoration(labelText: 'Género'),
                            ),
                            TextFormField(
                              controller: _descriptionController,
                              decoration: InputDecoration(labelText: 'Descripción'),
                            ),
                            TextFormField(
                              controller: _locationController,
                              decoration: InputDecoration(labelText: 'Ubicación'),
                            ),
                            TextFormField(
                              controller: _menuController,
                              decoration: InputDecoration(labelText: 'Menú'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _uploadImage,
                        child: Text('Enviar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 20,
                padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 16.0),
                child: IconButton(
                  onPressed: _goBack,
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


