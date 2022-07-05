import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:warikan_photo/main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          // If the user is already signed-in, use it as initial data
          initialData: FirebaseAuth.instance.currentUser,
          builder: (context, snapshot) {
            // User is not signed in
            if (!snapshot.hasData) {
              return SignInScreen(providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(
                  clientId:
                      '449682153173-kqg4t3ash2hqr6vd7670fe9rb11j4a9m.apps.googleusercontent.com',
                ),
              ]);
            }

            // Render your application if authenticated
            return MyApp();
          },
        );
      },
    );
  }
}
