import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class AddUserDialog extends StatelessWidget {
  AddUserDialog({required this.nameController, super.key});
  final TextEditingController nameController;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "username"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    context.read<AuthenticationBloc>().add(CreateUserEvent(
                        createdAt: DateTime.now().toString(),
                        name: name,
                        avatar:
                            "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/818.jpg"));
                    Navigator.of(context).pop();
                  },
                  child: const Text("Create User"))
            ],
          ),
        ),
      ),
    );
  }
}
