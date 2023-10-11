import 'package:flutter/material.dart';
import 'package:mcbike/services/user_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String registerResultMessage = '';
  final userService =
      UserService(baseUrl: "https://192.168.56.1:5000/api/user");
  bool succedfullyCreated = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Insert username'),
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username is required';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Insert password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                    //husk at se på password validering i api
                  } else if (value.length < 6) {
                    return 'Password should be at least 6 characters';
                  }
                  return null;
                },
              ),
            ),
            Text(registerResultMessage,
                style: TextStyle(
                  color: succedfullyCreated ? Colors.green : Colors.red,
                )),
            ElevatedButton(
              onPressed: () async {
                final isValid = _formKey.currentState!.validate();
                if (isValid) {
                  succedfullyCreated = await userService.createUser(
                      _usernameController.text, _passwordController.text);
                  if (succedfullyCreated) {
                    setState(() {
                      registerResultMessage = 'Registration Successful!';
                    });
                  } else {
                    setState(() {
                      registerResultMessage = 'Registration failed!';
                    });
                  }
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
