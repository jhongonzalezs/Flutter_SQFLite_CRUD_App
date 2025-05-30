import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestión de Usuarios')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildCrudButton(
              context,
              icon: Icons.person_add,
              label: 'Agregar Usuario',
              color: Colors.green,
              route: '/add',
            ),
            _buildCrudButton(
              context,
              icon: Icons.list_alt,
              label: 'Listar Usuarios',
              color: Colors.blue,
              route: '/list',
            ),
            _buildCrudButton(
              context,
              icon: Icons.edit,
              label: 'Actualizar Usuario',
              color: Colors.orange,
              route: '/update',
            ),
            _buildCrudButton(
              context,
              icon: Icons.delete,
              label: 'Eliminar Usuario',
              color: Colors.red,
              route: '/delete', 
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCrudButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required String route}) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: Colors.white),
          const SizedBox(height: 12),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
