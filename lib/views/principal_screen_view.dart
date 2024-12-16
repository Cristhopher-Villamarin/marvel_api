import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'api_marvel_view.dart';
class PrincipalScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/imagenes/fondoMarvel.jpg', // Ruta de tu imagen de fondo
              fit: BoxFit.cover, // Se ajusta automáticamente
            ),
          ),

          // Contenido en el centro
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Recortar y ajustar el logo
                ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: 0.7, // Ajuste de altura visible
                    widthFactor: 0.92, // Ajuste de anchura visible
                    child: Image.asset(
                      'assets/imagenes/logoMarvel2.jpg', // Ruta de tu logo
                      height: 200, // Altura del logo
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Espaciado entre logo y botón

                // Botón "VER PERSONAJES"
                ElevatedButton.icon(
                  onPressed: () {
                    // Redireccionar a la página existente
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DatosView(),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.superpowers, // Icono de superhéroe
                    color: Colors.white, // Color del ícono
                  ),
                  label: const Text(
                    'VER PERSONAJES',
                    style: TextStyle(
                      fontSize: 25, // Tamaño de la letra
                      fontWeight: FontWeight.bold, // Negrita
                      letterSpacing: 2, // Espaciado entre letras
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // Fondo negro del botón
                    foregroundColor: Colors.white, // Texto blanco
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45, // Ancho del botón
                      vertical: 25, // Altura del botón
                    ),
                    shadowColor: Colors.grey.withOpacity(0.10),
                    elevation: 10, // Elevación para resaltar el botón
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), // Bordes redondeados
                    ),
                    side: const BorderSide(
                      color: Colors.red, // Color del borde
                      width: 2.5, // Grosor del borde
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black, // Fondo negro para toda la pantalla
    );
  }
}

