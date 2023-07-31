import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';
import 'login.dart';
import 'registerLocal.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}


class _ProfileState extends State<Profile> {
  //variables de permanencia
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // ignore: unused_field
  late Future<bool> _access;

  Future<void> cerrarSesion() async {
    final SharedPreferences prefs = await _prefs;
    const bool logeado = false;

    setState(() {
      _access = prefs.setBool("userLogeado", logeado).then((bool success) {
        return logeado;
      });
    });

    if (logeado == false) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => const Login()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> opciones = ['Home', 'home', 'Opción 3', 'Opción 4'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Home(),
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(left: 60, right: 60),
              child: Text(
                'Maria Cruz',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.black,
              onPressed: () {
                cerrarSesion();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 45),
          Column(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 152, 151, 151),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/download5.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text(
                    'Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                ),
                ListTile(
                  title: const Text(
                    'Mi LocalEats',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const Rlocal(),
                  ),
                );
        },
        child: Icon(Icons.add, color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 248, 248, 248),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
