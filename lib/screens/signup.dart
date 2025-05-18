import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'booklist.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  String? _error;
  bool _loading = false;

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

  void _signup() async {
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

    final user = await _authService.signUp(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    setState(() {
      _loading = false;
    });

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful! Please log in now.')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
        //MaterialPageRoute(builder: (_) => BookListScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed. Try again.')),
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Sign Up',
        style: TextStyle(
                           color: Theme.of(context).colorScheme.primary,
                           fontWeight: FontWeight.bold,
                             ),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
                    color: Theme.of(context).colorScheme.primary, // back arrow color
                    ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/books12.jpg"), // <-- Your image
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                        onPressed: _signup,
                        child: const Text('Sign Up'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
