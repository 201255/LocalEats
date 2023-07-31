import 'package:flutter/material.dart';
import 'home_page.dart';

class Comentarios extends StatefulWidget {
  const Comentarios({Key? key}) : super(key: key);

  @override
  State<Comentarios> createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  bool isLiked = false;
  Color likeIconColor = Colors.white; // Color cuando está desactivado
  Color likedIconColor = Colors.red; // Color cuando está activado
  double likeButtonScale = 1.5; // Escala inicial del botón
  double nearMeIconScale = 0.8; // Escala del icono "near me"
  double starIconScale = 0.8; // Escala de las estrellas

  void navigateToHomeView() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => const Home(),
      ),
    );
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      // Actualizar el color del ícono
      likeIconColor = isLiked ? likedIconColor : Colors.white;
      // Actualizar la escala del botón
      likeButtonScale = isLiked ? 1.5 : 1.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Image.asset('assets/local1.jpg', fit: BoxFit.cover),
                ),
              ),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.topCenter, // Ajusta la posición vertical del cuadro
                  child: FractionalTranslation(
                    translation: const Offset(0.0, -0.5), // Mueve el cuadro hacia arriba
                    child: Container(
                      width: 150, // Ajusta el ancho del cuadro según tus necesidades
                      height: 35, // Ajusta el alto del cuadro según tus necesidades
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.scale(
                            scale: nearMeIconScale,
                            child: const Icon(
                              Icons.near_me,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            'Ubicación',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 50,
            right: 15,
            child: Transform.scale(
              scale: likeButtonScale,
              child: IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: likeIconColor,
                ),
                onPressed: toggleLike,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 2,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ),
              onPressed: navigateToHomeView,
            ),
          ),
          Positioned(
            top: 320, // Ajusta la posición vertical del texto principal
            left: 20, // Ajusta la posición horizontal del texto principal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Fonda El Panalito',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Mexicana ◦ Especies',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Transform.scale(
                      scale: starIconScale, // Ajusta el tamaño de las estrellas aquí
                      child:const Icon(Icons.star, color: Colors.yellow), // Estrellas
                    ),
                    Transform.scale(
                      scale: starIconScale, // Ajusta el tamaño de las estrellas aquí
                      child:const Icon(Icons.star, color: Colors.yellow),
                    ),
                    Transform.scale(
                      scale: starIconScale, // Ajusta el tamaño de las estrellas aquí
                      child:const Icon(Icons.star, color: Colors.yellow),
                    ),
                    Transform.scale(
                      scale: starIconScale, // Ajusta el tamaño de las estrellas aquí
                      child:const Icon(Icons.star_border, color: Colors.grey),
                    ),
                    Transform.scale(
                      scale: starIconScale, // Ajusta el tamaño de las estrellas aquí
                      child:const Icon(Icons.star_border, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Nuestra comida es preparada de la mejor calidad y de la\n mas tradicional de Suchiapa, desde unos ricos caldos hasta\n la mejor carne desde 1970.',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 30),
                const Text(
                  ' Reseñas',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 2),
                const Text(
                  '————————————————————————',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/download5.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yurandir Garcia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Row(
                              children:  [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '                                      11/01',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      '   Muuy top las comdas, recomiendo el\n   restaurante; tomen creatina',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                const SizedBox(height: 2),
                const Text(
                  '————————————————————————',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/download5.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yurandir Garcia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Row(
                              children:  [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '                                      11/01',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      '   Muuy top las comdas, recomiendo el\n   restaurante; tomen creatina',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                                const SizedBox(height: 2),
                const Text(
                  '————————————————————————',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
                const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/download5.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yurandir Garcia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Row(
                              children:  [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '                                      11/01',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      '   Muuy top las comdas, recomiendo el\n   restaurante; tomen creatina',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                const SizedBox(height: 2),
                const Text(
                  '————————————————————————',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  softWrap: true,
                ),
              const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(3.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/download5.jpg'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Yurandir Garcia',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              softWrap: true,
                            ),
                            Row(
                              children:  [
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color.fromARGB(255, 230, 187, 0),
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          '                                      11/01',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          softWrap: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      '   Muuy top las comdas, recomiendo el\n   restaurante; tomen creatina',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                      softWrap: true,
                    ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
