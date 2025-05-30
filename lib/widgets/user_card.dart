import 'package:flutter/material.dart';
import '../models/user.dart';
import '../screens/delete_user_screen.dart';
import '../screens/update_user_screen.dart';

class UserCard extends StatefulWidget {
  final User user;

  const UserCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _irAEliminar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeleteUserScreen(initialCedula: widget.user.cedula),
      ),
    );
  }

  void _irAActualizar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UpdateUserScreen(initialCedula: widget.user.cedula),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: Colors.grey[50], 
        child: GestureDetector(
          onTap: _toggleExpand,
          child: Container(
            constraints: BoxConstraints(maxWidth: double.infinity),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue[200],
                      child: const Icon(
                        Icons.person,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.nombre,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueAccent,
                            ),
                            overflow: TextOverflow.ellipsis, 
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Cédula: ${widget.user.cedula}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                          Text(
                            'Edad: ${widget.user.age}',
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Correo: ${widget.user.email}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      onPressed: () => _irAEliminar(context),
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Eliminar',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      ),
                      onPressed: () => _irAActualizar(context),
                      child: Row(
                        children: const [
                          Icon(Icons.edit, color: Colors.white, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Actualizar',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}