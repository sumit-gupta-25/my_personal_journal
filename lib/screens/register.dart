import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({super.key});

  @override
  MyRegisterState createState() => MyRegisterState();
}

class MyRegisterState extends State<MyRegister> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // Background Image
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/register.png'),
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
                // Title section
                Positioned(
                  left: 35,
                  top: 30,
                  child: const Text(
                    'Create\nAccount',
                    style: TextStyle(
                      color: Color(0xFFF8F8F8),
                      fontSize: 33,
                    ),
                  ),
                ),

                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * 0.28,
                      left: 35,
                      right: 35,
                    ),
                    child: Column(
                      children: [
                        // Name field
                        TextField(
                          controller: _nameTextController,
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
                            hintText: "Name",
                            hintStyle:
                                const TextStyle(color: Color(0xFFF8F8F8)),
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color(0xFFF8F8F8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Email field
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

                        // Password field
                        TextField(
                          controller: _passwordTextController,
                          obscureText: true,
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
                            hintText: "Password",
                            hintStyle:
                                const TextStyle(color: Color(0xFFF8F8F8)),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color(0xFFF8F8F8),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign Up',
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
                                onPressed: () {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                    email: _emailTextController.text.trim(),
                                    password:
                                        _passwordTextController.text.trim(),
                                  )
                                      .then((value) {
                                    Navigator.pushNamed(context, 'home');
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Sign In link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },
                            child: const Text(
                              'Sign In',
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
