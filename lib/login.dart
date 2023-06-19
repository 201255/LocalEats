import 'package:flutter/material.dart';
import 'package:localeats/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}
  

class _LoginState extends State<Login> {
  void _submitForm() {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => const Register(
          ),
        ),
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo2.png',
              width: 200.0,
              height: 200.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'LocalEats',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 7.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
                prefixIcon: Padding(
                  padding:  EdgeInsets.all(8.0),
                  child: Icon(Icons.person),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Padding(
                        padding:  EdgeInsets.all(8.0),
                        child: Icon(Icons.lock),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GestureDetector(
                    onTap: () {
                      // Acción al presionar el texto "Forgot Password?"
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color.fromARGB(255, 93, 93, 93),
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: (){
                
              } ,
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color.fromARGB(255, 93, 93, 93)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              child: Container(
                width: 200.0,
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Center(
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: _submitForm,
              child: const Text(
              'Registrarme',
              style:TextStyle(
                color: Color.fromARGB(255, 93, 93, 93),
                fontSize: 14.0,
              ),
            ),
            ),


          ],
        ),
      ),
    );
  }
}
