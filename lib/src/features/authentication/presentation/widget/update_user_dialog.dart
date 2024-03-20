import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/src/features/authentication/domain/entities/user.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';

class UpdateUserDialog extends StatelessWidget {
  UpdateUserDialog({required this.user, super.key});
  final User user;
  TextEditingController nameController = TextEditingController();
  TextEditingController articleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = user.name;
    articleController.text = user.article;

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Enter username",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 30),
                ],
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: "username",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Update article",textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.w700),),
                  SizedBox(height: 30),
                ],
              ),
              TextField(
                controller: articleController,
                maxLines: 10, // Or maxLines: 0 for expandable
                keyboardType: TextInputType.multiline, // Enable multiline input
                decoration: InputDecoration(
                  hintText: "Enter your text here...",
                  border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final article = articleController.text.trim();
                    context.read<AuthenticationBloc>().add(UpdateUserEvent(
                          id: user.id,
                          createdAt: DateTime.now().toString(),
                          name: name,
                          article: article,
                          avatar:
                              "https://pbs.twimg.com/profile_images/1611866975529050114/AMr20AxH_400x400.jpg",
                        ));
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: const Text(
                    "Update User",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
