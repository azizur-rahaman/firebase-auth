import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/screens/home.dart';
import 'package:firebase_auth_test/screens/login_screen.dart';
import 'package:firebase_auth_test/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                  labelText: 'Confirm Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      if (emailController.text == '' ||
                          passwordController.text == '' ||
                          confirmPasswordController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('All fields are required!'),
                                backgroundColor: Colors.red));
                      } else if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Password did not match !')));
                      } else {
                        User? result = await AuthService().register(
                            emailController.text,
                            passwordController.text,
                            context);
                        if (result != null) {
                          print('Success');

                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (contex) => Home()),
                              (route) => false);
                        } else {
                          debugPrint('Sorry!');
                        }
                      }

                      setState(() {
                        loading = false;
                      });
                    },
                    child: const Text('Register')),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginSreen()));
                },
                child: const Text('Already have an account? Login')),
            loading
                ? CircularProgressIndicator()
                : SignInButton(Buttons.Google, text: 'Continue with Google',
                    onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    User? userCredential =
                        await AuthService().signInWithGoogle();

                    setState(() {
                      loading = false;
                    });
                  }),
          ],
        ),
      ),
    );
  }
}
