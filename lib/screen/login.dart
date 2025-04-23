import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              SizedBox(height: 8),

              // 👇 Forget Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgot_password');
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),

              SizedBox(height: 8),
              ElevatedButton(onPressed: () {}, child: Text('Sign In')),
              SizedBox(height: 16),
              Text('Sign in with'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Google login process
                    },
                    child: Image.asset(
                      'assets/logo_google_g_icon.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/signup'),
                child: Text("Don't have an account? Sign up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
