import 'package:flutter/material.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        child: const Center(
          child: ListTile(
            title: Text(
              "404",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Text(
              'Pagina no econtrada',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
