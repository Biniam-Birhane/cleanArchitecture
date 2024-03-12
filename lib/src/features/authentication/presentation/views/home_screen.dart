import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:industry/src/features/authentication/presentation/widget/add_user_dialog.dart';
import 'package:industry/src/features/authentication/presentation/widget/loading_column.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  void getUsers() {
    context.read<AuthenticationBloc>().add(const GetUserEvent());
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? LoadingColumn(message: "Fetching users")
              : state is CreatingUser
                  ? LoadingColumn(message: "Creating users")
                  : state is UsersLoaded
                      ? Center(
                          child: ListView.builder(
                              itemCount: state.users.length,
                              itemBuilder: (context, index) {
                                final user = state.users[index];
                                return ListTile(
                                  leading: Image.network(user.avatar),
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt.substring(10)),
                                );
                              }))
                      : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AddUserDialog(nameController: nameController))
                    // context.read<AuthenticationBloc>().add(CreateUserEvent(createdAt: DateTime.now().toString(), name: name, avatar: avatar))
                  },
              icon: const Icon(Icons.add),
              label: const Text('Add user')),
        );
      },
    );
  }
}
