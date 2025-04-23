import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              TextField(decoration: InputDecoration(labelText: 'Full Name')),
              TextField(decoration: InputDecoration(labelText: 'Email')),
              TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              SizedBox(height: 16),
              ElevatedButton(onPressed: () {}, child: Text('Sign Up')),
              SizedBox(height: 16),
              Text('Sign in with'),
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
                onPressed: () => Navigator.pop(context),
                child: Text("Already have an account? Login"),
              )
            ],
          ),
        ),
      ),
    );
  }
}