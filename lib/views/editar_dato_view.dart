import 'package:flutter/material.dart';
import '../models/api_marvel_model.dart';

class EditarDatoView extends StatefulWidget {
  final Datos dato;

  const EditarDatoView({Key? key, required this.dato}) : super(key: key);

  @override
  State<EditarDatoView> createState() => _EditarDatoViewState();
}

class _EditarDatoViewState extends State<EditarDatoView> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.dato.nombre);
    _descripcionController = TextEditingController(text: widget.dato.descripcion);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  void _guardarCambios() {
    final nuevoDato = Datos(
      id: widget.dato.id,
      nombre: _nombreController.text,
      descripcion: _descripcionController.text,
      imagen: widget.dato.imagen, // Mantiene la misma imagen
    );
    Navigator.pop(context, nuevoDato); // Retorna el dato editado
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Personaje'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _guardarCambios,
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
