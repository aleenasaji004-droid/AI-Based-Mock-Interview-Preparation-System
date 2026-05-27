// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:library_management_system/view_reply.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class SendFeedback extends StatefulWidget {
//   const SendFeedback({super.key});
//
//   @override
//   State<SendFeedback> createState() => _CompState();
// }
//
// class _CompState extends State<SendFeedback> {
//   TextEditingController complaint = TextEditingController();
//
//   Future<void> complaints() async {
//     // ---------------- VALIDATION ----------------
//     if (complaint.text.trim().isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Feedback field cannot be empty!",
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//       return;
//     }
//
//     SharedPreferences prefer = await SharedPreferences.getInstance();
//     String? url = prefer.getString('url');
//     String? lid = prefer.getString('lid');
//
//     final res = await http.post(
//       Uri.parse('$url/send_feedback/'),
//       body: {
//         'feedback': complaint.text.trim().toString(),
//         'lid': lid
//       },
//     );
//
//     // ---------------- RESPONSE ----------------
//     if (res.statusCode == 200) {
//       final data = jsonDecode(res.body);
//       print(data['key']);
//
//       Fluttertoast.showToast(
//         msg: "Feedback submitted successfully!",
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//       );
//
//       complaint.clear();
//     } else {
//       Fluttertoast.showToast(
//         msg: "Failed to submit Feedback!",
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Feedback Page',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         elevation: 6,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blueAccent, Colors.lightBlue],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         ),
//       ),
//
//       body: Container(
//         width: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.white, Color(0xFFE3F2FD)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Center(
//             child: SingleChildScrollView(
//               child: Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16)),
//                 elevation: 8,
//                 shadowColor: Colors.blue.withOpacity(0.3),
//                 child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         const Icon(Icons.feedback_outlined,
//                             size: 70, color: Colors.blueAccent),
//                         const SizedBox(height: 10),
//
//                         const Text(
//                           'Submit Your Feedback',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blueAccent,
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         const Text(
//                           'We value your feedback. Please describe your issue below.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 15,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//
//                         TextFormField(
//                           controller: complaint,
//                           maxLines: 5,
//                           decoration: InputDecoration(
//                             labelText: 'Feedback',
//                             labelStyle: const TextStyle(color: Colors.blueGrey),
//                             hintText: 'Enter your Feedback...',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Colors.blueAccent, width: 2),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//
//                         // Send Complaint Button
//                         SizedBox(
//                           width: double.infinity,
//                           child: ElevatedButton.icon(
//                             onPressed: complaints,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blueAccent,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 4,
//                             ),
//                             icon: const Icon(Icons.send, color: Colors.white),
//                             label: const Text(
//                               'Send Feedback',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const SizedBox(height: 20),
//
//                         // View Replies Button
//
//                       ],
//                     )
//
//
//                 ),
//               ),
//             ),
//           ),
//
//         ),
//
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SendFeedback extends StatefulWidget {
  const SendFeedback({super.key});

  @override
  State<SendFeedback> createState() => _CompState();
}

class _CompState extends State<SendFeedback> {
  TextEditingController complaint = TextEditingController();
  bool _isLoading = false;

  // Consistent color scheme matching complaint page
  static const Color primaryPurple = Color(0xFF5E35B1); // Deep Purple
  static const Color accentCoral = Color(0xFFFF6B6B); // Coral
  static const Color backgroundColor = Color(0xFFF8F9FF); // Soft Lavender
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  Future<void> complaints() async {
    // ---------------- VALIDATION ----------------
    if (complaint.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Feedback field cannot be empty!",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    SharedPreferences prefer = await SharedPreferences.getInstance();
    String? url = prefer.getString('url');
    String? lid = prefer.getString('lid');

    try {
      final res = await http.post(
        Uri.parse('$url/send_feedback/'),
        body: {
          'feedback': complaint.text.trim().toString(),
          'lid': lid
        },
      );

      // ---------------- RESPONSE ----------------
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        Fluttertoast.showToast(
          msg: "Feedback submitted successfully!",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        complaint.clear();
      } else {
        Fluttertoast.showToast(
          msg: "Failed to submit Feedback!",
          backgroundColor: accentCoral,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: Failed to connect to server",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryPurple,
        foregroundColor: primaryPurple,
        title: const Text(
          'Feedback',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: primaryPurple.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(primaryPurple),
              strokeWidth: 3,
            ),
            const SizedBox(height: 20),
            Text(
              "Submitting your feedback...",
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
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Elegant Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryPurple, primaryPurple.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: primaryPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.feedback_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We Value Your Feedback",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your opinion helps us improve",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Feedback Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: surfaceColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
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
                          Icons.edit_note_rounded,
                          color: primaryPurple,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        "Your Feedback",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Feedback Input
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TextFormField(
                      controller: complaint,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Write your feedback here...",
                        hintStyle: TextStyle(
                          color: textSecondary.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Character count with elegant design
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "${complaint.text.length} characters",
                        style: TextStyle(
                          fontSize: 12,
                          color: primaryPurple,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Submit Button with elegant gradient
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [primaryPurple, primaryPurple.withOpacity(0.8)],
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
                      onPressed: complaints,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.send_rounded, size: 22),
                          const SizedBox(width: 10),
                          Text(
                            "Send Feedback",
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

            const SizedBox(height: 24),

            // Elegant info card (matching complaint page style)

            const SizedBox(height: 30),

            // Footer

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}