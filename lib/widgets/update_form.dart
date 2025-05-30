import 'package:flutter/material.dart';

class UpdateForm extends StatelessWidget {
  final bool isUserLoaded;
  final String? initialCedula;
  final TextEditingController cedulaController;
  final TextEditingController nombreController;
  final TextEditingController edadController;
  final TextEditingController correoController;
  final VoidCallback onBuscarUsuario;
  final VoidCallback onActualizarUsuario;

  const UpdateForm({
    super.key,
    required this.isUserLoaded,
    required this.initialCedula,
    required this.cedulaController,
    required this.nombreController,
    required this.edadController,
    required this.correoController,
    required this.onBuscarUsuario,
    required this.onActualizarUsuario,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cedulaController,
                      enabled: initialCedula == null,
                      decoration: const InputDecoration(
                        labelText: 'Cédula',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.badge),
                      ),
                    ),
                  ),
                  if (initialCedula == null) ...[
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: onBuscarUsuario,
                      icon: const Icon(Icons.search),
                      label: const Text('Buscar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nombreController,
                enabled: isUserLoaded,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Campo requerido'
                            : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: edadController,
                enabled: isUserLoaded,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
                validator: (value) {
                  if (!isUserLoaded) return null;
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  final edad = int.tryParse(value);
                  if (edad == null || edad <= 0) return 'Edad inválida';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: correoController,
                enabled: isUserLoaded,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (!isUserLoaded) return null;
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (!value.contains('@')) return 'Correo inválido';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (isUserLoaded)
                ElevatedButton.icon(
                  onPressed: onActualizarUsuario,
                  icon: const Icon(Icons.save),
                  label: const Text('Actualizar'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.teal,
                    minimumSize: const Size.fromHeight(50),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
