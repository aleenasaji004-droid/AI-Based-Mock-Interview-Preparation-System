// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'login.dart';
//
//
//
//
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ip(title: 'IP Page'),
//     );
//   }
// }
//
// class ip extends StatefulWidget {
//   const ip({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ip> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<ip> {
//   final TextEditingController _textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//
//               TextField(
//                 controller: _textController,
//                 decoration: const InputDecoration(
//                   labelText: 'Enter Your Ip Address',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   _send_data();
//                 },
//                 child: const Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _send_data() async{
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     sh.setString('url', 'http://${_textController.text}:8000/myapp');
//     sh.setString('img_url', 'http://${_textController.text}:8000');
//     sh.setString('img_url2', 'http://${_textController.text}:8000/media/');
//     Navigator.push(context, MaterialPageRoute(
//       builder: (context) =>MyLoginPage(title: '',),));
//
//   }
//
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IP Configuration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: const ip(title: 'Server Configuration'),
    );
  }
}

class ip extends StatefulWidget {
  const ip({super.key, required this.title});

  final String title;

  @override
  State<ip> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ip> {
  final TextEditingController _textController = TextEditingController();
  bool _isLoading = false;

  // Elegant color scheme
  static const Color primaryPurple = Color(0xFF6C5CE7);
  static const Color secondaryPurple = Color(0xFF272366);
  static const Color backgroundColor = Color(0xFFF8F9FF);
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryPurple.withOpacity(0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -40,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryPurple.withOpacity(0.1),
              ),
            ),
          ),

          SafeArea(
            child: _isLoading
                ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryPurple),
                    strokeWidth: 3,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Connecting to server...",
                    style: TextStyle(
                      color: primaryPurple,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),

                    // Logo/Icon Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: primaryPurple.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.settings_ethernet_rounded,
                        size: 70,
                        color: primaryPurple,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Welcome Text
                    const Text(
                      "Server Configuration",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Enter your server IP address to connect",
                      style: TextStyle(
                        fontSize: 15,
                        color: textSecondary,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 40),

                    // Main Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: surfaceColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Label with icon
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primaryPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.dns_rounded,
                                  color: primaryPurple,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                "IP Address",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textPrimary,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // IP Input Field
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: TextFormField(
                              controller: _textController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              decoration: InputDecoration(
                                hintText: "e.g., 192.168.1.100",
                                hintStyle: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 14,
                                ),
                                prefixIcon: Icon(
                                  Icons.computer_rounded,
                                  color: primaryPurple,
                                  size: 22,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Helper text
                          Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              "Enter the IP address of your server",
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary.withOpacity(0.7),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Submit Button with gradient
                          Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [primaryPurple, secondaryPurple],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryPurple.withOpacity(0.3),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _sendData,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.link_rounded, size: 22),
                                  SizedBox(width: 10),
                                  Text(
                                    "Connect to Server",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Info Card

                    const SizedBox(height: 30),

                    // Footer

                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendData() async {
    String ipAddress = _textController.text.trim();

    if (ipAddress.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Please enter IP address',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    // Simple IP validation pattern
    RegExp ipPattern = RegExp(r'^(\d{1,3}\.){3}\d{1,3}$');
    if (!ipPattern.hasMatch(ipAddress)) {
      Fluttertoast.showToast(
        msg: 'Please enter a valid IP address',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      sh.setString('url', 'http://$ipAddress:8000/myapp');
      sh.setString('img_url', 'http://$ipAddress:8000');
      sh.setString('img_url2', 'http://$ipAddress:8000/media/');

      // Simulate network delay for better UX
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyLoginPage(title: ''),
          ),
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error saving configuration',
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// Add this import at the top
