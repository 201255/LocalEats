// ignore_for_file: use_build_context_synchronously

import 'package:localeats/users/presentation/pages/home_page.dart';
// import 'package:afiliaccion/widgets/splash.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../pages/login.dart';

class Rutas extends StatefulWidget {
  const Rutas({super.key});

  @override
  State<Rutas> createState() => _RutasState();
}

// ignore: camel_case_types
class _RutasState extends State<Rutas> {
  //variables de permanencia
  // ignore: prefer_final_fields
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // ignore: unused_field
  late Future<bool> _access;

  @override
  void initState() {
    super.initState();
    _access = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('userLogeado') ?? false);
    });
    _passMenu();
  }

  // ignore: unused_element
  Future<void> _passMenu() async {
    final SharedPreferences prefs = await _prefs;
    final bool? userLogeado = prefs.getBool('userLogeado');

    // print("ir a home? => " '$userLogeado');

    if (userLogeado == true || userLogeado == false) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => const Home()));
    }
    //else {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (BuildContext context) => const Home()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  } 
}

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/home': (BuildContext context) => const Home(),
    '/login': (BuildContext context) => const Login(),
    // '/splash': (_) => const SplashScreen(),
  };
}
