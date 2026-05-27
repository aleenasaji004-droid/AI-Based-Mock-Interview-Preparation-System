// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mock_interview/register.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
//
// void main() {
//   runApp( mylogin());
// }
//
// class mylogin extends StatelessWidget {
//   const mylogin({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyLoginPage(title: 'IP Page'),
//     );
//   }
// }
// class MyLoginPage extends StatefulWidget {
//   const MyLoginPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<MyLoginPage> createState() => _MyLoginPageState();
// }
//
// class _MyLoginPageState extends State<MyLoginPage> {
//   final TextEditingController _usernametextController = TextEditingController();
//   final TextEditingController _passwordtextController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFF3FF),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 100),
//               const Text(
//                 "Login Page",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0047AB),
//                 ),
//               ),
//               const SizedBox(height: 40),
//               TextField(
//                 controller: _usernametextController,
//                 decoration: const InputDecoration(
//                   labelText: "Email ID",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 controller: _passwordtextController,
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: "Password",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _sendData,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                   ),
//                   child: const Text("Login", style: TextStyle(fontSize: 16)),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Register: ",
//                     style: TextStyle(color: Colors.black87),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const RegisterPage()),
//                       );
//                     },
//                     child: const Text(
//                       "Register",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//
//
//                   ),
//                 ],
//
//               ),
//               const SizedBox(height: 20),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Forgot Password: ",
//                     style: TextStyle(color: Colors.black87),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigator.push(
//                       //   context,
//                       //   MaterialPageRoute(builder: (context) => const RegisterPage()),
//                       // );
//                     },
//                     child: const Text(
//                       "Click Here",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.orange,
//                       ),
//                     ),
//
//
//                   ),
//                 ],
//
//               ),
//
//
//             ],
//               ),
//
//           ),
//         ),
//
//     );
//   }
//
//   Future<void> _sendData() async {
//     String uname = _usernametextController.text.trim();
//     String password = _passwordtextController.text.trim();
//
//     if (uname.isEmpty || password.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please enter both email and password');
//       return;
//     }
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? url = sh.getString('url');
//
//     if (url == null || url.isEmpty) {
//       Fluttertoast.showToast(msg: 'Server URL not configured');
//       return;
//     }
//
//     final urls = Uri.parse('$url/User_login/');
//     try {
//       final response = await http.post(
//         urls,
//         body: {'Username': uname, 'Password': password},
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         String status = data['status'].toString();
//         String message = data['message'].toString();
//         String type = data['type'].toString();
//
//         Fluttertoast.showToast(msg: message);
//
//         if (status == 'ok') {
//           String lid = data['lid'].toString();
//           await sh.setString("lid", lid);
//
//
//
//           // String oid = data['oid'].toString();
//           // await sh.setString("oid", oid);
//
//           if(type == "user"){
//            Navigator.push(context, MaterialPageRoute(builder: (context) => userHomePAge(),));
//           }
//           // else if (type == "old student"){
//           //   Navigator.push(context, MaterialPageRoute(builder: (context) => oldstd_homePage(),));
//           //
//           // }
//
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Server error: ${response.statusCode}');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//     }
//   }
// }
//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mock_interview/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() {
  runApp(MyLogin());
}

class MyLogin extends StatelessWidget {
  const MyLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyLoginPage(title: 'IP Page'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});
  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final TextEditingController _usernametextController = TextEditingController();
  final TextEditingController _passwordtextController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF667eea),
                  Color(0xFF764ba2),
                ],
              ),
            ),
          ),

          // Background pattern
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: _isLoading
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Logging in...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    // Welcome text
                    const Text(
                      "Welcome Back!",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Sign in to continue",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),

                    const SizedBox(height: 50),

                    // Login card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Email field
                          TextField(
                            controller: _usernametextController,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Email Address",
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.deepPurple[300],
                                size: 22,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Password field
                          TextField(
                            controller: _passwordtextController,
                            obscureText: _obscurePassword,
                            style: const TextStyle(fontSize: 15),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_outline,
                                color: Colors.deepPurple[300],
                                size: 22,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey[600],
                                  size: 22,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[100],
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          // // Forgot password
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Fluttertoast.showToast(
                          //         msg: "Password reset link sent to your email",
                          //       );
                          //     },
                          //     style: TextButton.styleFrom(
                          //       padding: EdgeInsets.zero,
                          //     ),
                          //     child: Text(
                          //       "Forgot Password?",
                          //       style: TextStyle(
                          //         color: Colors.deepPurple[400],
                          //         fontSize: 13,
                          //         fontWeight: FontWeight.w600,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                          const SizedBox(height: 25),

                          // Login button
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: _sendData,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[400],
                                foregroundColor: Colors.white,
                                elevation: 5,
                                shadowColor: Colors.deepPurple.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text(
                                "SIGN IN",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // Register link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Colors.deepPurple[400],
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Demo credentials card
                    // Container(
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white.withOpacity(0.15),
                    //     borderRadius: BorderRadius.circular(15),
                    //     border: Border.all(
                    //       color: Colors.white.withOpacity(0.3),
                    //     ),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.all(8),
                    //         decoration: BoxDecoration(
                    //           color: Colors.white.withOpacity(0.2),
                    //           shape: BoxShape.circle,
                    //         ),
                    //         child: const Icon(
                    //           Icons.info_outline,
                    //           color: Colors.white,
                    //           size: 18,
                    //         ),
                    //       ),
                    //       const SizedBox(width: 12),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             // const Text(
                    //             //   "Demo Credentials",
                    //             //   style: TextStyle(
                    //             //     color: Colors.white,
                    //             //     fontSize: 13,
                    //             //     fontWeight: FontWeight.bold,
                    //             //   ),
                    //             // ),
                    //             const SizedBox(height: 4),
                    //             // Text(
                    //             //   "Email: user@example.com\nPassword: password123",
                    //             //   style: TextStyle(
                    //             //     color: Colors.white.withOpacity(0.8),
                    //             //     fontSize: 12,
                    //             //     height: 1.4,
                    //             //   ),
                    //             // ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendData() async {
    String uname = _usernametextController.text.trim();
    String password = _passwordtextController.text.trim();

    if (uname.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter both email and password');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    SharedPreferences sh = await SharedPreferences.getInstance();
    String? url = sh.getString('url');

    if (url == null || url.isEmpty) {
      Fluttertoast.showToast(msg: 'Server URL not configured');
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final urls = Uri.parse('$url/User_login/');
    try {
      final response = await http.post(
        urls,
        body: {'Username': uname, 'Password': password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String status = data['status'].toString();
        String message = data['message'].toString();
        String type = data['type'].toString();

        Fluttertoast.showToast(msg: message);

        if (status == 'ok') {
          String lid = data['lid'].toString();
          await sh.setString("lid", lid);

          if (type == "user") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => userHomePAge()),
            );
          }
        }
      } else {
        Fluttertoast.showToast(msg: 'Server error: ${response.statusCode}');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}