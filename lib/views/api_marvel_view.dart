import 'package:flutter/material.dart';
import '../controllers/api_marvel_controller.dart';
import '../models/api_marvel_model.dart';
import 'editar_dato_view.dart';

class DatosView extends StatefulWidget {
  @override
  State<DatosView> createState() => _DatosViewState();
}

class _DatosViewState extends State<DatosView> {
  final ControladorDatos controladorDatos = ControladorDatos();
  late Future<List<Datos>> _datosFuturos;

  List<Datos> _listaDatos = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() async {
    _datosFuturos = controladorDatos.obtenerDatos();
    final datos = await _datosFuturos;
    setState(() {
      _listaDatos = datos;
    });
  }

  void _eliminarDato(int index) {
    setState(() {
      _listaDatos.removeAt(index); // Elimina el dato de la lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Image.asset(
          'assets/imagenes/logo Marvel.png', // Imagen del título
          height: 150,
          fit: BoxFit.contain,

        ),
      ),
      body: FutureBuilder<List<Datos>>(
        future: _datosFuturos,
        builder: (BuildContext context, AsyncSnapshot<List<Datos>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No hay datos disponibles"));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Número de columnas
              crossAxisSpacing: 10, // Espacio horizontal entre tarjetas
              mainAxisSpacing: 10, // Espacio vertical entre tarjetas
              childAspectRatio: 0.7, // Relación de aspecto ancho/alto
            ),

            itemCount: _listaDatos.length,
            itemBuilder: (BuildContext context, int index) {
              final Datos dato = _listaDatos[index];
              bool isTapped = false;

              return StatefulBuilder(
                builder: (context, setStateCard) {
                  return GestureDetector(
                    onTap: () {
                      setStateCard(() {
                        isTapped = !isTapped;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isTapped ? Colors.black : Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Imagen del héroe
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Image.network(
                                dato.imagen,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 100,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),

                          // Texto del héroe
                          Text(
                            dato.nombre,
                            style: TextStyle(
                              color: isTapped ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 5),

                          // Mostrar descripción si está en fondo negro
                          if (isTapped)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                dato.descripcion.isNotEmpty
                                    ? dato.descripcion
                                    : 'Descripción no disponible',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),

                          // Iconos de eliminar y editar
                          if (!isTapped)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.white),
                                  onPressed: () async {
                                    final nuevoDato = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditarDatoView(
                                          dato: dato,
                                        ),
                                      ),
                                    );

                                    if (nuevoDato != null) {
                                      setState(() {
                                        _listaDatos[index] = nuevoDato;
                                      });
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.white),
                                  onPressed: () {
                                    _eliminarDato(index);
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
