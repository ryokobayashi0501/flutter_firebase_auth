import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_user_auth/screen/home.dart';
import 'package:flutter_simple_user_auth/services/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email="", password="";

  TextEditingController emailcontroller = new TextEditingController(); //A controller for obtaining and managing input form (TextField) values.
  TextEditingController passwordcontroller = new TextEditingController();

  bool _obscurePassword = true; //Hide password
  bool rememberPassword = true; 
  final _formSignInKey = GlobalKey<FormState>(); //Keys for manipulating Form widgets

  userLogin() async //That will be called when the user clicks the "Login" button
  {
    if (_formSignInKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password); //This is the code that performs the login with Firebase Authentication.

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar( //Display a message in a pop-up at the bottom of the screen
            content: Text(
              "Log in Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } on FirebaseAuthException catch (e) {
        // Always show the same message when it fails
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Email address or password is incorrect", // Hide details from users
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );

        // For more details, see the debug log for developers.
        debugPrint('FirebaseAuthException: ${e.code} / ${e.message}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
             key: _formSignInKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign In', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
                TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                
                  controller: emailcontroller,
                              
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'Enter Email',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12, // Default border color
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            
                TextFormField(
                  obscureText: _obscurePassword,
                  obscuringCharacter: '*',
                  validator: (value){
                    if(value == null || value.isEmpty)
                    {
                      return 'Please enter Password';
                    }
                    return null;
                  },
                
                  controller: passwordcontroller,
                              
                  decoration: InputDecoration(
                    label: const Text('Password'),
                    hintText: 'Enter Password',
                    hintStyle: const TextStyle(
                      color: Colors.black26,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.black12,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                      ),
                              
                      onPressed: (){
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      }
                      ), 
                    ),
                  ),
            
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
                ElevatedButton(
                  onPressed: () {
                    if (_formSignInKey.currentState!.validate() &&
                      rememberPassword) {
                      setState(() {
                        email = emailcontroller.text;
                        password = passwordcontroller.text;
                      });
                            
                      userLogin();
                    } else if (!rememberPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Please agree to the processing of personal data')),
                      );
                    }
                  }, 
                  child: Text('Sign In')
                ),
                SizedBox(height: 16),
                Text('Sign in with'),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AuthMethods().signInWithGoogle(context);
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
      ),
    );
  }
}
