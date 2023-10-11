import 'package:mcbike/services/login_service.dart';
import '../pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginService _loginService =
      LoginService(baseUrl: "https://192.168.56.1:5000/api/login");
  final _formKey = GlobalKey<FormState>();
  String loginResultMessage = '';
  bool authorized = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _usernameController,
                  decoration:
                      const InputDecoration(labelText: 'Insert username'),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration:
                      const InputDecoration(labelText: 'Insert password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else if (value.length < 6) {
                      return 'Password should be at least 6 characters';
                    }
                    return null;
                  },
                ),
              ),
              Text(
                loginResultMessage,
                style: TextStyle(
                  color: authorized ? Colors.green : Colors.red,
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    authorized = await _loginService.login(
                        _usernameController.text, _passwordController.text);
                    if (authorized) {
                      setState(() {
                        loginResultMessage = 'Login Successful!';
                      });
                    } else {
                      setState(() {
                        loginResultMessage = 'Login Failed. Please try again.';
                      });
                    }
                  }
                },
                child: const Text('Login'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text('Don\'t have an Account?')),
            ],
          ),
        ),
      ),
    );
  }
}
