import 'package:flutter/material.dart';
import '../data/user_database.dart';
import '../models/user.dart';
import '../widgets/delete_user_widgets.dart';

class DeleteUserScreen extends StatefulWidget {
  final String? initialCedula;

  const DeleteUserScreen({Key? key, this.initialCedula}) : super(key: key);

  @override
  State<DeleteUserScreen> createState() => _DeleteUserScreenState();
}

class _DeleteUserScreenState extends State<DeleteUserScreen> {
  final TextEditingController _cedulaController = TextEditingController();
  User? _usuarioEncontrado;
  String? _mensaje;

  @override
  void initState() {
    super.initState();
    if (widget.initialCedula != null) {
      _cedulaController.text = widget.initialCedula!;
      Future.microtask(() => _buscarUsuario());
    }
  }

  void _actualizarResultado(User? user, String? mensaje) {
    setState(() {
      _usuarioEncontrado = user;
      _mensaje = mensaje;
    });
  }

  Future<void> _buscarUsuario() async {
    final usuarios = await UserDatabase.instance.getAllUsers();
    final cedula = _cedulaController.text.trim();

    if (cedula.isEmpty) {
      _actualizarResultado(null, 'Por favor ingresa una cédula.');
      return;
    }

    final encontrado = usuarios.firstWhere(
      (u) => u.cedula == cedula,
      orElse: () => User(id: -1, nombre: '', cedula: '', age: 0, email: ''),
    );

    if (encontrado.id == -1) {
      _actualizarResultado(null, 'Usuario no encontrado.');
    } else {
      _actualizarResultado(encontrado, null);
    }
  }

  Future<void> _eliminarUsuario() async {
    if (_usuarioEncontrado != null && _usuarioEncontrado!.id != null) {
      await UserDatabase.instance.deleteUser(_usuarioEncontrado!.id!);
      setState(() {
        _cedulaController.clear();
        _usuarioEncontrado = null;
        _mensaje = 'Usuario eliminado con éxito.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eliminar Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchUserForm(
                controller: _cedulaController,
                onResult: _actualizarResultado,
              ),
              const SizedBox(height: 30),
              if (_mensaje != null)
                Text(
                  _mensaje!,
                  style: TextStyle(
                    color: _mensaje == 'Usuario eliminado con éxito.' ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              const SizedBox(height: 20),
              if (_usuarioEncontrado != null)
                UserDeleteCard(
                  usuario: _usuarioEncontrado!,
                  onDelete: _eliminarUsuario,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
