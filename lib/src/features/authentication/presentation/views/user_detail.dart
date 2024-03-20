import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:industry/src/features/authentication/presentation/widget/loading_column.dart';

class UserDetail extends StatefulWidget {
  final String user;
  const UserDetail({Key? key, required this.user}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  void initState() {
    super.initState();
    // final String userId = ModalRoute.of(context)!.settings.arguments as String;
    final userId = widget.user;
    getUser(userId);
  }

  void getUser(String userId) {
    // final String userId = widget.id;

    context.read<AuthenticationBloc>().add(GetSingleUserEvent(id: userId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<AuthenticationBloc>().add(const GetUserEvent());
                  Navigator.pop(context); // Close the current screen
                  // Navigator.pushNamed(
                  //     context, '/home'); // Navigate to home screen
                },
              ),
              title: const Text("User detail"),
            ),
            body: state is GettingUsers
                ? const LoadingColumn(message: "Getting Single User")
                : state is SingleUserLoaded
                    ? ListView.builder(
                        itemCount: state.user.length,
                        itemBuilder: (context, index) {
                          final user = state.user[index];
                          return Column(children: [
                            Image.network(user.avatar,fit: BoxFit.cover),
                            Text(user.name,style:const TextStyle(
                              fontSize: 20,fontWeight: FontWeight.w700
                            ),),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(user.article,style: const TextStyle(fontFamily: AutofillHints.streetAddressLevel1,fontWeight: FontWeight.w200),),
                            )
                          ]);
                        })
                    : const Text("not getting user"));
      },
    );
  }
}
