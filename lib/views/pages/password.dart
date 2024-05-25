
import 'package:flutter/material.dart';
import '../../utils/app_constant.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  String? error;
  final TextEditingController _passwordController = TextEditingController();

  void _validatePassword(String value) {
    setState(() {
      if (value == Password.key) {
        Navigator.of(context).pop();
      } else {
        error = "Parol notog'ri";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Password"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _passwordController,
                style: const TextStyle(fontSize: 20),
                keyboardType: TextInputType.number,
                maxLength: 4,
                onSubmitted: _validatePassword,
                decoration: InputDecoration(
                  errorText: error,
                  labelText: "Your password",
                  border: const OutlineInputBorder(),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  _validatePassword(_passwordController.text);
                },
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
