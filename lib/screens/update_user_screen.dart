import 'package:flutter/material.dart';
import '../data/user_database.dart';
import '../models/user.dart';
import '../widgets/update_form.dart';

class UpdateUserScreen extends StatefulWidget {
  final String? initialCedula;

  const UpdateUserScreen({super.key, this.initialCedula});

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cedulaController = TextEditingController();
  final _nombreController = TextEditingController();
  final _edadController = TextEditingController();
  final _correoController = TextEditingController();

  bool _isUserLoaded = false;
  int? _userId;

  @override
  void initState() {
    super.initState();
    if (widget.initialCedula?.isNotEmpty ?? false) {
      _cedulaController.text = widget.initialCedula!;
      _buscarUsuario();
    }
  }

  Future<void> _buscarUsuario() async {
    final cedula = _cedulaController.text.trim();
    if (cedula.isEmpty) return;

    final usuarios = await UserDatabase.instance.getAllUsers();
    final user = usuarios.firstWhere(
      (u) => u.cedula == cedula,
      orElse: () => User(id: -1, nombre: '', cedula: '', age: 0, email: ''),
    );

    if (user.id == -1) {
      setState(() => _isUserLoaded = false);
      _mostrarSnackbar('La cédula no existe');
    } else {
      setState(() {
        _isUserLoaded = true;
        _userId = user.id;
        _nombreController.text = user.nombre;
        _edadController.text = user.age.toString();
        _correoController.text = user.email;
      });
    }
  }

  Future<void> _actualizarUsuario() async {
    if (!_formKey.currentState!.validate()) {
      _mostrarSnackbar('Corrige los errores del formulario');
      return;
    }

    if (_userId == null) {
      _mostrarSnackbar('No hay usuario cargado');
      return;
    }

    final updatedUser = User(
      id: _userId!,
      nombre: _nombreController.text.trim(),
      cedula: _cedulaController.text.trim(),
      age: int.tryParse(_edadController.text) ?? 0,
      email: _correoController.text.trim(),
    );

    final usuarios = await UserDatabase.instance.getAllUsers();
    final cedulaDuplicada = usuarios.any(
      (u) => u.cedula == updatedUser.cedula && u.id != updatedUser.id,
    );

    if (cedulaDuplicada) {
      _mostrarSnackbar('Ya existe otro usuario con esa cédula');
      return;
    }

    await UserDatabase.instance.updateUser(updatedUser);
    _mostrarSnackbar('Usuario actualizado correctamente');
  }

  void _mostrarSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensaje)));
  }

  @override
  void dispose() {
    _cedulaController.dispose();
    _nombreController.dispose();
    _edadController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar Usuario', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: UpdateForm(
            isUserLoaded: _isUserLoaded,
            initialCedula: widget.initialCedula,
            cedulaController: _cedulaController,
            nombreController: _nombreController,
            edadController: _edadController,
            correoController: _correoController,
            onBuscarUsuario: _buscarUsuario,
            onActualizarUsuario: _actualizarUsuario,
          ),
        ),
      ),
    );
  }
}