// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mock_interview/view_reply.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
//
// void main() {
//   runApp(const Send_complaint());
// }
//
// class Send_complaint extends StatelessWidget {
//   const Send_complaint({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Send Complaint',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const Send_complaintPage(title: 'Send Complaint'),
//     );
//   }
// }
//
// class Send_complaintPage extends StatefulWidget {
//   const Send_complaintPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<Send_complaintPage> createState() => Send_complaintPageState();
// }
//
// class Send_complaintPageState extends State<Send_complaintPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _nametextController = TextEditingController();
//   bool _isLoading = false;
//   List g=[];
//   String? _selectedCompany;
//
// Future<void> getcompany() async {
//   SharedPreferences sh=await SharedPreferences.getInstance();
//    String? a=sh.getString('url');
//    final res= await http.post(Uri.parse('$a/companytocomplaint/'));
//    if(res.statusCode==200){
//      final data=jsonDecode(res.body);
//      setState(() {
//        g=data['data'];
//        print(g);
//      });
//
//
//    }
// }
//   Future<void> _sendData() async {
//     if (!_formKey.currentState!.validate()) {
//       Fluttertoast.showToast(msg: "Please fix errors in the form");
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       String name = _nametextController.text.trim();
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? url = sh.getString('url');
//       String lid = sh.getString('lid') ?? '';
//       // String sid = sh.getString('sid') ?? '';
//
//
//       if (url == null) {
//         Fluttertoast.showToast(msg: "Server URL not found.");
//         return;
//       }
//
//       final uri = Uri.parse('$url/send_complaint/');
//       var request = http.MultipartRequest('POST', uri);
//
//       request.fields['complaint'] = name;
//       request.fields['lid'] = lid;
//       request.fields['company'] = _selectedCompany!;
//       // request.fields['sid'] = sid;
//
//
//
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200) {
//         if (data['status'] == 'ok') {
//           Fluttertoast.showToast(msg: "Submitted successfully.");
//           _clearForm();
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => const userHomePAge()),
//           );
//         } else {
//           Fluttertoast.showToast(
//               msg: "Submission failed: ${data['message'] ?? 'Unknown error'}");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error sending data: $e");
//       Fluttertoast.showToast(msg: "Error: ${e.toString()}");
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   void _clearForm() {
//     _nametextController.clear();
//     setState(() {
//
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userHomePAge()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(widget.title),
//           centerTitle: true,
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           foregroundColor: Colors.white,
//         ),
//         body: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'Select company',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.account_balance_rounded),
//                   ),
//                   value: _selectedCompany,
//                   items: g.map((vehicle) {
//                     return DropdownMenuItem<String>(
//                       value: vehicle['id'].toString(),
//                       child: Text(vehicle['name'] ?? 'N/A'),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       _selectedCompany = newValue;
//                     });
//                   },
//                   validator: (value) => value == null ? 'Please select a vehicle' : null,
//                 ),
//                 TextFormField(
//                   controller: _nametextController,
//                   decoration: const InputDecoration(
//                     labelText: 'Send Complaint',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.comment),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Please enter Complaint';
//                     }
//                     if (value.trim().length < 2) {
//                       return 'Field must be at least 2 characters';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 30),
//
//                 SizedBox(
//                   width: double.infinity,
//                   height: 50,
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _sendData,
//                     child: _isLoading
//                         ? const Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           width: 20,
//                           height: 20,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor:
//                             AlwaysStoppedAnimation<Color>(
//                                 Colors.white),
//                           ),
//                         ),
//                         SizedBox(width: 10),
//                         Text("Submitting..."),
//                       ],
//                     )
//                         : const Text("Submit"),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => cstd_viewComplaintsPage(title: '')),
//                     );
//                   },
//                   child: const Text('View Reply'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _nametextController.dispose();
//     super.dispose();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getcompany();
//
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:mock_interview/view_reply.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
//
// void main() {
//   runApp(const Send_complaint());
// }
//
// class Send_complaint extends StatelessWidget {
//   const Send_complaint({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Send Complaint',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         fontFamily: 'Poppins',
//       ),
//       home: const Send_complaintPage(title: 'Send Complaint'),
//     );
//   }
// }
//
// class Send_complaintPage extends StatefulWidget {
//   const Send_complaintPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<Send_complaintPage> createState() => Send_complaintPageState();
// }
//
// class Send_complaintPageState extends State<Send_complaintPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final TextEditingController _complaintController = TextEditingController();
//   bool _isLoading = false;
//   List companies = [];
//   String? _selectedCompany;
//
//   // Elegant color scheme
//   static const Color primaryColor = Color(0xFF5E35B1); // Deep Purple
//   static const Color accentColor = Color(0xFFFF6B6B); // Coral
//   static const Color backgroundColor = Color(0xFFF8F9FF); // Soft Lavender
//   static const Color surfaceColor = Colors.white;
//   static const Color textPrimary = Color(0xFF2D3436);
//   static const Color textSecondary = Color(0xFF636E72);
//
//   Future<void> getcompany() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String? a = sh.getString('url');
//     try {
//       final res = await http.post(Uri.parse('$a/companytocomplaint/'));
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body);
//         setState(() {
//           companies = data['data'];
//         });
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Failed to load companies");
//     }
//   }
//
//   Future<void> _sendData() async {
//     if (!_formKey.currentState!.validate()) {
//       Fluttertoast.showToast(msg: "Please fix errors in the form");
//       return;
//     }
//
//     setState(() => _isLoading = true);
//
//     try {
//       String complaint = _complaintController.text.trim();
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? url = sh.getString('url');
//       String lid = sh.getString('lid') ?? '';
//
//       if (url == null) {
//         Fluttertoast.showToast(msg: "Server URL not found.");
//         setState(() => _isLoading = false);
//         return;
//       }
//
//       final uri = Uri.parse('$url/send_complaint/');
//       var request = http.MultipartRequest('POST', uri);
//
//       request.fields['complaint'] = complaint;
//       request.fields['lid'] = lid;
//       request.fields['company'] = _selectedCompany!;
//
//       var response = await request.send();
//       var respStr = await response.stream.bytesToString();
//       var data = jsonDecode(respStr);
//
//       if (response.statusCode == 200 && data['status'] == 'ok') {
//         Fluttertoast.showToast(msg: "Complaint submitted successfully");
//         _clearForm();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userHomePAge()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: data['message'] ?? 'Submission failed');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Network error. Please try again.");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   void _clearForm() {
//     _complaintController.clear();
//     setState(() => _selectedCompany = null);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getcompany();
//   }
//
//   @override
//   void dispose() {
//     _complaintController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userHomePAge()),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           foregroundColor: primaryColor,
//           title: Text(
//             widget.title,
//             style: TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.w600,
//               color: primaryColor,
//               letterSpacing: 0.5,
//             ),
//           ),
//           centerTitle: true,
//           leading: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: primaryColor.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: primaryColor),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ),
//         ),
//         body: _isLoading
//             ? Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                 strokeWidth: 3,
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 "Submitting your complaint...",
//                 style: TextStyle(
//                   color: primaryColor,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//         )
//             : SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Elegant Header
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(30),
//                     boxShadow: [
//                       BoxShadow(
//                         color: primaryColor.withOpacity(0.3),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.support_agent_rounded,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         "We're here to help",
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Your feedback helps us improve",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.white.withOpacity(0.9),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Company Selection Section
//                 Text(
//                   "Select Company",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: textPrimary,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: DropdownButtonFormField<String>(
//                     decoration: InputDecoration(
//                       hintText: "Choose a company",
//                       hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
//                       prefixIcon: Container(
//                         margin: const EdgeInsets.all(12),
//                         child: Icon(Icons.business_center_rounded,
//                             color: primaryColor, size: 22),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(16),
//                         borderSide: BorderSide(color: primaryColor, width: 1),
//                       ),
//                       filled: true,
//                       fillColor: surfaceColor,
//                       contentPadding: const EdgeInsets.symmetric(vertical: 8),
//                     ),
//                     value: _selectedCompany,
//                     items: companies.map((company) {
//                       return DropdownMenuItem<String>(
//                         value: company['id'].toString(),
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 8),
//                           child: Text(
//                             company['name'] ?? 'Unknown',
//                             style: const TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                     onChanged: (String? newValue) {
//                       setState(() => _selectedCompany = newValue);
//                     },
//                     validator: (value) =>
//                     value == null ? 'Please select a company' : null,
//                     icon: Icon(Icons.keyboard_arrow_down_rounded,
//                         color: primaryColor),
//                     dropdownColor: surfaceColor,
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//
//                 const SizedBox(height: 24),
//
//                 // Complaint Section
//                 Text(
//                   "Your Complaint",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: textPrimary,
//                     letterSpacing: 0.3,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         blurRadius: 10,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: TextFormField(
//                     controller: _complaintController,
//                     maxLines: 8,
//                     decoration: InputDecoration(
//                       hintText: "Describe your issue in detail...",
//                       hintStyle: TextStyle(
//                         color: textSecondary.withOpacity(0.5),
//                         fontSize: 14,
//                       ),
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.only(top: 12),
//                         child: Icon(Icons.edit_note_rounded,
//                             color: primaryColor, size: 24),
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide.none,
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                         borderSide: BorderSide(color: primaryColor, width: 1.5),
//                       ),
//                       filled: true,
//                       fillColor: surfaceColor,
//                       contentPadding: const EdgeInsets.all(20),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.trim().isEmpty) {
//                         return 'Please enter your complaint';
//                       }
//                       if (value.trim().length < 10) {
//                         return 'Complaint must be at least 10 characters';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // Character count with elegant design
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: primaryColor.withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Text(
//                       "${_complaintController.text.length}/500",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: primaryColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // Submit Button with elegant gradient
//                 Container(
//                   width: double.infinity,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [primaryColor, primaryColor.withOpacity(0.8)],
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                     ),
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: primaryColor.withOpacity(0.3),
//                         blurRadius: 15,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   child: ElevatedButton(
//                     onPressed: _isLoading ? null : _sendData,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       foregroundColor: Colors.white,
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: _isLoading
//                         ? const SizedBox(
//                       height: 25,
//                       width: 25,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                         color: Colors.white,
//                       ),
//                     )
//                         : Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Icon(Icons.send_rounded, size: 22),
//                         const SizedBox(width: 10),
//                         Text(
//                           "Submit Complaint",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 16),
//
//                 // View Reply Button with elegant outline
//                 Container(
//                   width: double.infinity,
//                   height: 55,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: primaryColor, width: 1.5),
//                   ),
//                   child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => cstd_viewComplaintsPage(title: ''),
//                         ),
//                       );
//                     },
//                     style: TextButton.styleFrom(
//                       foregroundColor: primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.reply_rounded, size: 20),
//                         const SizedBox(width: 8),
//                         const Text(
//                           "View Previous Replies",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Elegant info card
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: accentColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(color: accentColor.withOpacity(0.2)),
//                   ),
//                   child: Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: accentColor.withOpacity(0.2),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           Icons.access_time_rounded,
//                           color: accentColor,
//                           size: 20,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Expanded(
//                         child: Text(
//                           "We typically respond within 24 hours",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: accentColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mock_interview/view_reply.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() {
  runApp(const Send_complaint());
}

class Send_complaint extends StatelessWidget {
  const Send_complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Send Complaint',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: const Send_complaintPage(title: 'Send Complaint'),
    );
  }
}

class Send_complaintPage extends StatefulWidget {
  const Send_complaintPage({super.key, required this.title});

  final String title;

  @override
  State<Send_complaintPage> createState() => Send_complaintPageState();
}

class Send_complaintPageState extends State<Send_complaintPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _complaintController = TextEditingController();
  bool _isLoading = false;
  List companies = [];
  String? _selectedCompany;

  // Professional corporate color scheme
  static const Color primaryBlue = Colors.deepPurple; // Deep navy blue
  static const Color secondaryBlue = Color(0xFF4F0780); // Bright blue
  static const Color accentBlue = Color(0xFF9914BE); // Medium blue
  static const Color surfaceLight = Color(0xFFF8FAFC); // Light gray surface
  static const Color borderColor = Color(0xFFE2E8F0); // Subtle border
  static const Color textPrimary = Color(0xFF0F172A); // Dark slate
  static const Color textSecondary = Color(0xFF475569); // Medium slate
  static const Color successGreen = Color(0xFF10B981); // Success color
  static const Color errorRed = Color(0xFFEF4444); // Error color

  Future<void> getcompany() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? a = sh.getString('url');
    try {
      final res = await http.post(Uri.parse('$a/companytocomplaint/'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          companies = data['data'];
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load companies");
    }
  }

  Future<void> _sendData() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: "Please fix errors in the form");
      return;
    }

    setState(() => _isLoading = true);

    try {
      String complaint = _complaintController.text.trim();

      SharedPreferences sh = await SharedPreferences.getInstance();
      String? url = sh.getString('url');
      String lid = sh.getString('lid') ?? '';

      if (url == null) {
        Fluttertoast.showToast(msg: "Server URL not found.");
        setState(() => _isLoading = false);
        return;
      }

      final uri = Uri.parse('$url/send_complaint/');
      var request = http.MultipartRequest('POST', uri);

      request.fields['complaint'] = complaint;
      request.fields['lid'] = lid;
      request.fields['company'] = _selectedCompany!;

      var response = await request.send();
      var respStr = await response.stream.bytesToString();
      var data = jsonDecode(respStr);

      if (response.statusCode == 200 && data['status'] == 'ok') {
        Fluttertoast.showToast(
          msg: "Complaint submitted successfully",
          backgroundColor: successGreen,
          textColor: Colors.white,
        );
        _clearForm();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const userHomePAge()),
        );
      } else {
        Fluttertoast.showToast(
          msg: data['message'] ?? 'Submission failed',
          backgroundColor: errorRed,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network error. Please try again.",
        backgroundColor: errorRed,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _clearForm() {
    _complaintController.clear();
    setState(() => _selectedCompany = null);
  }

  @override
  void initState() {
    super.initState();
    getcompany();
  }

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const userHomePAge()),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: surfaceLight,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          elevation: 0.5,
          foregroundColor: primaryBlue,
          title: Text(
            'Complaints',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: borderColor,
              height: 1,
            ),
          ),
        ),
        body: _isLoading
            ? Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(primaryBlue),
                    strokeWidth: 3,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Processing your request...",
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Professional Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.support_agent_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              "Customer Support",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        "Please provide detailed information about your concern. Our team will review and respond within 24-48 hours.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Form Section Label
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "COMPLAINT DETAILS",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textSecondary,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Company Selection
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Company",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 12),
                            border: InputBorder.none,
                          ),
                          hint: Text(
                            "Choose a company",
                            style: TextStyle(color: textSecondary.withOpacity(0.5)),
                          ),
                          value: _selectedCompany,
                          items: companies.map((company) {
                            return DropdownMenuItem<String>(
                              value: company['id'].toString(),
                              child: Text(
                                company['name'] ?? 'Unknown',
                                style: const TextStyle(fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() => _selectedCompany = newValue);
                          },
                          validator: (value) =>
                          value == null ? 'Company selection is required' : null,
                          icon: Icon(Icons.keyboard_arrow_down_rounded,
                              color: textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),

                // Complaint Details
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Complaint Description",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextFormField(
                          controller: _complaintController,
                          maxLines: 8,
                          decoration: InputDecoration(
                            hintText: "Describe your complaint in detail...",
                            hintStyle: TextStyle(
                              color: textSecondary.withOpacity(0.5),
                              fontSize: 14,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(12),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please describe your complaint';
                            }
                            if (value.trim().length < 20) {
                              return 'Please provide at least 20 characters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Character Count
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${_complaintController.text.length} characters",
                    style: TextStyle(
                      fontSize: 12,
                      color: textSecondary.withOpacity(0.7),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Action Buttons
                Row(
                  children: [
                    // Submit Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _sendData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryBlue,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : const Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Clear Button
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: _clearForm,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: textSecondary,
                            side: const BorderSide(color: borderColor),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "Clear",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // View Replies Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => cstd_viewComplaintsPage(title: ''),
                        ),
                      );
                    },
                    icon: Icon(Icons.history_rounded, size: 18, color: secondaryBlue),
                    label: const Text(
                      "View Complaint History",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: secondaryBlue,
                      side: BorderSide(color: secondaryBlue.withOpacity(0.3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // // Information Card
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: Colors.blue.shade50,
                //     borderRadius: BorderRadius.circular(8),
                //     border: Border.all(color: Colors.blue.shade100),
                //   ),
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.info_outline_rounded,
                //         size: 20,
                //         color: primaryBlue,
                //       ),
                //       const SizedBox(width: 12),
                //       Expanded(
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             // const Text(
                //             //   "Important Information",
                //             //   style: TextStyle(
                //             //     fontSize: 13,
                //             //     fontWeight: FontWeight.w600,
                //             //     color: textPrimary,
                //             //   ),
                //             // ),
                //             const SizedBox(height: 4),
                //             // Text(
                //             //   "• All complaints are handled confidentially\n"
                //             //       "• You will receive email updates on your complaint\n"
                //             //       "• Response time: 24-48 business hours",
                //             //   style: TextStyle(
                //             //     fontSize: 12,
                //             //     color: textSecondary,
                //             //     height: 1.5,
                //             //   ),
                //             // ),
                //           ],
                //         ),
                // //       ),
                //     ],
                //   ),
                // ),
                //
                // const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}