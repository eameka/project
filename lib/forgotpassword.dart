import 'package:ecowaste/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({
    super.key,
  });
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mailController = TextEditingController();
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter E-mail for password reset link'),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: _mailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _auth.sendPasswordResetLink(_mailController.text);
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.success,
                    text: 'Reset Link Sent Successfully!',
                  );
                  Navigator.pop(context);
                },
                child: const Text('Send Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
