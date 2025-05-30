import 'package:flutter/material.dart';
import '../models/user.dart';
import '../data/user_database.dart';
import 'confirm_delete_dialog.dart';

class SearchUserForm extends StatelessWidget {
  final TextEditingController controller;
  final void Function(User? usuario, String? error) onResult;

  const SearchUserForm({
    Key? key,
    required this.controller,
    required this.onResult,
  }) : super(key: key);

  Future<void> _buscarUsuario() async {
    final usuarios = await UserDatabase.instance.getAllUsers();
    final cedula = controller.text.trim();

    if (cedula.isEmpty) {
      onResult(null, 'Ingresa una cédula');
      return;
    }

    final encontrado = usuarios.firstWhere(
      (u) => u.cedula == cedula,
      orElse: () => User(id: -1, nombre: '', cedula: '', age: 0, email: ''),
    );

    if (encontrado.id == -1) {
      onResult(null, 'Usuario no encontrado.');
    } else {
      onResult(encontrado, null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Cédula del Usuario',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: _buscarUsuario,
          child: const Text('Buscar'),
        ),
      ],
    );
  }
}

class UserDeleteCard extends StatelessWidget {
  final User usuario;
  final VoidCallback onDelete;

  const UserDeleteCard({
    Key? key,
    required this.usuario,
    required this.onDelete,
  }) : super(key: key);

  void _mostrarDialogoConfirmacion(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ConfirmDeleteDialog(onConfirm: onDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(top: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              '¿Eliminar a este usuario?',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              usuario.nombre,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _mostrarDialogoConfirmacion(context),
              icon: const Icon(Icons.delete),
              label: const Text('Eliminar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}