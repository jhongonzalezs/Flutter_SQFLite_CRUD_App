import '../screens/home_screen.dart';
import '../screens/add_user_screen.dart';
import '../screens/list_users_screen.dart';
import '../screens/update_user_screen.dart';
import '../screens/delete_user_screen.dart';

class AppRoutes {
  static const home = '/';
  static const addUser = '/add';
  static const listUsers = '/list';
  static const updateUser = '/update';
  static const deleteUser = '/delete';

  static final routes = {
    home: (context) => const HomeScreen(),
    addUser: (context) => const AddUserScreen(),
    listUsers: (context) => const ListUsersScreen(),
    updateUser: (context) => const UpdateUserScreen(),
    deleteUser: (context) => const DeleteUserScreen(),
  };
}
