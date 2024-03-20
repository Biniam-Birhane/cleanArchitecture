import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:industry/src/features/authentication/presentation/views/user_detail.dart';
import 'package:industry/src/features/authentication/presentation/widget/add_user_dialog.dart';
import 'package:industry/src/features/authentication/presentation/widget/loading_column.dart';
import 'package:industry/src/features/authentication/presentation/widget/update_user_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController articleController = TextEditingController();
  

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
        if (state is AuthenticationError ) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated  ||state is UserUpdated || state is UserDeleted) {
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching users")
              : state is CreatingUser
                  ? const LoadingColumn(message: "Creating users")
                  : state is UpdatingUser
                      ? const LoadingColumn(message: "Updating user")
                      : state is DeletingUser
                          ? const LoadingColumn(message: 'Deleting user')
                          : state is UsersLoaded
                              ? Center(
                                  child: ListView.builder(
                                      itemCount: state.users.length,
                                      itemBuilder: (context, index) {
                                        final user = state.users[index];

                                        // final nameController =
                                        //     TextEditingController(text: user.name);
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => UserDetail(user: user.id),
                                              ),
                                            );
                                          },
                                          leading: Image.network(user.avatar),
                                          title: Text(user.name),
                                          subtitle: Text(
                                              user.createdAt.substring(10)),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.edit_note,
                                                  color: Color.fromARGB(
                                                      255, 85, 52, 235),
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          UpdateUserDialog(
                                                              user: user));
                                                  // UpdateUserDialog(
                                                  //     nameController:
                                                  //         nameController));
                                                },
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 241, 10, 41),
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<
                                                          AuthenticationBloc>()
                                                      .add(DeleteUserEvent(
                                                          id: user.id,
                                                          createdAt:
                                                              user.createdAt,
                                                          name: user.name,
                                                          avatar: user.avatar));
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }))
                              : const SizedBox.shrink(),
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AddUserDialog(nameController: nameController,articleController:articleController ,))
                    // context.read<AuthenticationBloc>().add(CreateUserEvent(createdAt: DateTime.now().toString(), name: name, avatar: avatar))
                  },
              icon: const Icon(Icons.add),
              elevation: 20,
              label: const Text('Add user')),
        );
      },
    );
  }
}
