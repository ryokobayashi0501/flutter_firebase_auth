import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_user_auth/screen/home.dart';
import 'package:flutter_simple_user_auth/services/auth.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  bool _obscurePassword = true;
  bool rememberPassword = true;
 
  final _formSignUpKey = GlobalKey<FormState>();

  registration() async {
    if (_formSignUpKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar
        (
          content: Text("Registered Successfully", style: TextStyle(fontSize: 20.0)),
        ));

        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') 
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (
            backgroundColor: Colors.orangeAccent,
            content: Text("Password Provided is too Weak", style: TextStyle(fontSize: 18.0)),
          ));
          
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar
          (
            backgroundColor: Colors.orangeAccent,
            content: Text("Account Already exists", style: TextStyle(fontSize: 18.0)),
          ));
        }
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
            key: _formSignUpKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign Up', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Name';
                    }
                    return null;
                  },
                  controller: namecontroller, //Add this
                  decoration: InputDecoration(
                    label: const Text('Full Name'),
                    hintText: 'Enter Full Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
            
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Email';
                    }
                    return null;
                  },

                  controller: emailcontroller, 
                  //Add this
                  decoration: InputDecoration(
                    label: const Text('Email'),
                    hintText: 'Enter Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black12),
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
            
                SizedBox(height: 16),
            
                ElevatedButton(
                  onPressed: () {
                    if (_formSignUpKey.currentState!.validate() && rememberPassword) {
                      setState(() {
                        email = emailcontroller.text;
                        name = namecontroller.text;
                        password = passwordcontroller.text;
                      });
                      registration();
                    } else if (!rememberPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please agree to the processing of personal data')),
                      );
                    }
                  },
             
                  child: Text('Sign Up')
                ),
            
                SizedBox(height: 16),
                Text('Sign in with'),
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
                  onPressed: () => Navigator.pop(context),
                  child: Text("Already have an account? Login"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}