import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _error = null; });
    final box = await Hive.openBox('userBox');
    final usersRaw = box.get('users');
    Map<String, dynamic> users = {};
    if (usersRaw is Map) {
      users = Map<String, dynamic>.from(usersRaw);
    }
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    // Debug print
    print('Users in box: $users');
    if (users.containsKey(email) && users[email]['password'] == password) {
      await box.put('loggedInEmail', email);
      setState(() => _loading = false);
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/tasks');
    } else {
      setState(() {
        _loading = false;
        _error = 'Invalid email or password';
      });
    }
  }

  void _goToRegister() {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Login', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => (value == null || value.isEmpty || !value.contains('@')) ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) => (value == null || value.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                if (_error != null) ...[
                  const SizedBox(height: 12),
                  Text(_error!, style: const TextStyle(color: Colors.red)),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    child: _loading ? const CircularProgressIndicator() : const Text('Login'),
                  ),
                ),
                TextButton(
                  onPressed: _goToRegister,
                  child: const Text('Don\'t have an account? Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 