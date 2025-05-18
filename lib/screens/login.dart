import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'booklist.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _loading = false;
  String? _error;

   @override
    void initState() {
      super.initState();
      _emailController.addListener(_clearErrorOnInput);
      _passwordController.addListener(_clearErrorOnInput);
    }

    void _clearErrorOnInput() {
      if (_error != null) {
        setState(() {
          _error = null;
        });
      }
    }


  void _login() async {
    final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        setState(() {
          _error = "Email and password cannot be empty.";
        });
        return;
      }

    setState(() {
      _loading = true;
      _error = null;
    });

    final user = await _authService.login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BookListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Check credentials.')),
      );
    }
  }

  @override
    void dispose() {
      _emailController.dispose();
      _passwordController.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/books12.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
               // const SizedBox(height: 0), // Control how far down the title appears
                  Text(
                  'Book Buddy',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary, // Adjust for visibility
                  ),
                ),
                const SizedBox(height: 40), // Space between title and form
                if (_error != null)
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(),
                  ),

                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white70,
                    border: OutlineInputBorder(),
                  ),

                ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text('Login'),
                      ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignupScreen()),
                  ),
                  child: const Text('Don’t have an account? Sign Up'),
                ),
                const SizedBox(height: 150), // Keep some spacing above bottom image
              ],
            ),
          ),
        ),
      ),
    );
  }
}