import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  MyLoginState createState() => MyLoginState();
}

class MyLoginState extends State<MyLogin> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Stack(
              children: [
                // Top Title
                Positioned(
                  left: 35,
                  top: 130,
                  child: const Text(
                    'Welcome\nBack',
                    style: TextStyle(color: Color(0xFFF8F8F8), fontSize: 33),
                  ),
                ),

                // Form Section
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.50,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        // Email
                        TextField(
                          controller: _emailTextController,
                          style: const TextStyle(color: Color(0xFFF8F8F8)),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFF8F8F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.brown),
                            ),
                            hintText: "Email",
                            hintStyle:
                                const TextStyle(color: Color(0xFFF8F8F8)),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color(0xFFF8F8F8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Password
                        TextField(
                          controller: _passwordTextController,
                          style: const TextStyle(color: Color(0xFFF8F8F8)),
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Color(0xFFF8F8F8)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.brown),
                            ),
                            hintText: "Password",
                            hintStyle:
                                const TextStyle(color: Color(0xFFF8F8F8)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFF8F8F8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Error message
                        if (_errorMessage.isNotEmpty)
                          Text(
                            _errorMessage,
                            style: const TextStyle(color: Colors.red),
                          ),

                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Color(0xFFF8F8F8),
                                fontSize: 27,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.brown,
                              child: IconButton(
                                color: const Color(0xFFF8F8F8),
                                icon: const Icon(Icons.arrow_forward),
                                onPressed: () async {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                      email: _emailTextController.text.trim(),
                                      password:
                                          _passwordTextController.text.trim(),
                                    );

                                    if (mounted) {
                                      Navigator.pushNamed(context, 'home');
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      _errorMessage =
                                          "Login failed: ${e.message}";
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Sign Up Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'register');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Color(0xFFF8F8F8),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
