import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:industry/core/services/injection_container.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:industry/src/features/authentication/presentation/views/home_screen.dart';
import 'package:industry/src/features/authentication/presentation/views/user_detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init(); //we are injection at the start of the application of our dependency
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthenticationBloc>(),
      child: MaterialApp(
          title: 'Blog App',
          initialRoute: '/',
          routes: {
            '/':(context)=>const HomeScreen(),
            // '/users': (context) => const UserDetail(),
          },
          // onUnknownRoute: (settings) {
          //   return MaterialPageRoute(
          //     builder: (context) => Text(
          //         "not found"), // You can create a custom NotFoundScreen widget
          //   );
          // },
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
       

          ),
    );
  }
}


