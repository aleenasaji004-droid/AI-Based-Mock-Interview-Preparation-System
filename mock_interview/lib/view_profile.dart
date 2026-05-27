// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'edit_profile.dart';
// //
// // void main() {
// //   runApp(const view_profile());
// // }
// //
// // class view_profile extends StatelessWidget {
// //   const view_profile({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'View Profile',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const view_profile_page(title: 'View Profile'),
// //     );
// //   }
// // }
// //
// // class view_profile_page extends StatefulWidget {
// //   const view_profile_page({super.key, required this.title});
// //   final String title;
// //
// //   @override
// //   State<view_profile_page> createState() => C_std_viewProfilePageState();
// // }
// //
// // class C_std_viewProfilePageState extends State<view_profile_page> {
// //   C_std_viewProfilePageState() {
// //     _send_data();
// //   }
// //
// //   String name_ = "";
// //   String email_ = "";
// //   String place_ = "";
// //   String dob_ = "";
// //   String city_ = "";
// //   String state_ = "";
// //   String resume_ = "";
// //   String post_ = "";
// //   String pin_ = "";
// //   String gender_ = "";
// //
// //
// //   String phone_ = "";
// //   String photo_ = "";
// //   String img_url_ = "";
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //         return true;
// //       },
// //       child: Scaffold(
// //         // appBar: AppBar(
// //         //   leading: const BackButton(),
// //         //   backgroundColor: Theme.of(context).colorScheme.primary,
// //         //   title: Text(widget.title),
// //         // ),
// //         body: SingleChildScrollView(
// //           padding: const EdgeInsets.all(10),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: <Widget>[
// //
// //               if (photo_.isNotEmpty)
// //                 Center(
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(75),
// //                     child: Image.network(
// //                       _buildImageUrl(),
// //                       width: 150,
// //                       height: 150,
// //                       fit: BoxFit.cover,
// //                       loadingBuilder: (context, child, loadingProgress) {
// //                         if (loadingProgress == null) return child;
// //                         return const SizedBox(
// //                           width: 150,
// //                           height: 150,
// //                           child: Center(
// //                             child: CircularProgressIndicator(),
// //                           ),
// //                         );
// //                       },
// //                       errorBuilder: (context, error, stackTrace) =>
// //                       const Icon(Icons.account_circle, size: 150),
// //                     ),
// //                   ),
// //                 )
// //               else
// //                 const Center(
// //                   child: Icon(Icons.account_circle, size: 150),
// //                 ),
// //
// //               const SizedBox(height: 20),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Name: $name_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Email: $email_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Place: $place_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text(' Date of Birth: $dob_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('City: $city_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('State: $state_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Resume: $resume_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Post: $post_'),
// //               ),
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Pin: $pin_'),
// //               ),
// //
// //
// //
// //
// //
// //               Padding(
// //                 padding: const EdgeInsets.all(5),
// //                 child: Text('Phone: $phone_'),
// //               ),
// //
// //               const SizedBox(height: 20),
// //               Center(
// //                 child: ElevatedButton(
// //                   onPressed: () {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(
// //                         builder: (context) => const EditprofilePage(),
// //                       ),
// //                     );
// //                   },
// //                   child: const Text("Edit Profile"),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// //   String _buildImageUrl() {
// //     if (img_url_.isEmpty || photo_.isEmpty) return '';
// //     if (img_url_.endsWith('/')) {
// //       return "${img_url_}media/$photo_";
// //     } else {
// //       return "$img_url_/media/$photo_";
// //     }
// //   }
// //
// //   void _send_data() async {
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url').toString();
// //     String lid = sh.getString('lid').toString();
// //     String img_url = sh.getString('img_url') ?? '';
// //
// //     setState(() {
// //       img_url_ = img_url;
// //     });
// //
// //     final urls = Uri.parse('$url/user_profile/');
// //     try {
// //       final response = await http.post(urls, body: {
// //         'lid': lid,
// //       });
// //
// //       if (response.statusCode == 200) {
// //         var data = jsonDecode(response.body);
// //         if (data['status'] == 'ok') {
// //           setState(() {
// //             name_ = data['name'];
// //             email_ = data['email'];
// //             place_ = data['place'];
// //             dob_ = data['dob'].toString();
// //             city_ = data['city'];
// //             post_ = data['post'];
// //             pin_ = data['pin'];
// //             state_ = data['state'];
// //             resume_ = data['resume'];
// //
// //             phone_ = data['phone'];
// //             photo_ = data['photo'];
// //           });
// //         } else {
// //           Fluttertoast.showToast(msg: 'Not Found');
// //         }
// //       } else {
// //         Fluttertoast.showToast(msg: 'Network Error');
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: e.toString());
// //     }
// //   }
// // }
// //
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
//
// import 'edit_profile.dart';
//
// void main() {
//   runApp(const ViewProfile());
// }
//
// class ViewProfile extends StatelessWidget {
//   const ViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'View Profile',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ViewProfilePage(title: 'View Profile'),
//     );
//   }
// }
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//   String name_ = "";
//   String email_ = "";
//   String place_ = "";
//   String dob_ = "";
//   String city_ = "";
//   String state_ = "";
//   String resume_ = "";
//   String post_ = "";
//   String pin_ = "";
//   String phone_ = "";
//   String photo_ = "";
//   String img_url_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProfile();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // PROFILE IMAGE
//             Center(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(75),
//                 child: photo_.isNotEmpty
//                     ? Image.network(
//                   _buildImageUrl(),
//                   width: 150,
//                   height: 150,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) =>
//                   const Icon(Icons.account_circle, size: 150),
//                 )
//                     : const Icon(Icons.account_circle, size: 150),
//               ),
//             ),
//             const SizedBox(height: 20),
//
//             _buildText("Name", name_),
//             _buildText("Email", email_),
//             _buildText("Place", place_),
//             _buildText("Date of Birth", dob_),
//             _buildText("City", city_),
//             _buildText("State", state_),
//             _buildText("Post", post_),
//             _buildText("Pin", pin_),
//             _buildText("Phone", phone_),
//
//             const SizedBox(height: 15),
//
//             // DOWNLOAD RESUME BUTTON
//             Padding(
//               padding: const EdgeInsets.all(5),
//               child: resume_.isNotEmpty
//                   ? ElevatedButton.icon(
//                 icon: const Icon(Icons.download),
//                 label: const Text("Download Resume"),
//                 onPressed: _downloadResume,
//               )
//                   : const Text("Resume not uploaded"),
//             ),
//
//             const SizedBox(height: 20),
//
//             // EDIT PROFILE BUTTON
//             Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const EditprofilePage()),
//                   );
//                 },
//                 child: const Text("Edit Profile"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// TEXT BUILDER
//   Widget _buildText(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.all(5),
//       child: Text(
//         "$label: $value",
//         style: const TextStyle(fontSize: 16),
//       ),
//     );
//   }
//
//   /// IMAGE URL BUILDER
//   String _buildImageUrl() {
//     if (img_url_.isEmpty || photo_.isEmpty) return '';
//     return img_url_.endsWith('/')
//         ? "${img_url_}media/$photo_"
//         : "$img_url_/media/$photo_";
//   }
//
//   /// RESUME URL BUILDER
//   String _buildResumeUrl() {
//     if (img_url_.isEmpty || resume_.isEmpty) return '';
//     return img_url_.endsWith('/')
//         ? "${img_url_}media/$resume_"
//         : "$img_url_/media/$resume_";
//   }
//
//   /// DOWNLOAD RESUME FUNCTION (safe, no extra permissions)
//   Future<void> _downloadResume() async {
//     final url = _buildResumeUrl();
//     if (url.isEmpty) {
//       Fluttertoast.showToast(msg: "Resume not available");
//       return;
//     }
//
//     try {
//       final dio = Dio();
//
//       final dir = await getApplicationDocumentsDirectory();
//       final filePath = "${dir.path}/$resume_";
//
//       await dio.download(url, filePath);
//
//       Fluttertoast.showToast(msg: "Resume downloaded to:\n$filePath");
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Download failed: $e");
//     }
//   }
//
//   /// FETCH PROFILE DATA FROM API
//   Future<void> _fetchProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     String lid = sh.getString('lid').toString();
//     String imgUrl = sh.getString('img_url') ?? '';
//
//     setState(() {
//       img_url_ = imgUrl;
//     });
//
//     try {
//       final response = await http.post(Uri.parse('$url/user_profile/'),
//           body: {'lid': lid});
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'ok') {
//           setState(() {
//             name_ = data['name'] ?? "";
//             email_ = data['email'] ?? "";
//             place_ = data['place'] ?? "";
//             dob_ = data['dob']?.toString() ?? "";
//             city_ = data['city'] ?? "";
//             post_ = data['post'] ?? "";
//             pin_ = data['pin'] ?? "";
//             state_ = data['state'] ?? "";
//             resume_ = data['resume'] ?? "";
//             phone_ = data['phone'] ?? "";
//             photo_ = data['photo'] ?? "";
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Profile not found");
//         }
//       } else {
//         Fluttertoast.showToast(msg: "Network error");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
// }
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file_plus/open_file_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'edit_profile.dart';
//
// void main() {
//   runApp(const ViewProfile());
// }
//
// class ViewProfile extends StatelessWidget {
//   const ViewProfile({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'View Profile',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ViewProfilePage(title: 'View Profile'),
//     );
//   }
// }
//
// class ViewProfilePage extends StatefulWidget {
//   const ViewProfilePage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewProfilePage> createState() => _ViewProfilePageState();
// }
//
// class _ViewProfilePageState extends State<ViewProfilePage> {
//   String name_ = "";
//   String email_ = "";
//   String place_ = "";
//   String dob_ = "";
//   String city_ = "";
//   String state_ = "";
//   String resume_ = "";
//   String post_ = "";
//   String pin_ = "";
//   String phone_ = "";
//   String photo_ = "";
//   String img_url_ = "";
//   bool isDownloading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchProfile();
//   }
//
//   /// Construct a full URL for any file, handling relative/full paths
//   String _getFullUrl(String fileName) {
//     if (fileName.isEmpty) return '';
//     if (fileName.startsWith("http")) {
//       return fileName; // already full URL
//     }
//     if (img_url_.isEmpty) return fileName; // fallback
//     String baseUrl = img_url_.endsWith('/') ? img_url_ : "$img_url_/";
//     // Avoid double "media/" if already present
//     if (fileName.startsWith("media/")) {
//       return "$baseUrl$fileName".replaceAll("//", "/").replaceFirst("http:/", "http://");
//     }
//     return "${baseUrl}media/$fileName".replaceAll("//", "/").replaceFirst("http:/", "http://");
//   }
//
//   /// Download resume
//   Future<void> _downloadResume() async {
//     final url = _getFullUrl(resume_);
//     if (url.isEmpty) {
//       Fluttertoast.showToast(msg: "Resume not available");
//       return;
//     }
//
//     setState(() => isDownloading = true);
//
//     try {
//       final dio = Dio();
//       final dir = await getApplicationDocumentsDirectory();
//       String fileName = resume_.split('/').last;
//       String filePath = "${dir.path}/$fileName";
//
//       debugPrint("Downloading to: $filePath");
//
//       await dio.download(
//         url,
//         filePath,
//         onReceiveProgress: (received, total) {
//           if (total != -1) {
//             debugPrint(
//                 "Progress: ${(received / total * 100).toStringAsFixed(0)}%");
//           }
//         },
//       );
//
//       setState(() => isDownloading = false);
//       Fluttertoast.showToast(msg: "Download Complete!");
//       await OpenFile.open(filePath);
//     } catch (e) {
//       setState(() => isDownloading = false);
//       debugPrint("Download Error: $e");
//       Fluttertoast.showToast(msg: "Download failed. Check server connection.");
//     }
//   }
//
//   /// Launch URL in browser
//   Future<void> _launchURL(String url) async {
//     debugPrint("Launching URL: $url");
//     // if (url.isEmpty) {
//     //   Fluttertoast.showToast(msg: "URL not available");
//     //   return;
//     // }
//     final uri = Uri.tryParse(url);
//     if (uri == null) {
//       Fluttertoast.showToast(msg: "Invalid URL");
//       return;
//     }
//     if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
//       Fluttertoast.showToast(msg: "Could not launch URL");
//     }
//   }
//
//   Future<void> _fetchProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? "";
//     String lid = sh.getString('lid') ?? "";
//     String imgUrl = sh.getString('img_url') ?? "";
//
//     setState(() => img_url_ = imgUrl);
//
//     try {
//       final response =
//       await http.post(Uri.parse('$url/user_profile/'), body: {'lid': lid});
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         if (data['status'] == 'ok') {
//           setState(() {
//             name_ = data['name'] ?? "";
//             email_ = data['email'] ?? "";
//             place_ = data['place'] ?? "";
//             dob_ = data['dob']?.toString() ?? "";
//             city_ = data['city'] ?? "";
//             post_ = data['post'] ?? "";
//             pin_ = data['pin'] ?? "";
//             state_ = data['state'] ?? "";
//             resume_ = data['resume'] ?? "";
//             phone_ = data['phone'] ?? "";
//             photo_ = data['photo'] ?? "";
//           });
//         }
//       }
//     } catch (e) {
//       debugPrint("Fetch Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Center(
//               child: CircleAvatar(
//                 radius: 60,
//                 backgroundColor: Colors.deepPurple.shade50,
//                 backgroundImage:
//                 photo_.isNotEmpty ? NetworkImage(_getFullUrl(photo_)) : null,
//                 child: photo_.isEmpty ? const Icon(Icons.person, size: 60) : null,
//               ),
//             ),
//             const SizedBox(height: 24),
//             _buildDetailTile("Name", name_, Icons.person_outline),
//             _buildDetailTile("Email", email_, Icons.email_outlined),
//             _buildDetailTile("Phone", phone_, Icons.phone_android),
//             _buildDetailTile(
//                 "Location", "$place_, $city_, $state_", Icons.location_on_outlined),
//             const Divider(height: 40),
//
//             // Resume
//             const Text("Resume",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             isDownloading
//                 ? const Center(child: CircularProgressIndicator())
//                 : resume_.isNotEmpty
//                 ? Card(
//               elevation: 0,
//               color: Colors.blue.shade50,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12)),
//               child: ListTile(
//                 leading:
//                 const Icon(Icons.picture_as_pdf, color: Colors.red),
//                 title: const Text("My Resume"),
//                 subtitle: Text(resume_.split('/').last),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.open_in_browser,
//                           color: Colors.green, size: 28),
//                       onPressed: () {
//                         _launchURL(_getFullUrl(resume_));
//                       },
//                     ),
//                     // IconButton(
//                     //   icon: const Icon(Icons.download_for_offline,
//                     //       color: Colors.blue, size: 30),
//                     //   onPressed: _downloadResume,
//                     // ),
//                   ],
//                 ),
//               ),
//             )
//                 : const Text("No resume uploaded",
//                 style: TextStyle(color: Colors.grey)),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(200, 50),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const EditprofilePage()));
//                 },
//                 icon: const Icon(Icons.edit),
//                 label: const Text("Edit Profile"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailTile(String label, String value, IconData icon) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.deepPurple, size: 22),
//           const SizedBox(width: 15),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(label,
//                   style: const TextStyle(fontSize: 12, color: Colors.grey)),
//               Text(value.isNotEmpty ? value : "Not specified",
//                   style:
//                   const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_profile.dart';

void main() {
  runApp(const ViewProfile());
}

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewProfilePage(title: 'View Profile'),
    );
  }
}

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ViewProfilePage> createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  String name_ = "";
  String email_ = "";
  String place_ = "";
  String dob_ = "";
  String city_ = "";
  String state_ = "";
  String resume_ = "";
  String post_ = "";
  String pin_ = "";
  String phone_ = "";
  String photo_ = "";
  String img_url_ = "";
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  /// Construct a full URL for any file, handling relative/full paths
  String _getFullUrl(String fileName) {
    if (fileName.isEmpty) return '';
    if (fileName.startsWith("http")) {
      return fileName; // already full URL
    }
    if (img_url_.isEmpty) return fileName; // fallback
    String baseUrl = img_url_.endsWith('/') ? img_url_ : "$img_url_/";
    // Avoid double "media/" if already present
    if (fileName.startsWith("media/")) {
      return "$baseUrl$fileName".replaceAll("//", "/").replaceFirst("http:/", "http://");
    }
    return "${baseUrl}media/$fileName".replaceAll("//", "/").replaceFirst("http:/", "http://");
  }

  /// Download resume
  Future<void> _downloadResume() async {
    final url = _getFullUrl(resume_);
    if (url.isEmpty) {
      Fluttertoast.showToast(msg: "Resume not available");
      return;
    }

    setState(() => isDownloading = true);

    try {
      final dio = Dio();
      final dir = await getApplicationDocumentsDirectory();
      String fileName = resume_.split('/').last;
      String filePath = "${dir.path}/$fileName";

      debugPrint("Downloading to: $filePath");

      await dio.download(
        url,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            debugPrint(
                "Progress: ${(received / total * 100).toStringAsFixed(0)}%");
          }
        },
      );

      setState(() => isDownloading = false);
      Fluttertoast.showToast(msg: "Download Complete!");
      await OpenFile.open(filePath);
    } catch (e) {
      setState(() => isDownloading = false);
      debugPrint("Download Error: $e");
      Fluttertoast.showToast(msg: "Download failed. Check server connection.");
    }
  }

  /// Launch URL in browser
  Future<void> _launchURL(String url) async {
    debugPrint("Launching URL: $url");
    final uri = Uri.tryParse(url);
    if (uri == null) {
      Fluttertoast.showToast(msg: "Invalid URL");
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Fluttertoast.showToast(msg: "Could not launch URL");
    }
  }

  Future<void> _fetchProfile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? "";
    String lid = sh.getString('lid') ?? "";
    String imgUrl = sh.getString('img_url') ?? "";

    setState(() => img_url_ = imgUrl);

    try {
      final response =
      await http.post(Uri.parse('$url/user_profile/'), body: {'lid': lid});
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'ok') {
          setState(() {
            name_ = data['name'] ?? "";
            email_ = data['email'] ?? "";
            place_ = data['place'] ?? "";
            dob_ = data['dob']?.toString() ?? "";
            city_ = data['city'] ?? "";
            post_ = data['post'] ?? "";
            pin_ = data['pin'] ?? "";
            state_ = data['state'] ?? "";
            resume_ = data['resume'] ?? "";
            phone_ = data['phone'] ?? "";
            photo_ = data['photo'] ?? "";
          });
        }
      }
    } catch (e) {
      debugPrint("Fetch Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text(
          widget.title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(1),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Cover Design
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Image with multiple borders
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 65,
                        backgroundColor: Colors.white,
                        backgroundImage: photo_.isNotEmpty
                            ? NetworkImage(_getFullUrl(photo_))
                            : null,
                        child: photo_.isEmpty
                            ? Icon(Icons.person, size: 65, color: Colors.deepPurple[200])
                            : null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Name with stylish background
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        name_.isNotEmpty ? name_ : "User Name",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Email with icon
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            email_.isNotEmpty ? email_ : "email@example.com",
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Main Content in Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Personal Information Card
                  _buildInfoCard(
                    title: "Personal Information",
                    icon: Icons.person_outline,
                    children: [
                      _buildInfoRow(Icons.badge_outlined, "Full Name", name_),
                      _buildInfoRow(Icons.cake_outlined, "Date of Birth", dob_),
                      _buildInfoRow(Icons.phone_outlined, "Phone Number", phone_),
                      _buildInfoRow(Icons.email_outlined, "Email Address", email_),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Address Card
                  _buildInfoCard(
                    title: "Address Details",
                    icon: Icons.location_on_outlined,
                    children: [
                      _buildInfoRow(Icons.place_outlined, "Place", place_),
                      _buildInfoRow(Icons.local_post_office_outlined, "Post Office", post_),
                      _buildInfoRow(Icons.location_city_outlined, "City", city_),
                      _buildInfoRow(Icons.map_outlined, "State", state_),
                      _buildInfoRow(Icons.pin_drop_outlined, "PIN Code", pin_),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Resume Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.description_outlined,
                                  color: Colors.deepPurple,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Resume",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          isDownloading
                              ? const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                            ),
                          )
                              : resume_.isNotEmpty
                              ? Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue.shade50, Colors.blue.shade100],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue.shade200,
                              ),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade100,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red.shade700,
                                  size: 30,
                                ),
                              ),
                              title: Text(
                                resume_.split('/').last,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: const Text("Click to view resume"),
                              trailing: IconButton(
                                icon: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.open_in_browser,
                                    color: Colors.green.shade700,
                                    size: 20,
                                  ),
                                ),
                                onPressed: () => _launchURL(_getFullUrl(resume_)),
                              ),
                            ),
                          )
                              : Container(
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.cloud_off_outlined,
                                    size: 40,
                                    color: Colors.grey.shade400,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "No resume uploaded",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
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

                  const SizedBox(height: 25),

                  // Edit Profile Button
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditprofilePage(),
                          ),
                        ).then((_) => _fetchProfile());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: Colors.deepPurple.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_rounded, size: 22),
                          SizedBox(width: 10),
                          Text(
                            "Edit Profile",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.deepPurple,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 30,
            child: Icon(
              icon,
              size: 18,
              color: Colors.deepPurple.shade300,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value.isNotEmpty ? value : "Not specified",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: value.isNotEmpty ? FontWeight.w500 : FontWeight.normal,
                    color: value.isNotEmpty ? Colors.black87 : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}