import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_test/screens/home.dart';
import 'package:firebase_auth_test/screens/register_screen.dart';
import 'package:firebase_auth_test/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginSreen extends StatefulWidget {
  LoginSreen({super.key});

  @override
  State<LoginSreen> createState() => _LoginSreenState();
}

class _LoginSreenState extends State<LoginSreen> {
  bool loading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
                labelText: 'Email', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(
                labelText: 'Password', border: OutlineInputBorder()),
          ),
          SizedBox(height: 10),
          loading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });

                    if (emailController.text == '' ||
                        passwordController.text == '') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('All field required'),
                          backgroundColor: Colors.red));
                    } else {
                      User? result = await AuthService().login(
                          emailController.text,
                          passwordController.text,
                          context);
                      if (result != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                            (route) => false);
                      } else {
                        debugPrint('Faild');
                      }
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  child: Text('Login')),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('Not Registered? Create an Account')),
        ],
      ),
    );
  }
}
