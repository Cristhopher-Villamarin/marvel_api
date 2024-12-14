import 'package:flutter/material.dart';
import '../controllers/api_marvel_controller.dart';
import '../models/api_marvel_model.dart';
import 'editar_dato_view.dart'; // Nueva vista para editar datos

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

  void _editarDato(Datos nuevoDato, int index) {
    setState(() {
      _listaDatos[index] = nuevoDato; // Actualiza el dato en la lista
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes de Marvel'),
        centerTitle: true,
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

          return ListView.builder(
            itemCount: _listaDatos.length,
            itemBuilder: (BuildContext context, int index) {
              final Datos dato = _listaDatos[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Image.network(
                    dato.imagen,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(dato.nombre,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  subtitle: Text(dato.descripcion.isNotEmpty
                      ? dato.descripcion
                      : 'Descripción no disponible'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
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
                            _editarDato(nuevoDato, index);
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _eliminarDato(index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
