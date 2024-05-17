import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'upload.dart';
import 'auth_service.dart';

class SignUp extends StatefulWidget {
  final VoidCallback showLogin;
  const SignUp({Key? key, required this.showLogin}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  bool passwordVisible = true;
  bool confirmPassVisible = true;

  bool confirmPassword() {
    return _password.text.trim() == _confirm.text.trim();
  }

  void signupfunc(BuildContext context) async {
    AuthService authService = AuthService();
    if (confirmPassword()) {
      bool signUpSuccess = await authService.signUp(_email.text.trim(), _password.text.trim());
      if (signUpSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up successful!'),
            duration: Duration(seconds: 3),
          ),
        );
        // Navigate to the UploadDataPage when sign up is successful
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadDataPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign up failed. Please try again.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              height: 230,
              child: Column(
                children: [
                  Image.asset('images/sign.png', height: 300),
                  SizedBox(height: 20),
                  Text(
                    'Create Your Account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  )
                ],
              ),
            ),
            SizedBox(height: 200), // Adjusted padding to move elements down by 50 collectively
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    width: 340,
                    child: TextField(
                      controller: _email,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFf3f3f3),
                        prefixIcon: Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 340,
                    child: TextField(
                      controller: _password,
                      obscureText: passwordVisible,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFf3f3f3),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye),
                        ),
                        prefixIcon: Icon(CupertinoIcons.lock),
                        labelText: 'Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: 340,
                    child: TextField(
                      controller: _confirm,
                      obscureText: confirmPassVisible, // Use confirmPassVisible here
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFf3f3f3),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              confirmPassVisible = !confirmPassVisible; // Update confirmPassVisible
                            });
                          },
                          icon: Icon(confirmPassVisible ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye),
                        ),
                        prefixIcon: Icon(CupertinoIcons.lock),
                        labelText: 'Confirm Password',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => signupfunc(context), // Use a lambda to pass the context
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                side: BorderSide(color: Color(0xFF0F67FE), width: 2),
                backgroundColor: Color(0xFF0F67FE),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),

            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account ?",
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: widget.showLogin,
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.red[700], fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
