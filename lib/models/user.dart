class User {
  int? id;
  String cedula;
  String nombre;  
  int age;
  String email;

  User({
    this.id,
    required this.cedula,
    required this.nombre, 
    required this.age,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cedula': cedula,
      'nombre': nombre,  
      'edad': age,        
      'correo': email,    
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      cedula: map['cedula'],
      nombre: map['nombre'],  
      age: map['edad'],       
      email: map['correo'],   
    );
  }
}
