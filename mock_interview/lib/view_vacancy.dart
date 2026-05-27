// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:file_picker/file_picker.dart';
//
// import 'home.dart';
//
// void main() {
//   runApp(const ViewVacancy());
// }
//
// class ViewVacancy extends StatelessWidget {
//   const ViewVacancy({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ViewVacancyPage(title: 'View Vacancy'),
//     );
//   }
// }
//
// class ViewVacancyPage extends StatefulWidget {
//   const ViewVacancyPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewVacancyPage> createState() => ViewVacancyPageState();
// }
//
// class ViewVacancyPageState extends State<ViewVacancyPage> {
//   List<Map<String, dynamic>> users = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewUsers();
//   }
//
//   Future<void> viewUsers() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       String apiUrl = '$urls/user_view_vacancy/';
//       var response = await http.post(Uri.parse(apiUrl), body: {'lid': lid});
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'position': item['position'].toString(),
//             'no_of_vaccancy': item['no_of_vaccancy'].toString(),
//             'start': item['start'].toString(),
//             'end': item['end'].toString(),
//             'COMPANY': item['COMPANY'].toString(),
//           });
//         }
//         setState(() {
//           users = tempList;
//         });
//       }
//     } catch (e) {
//       print("Error fetching : $e");
//     }
//   }
//
//   Future<void> applyVacancy(String vacancyId) async {
//     try {
//       // 🔹 Pick Resume File
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf', 'doc', 'docx'],
//       );
//
//       if (result == null) {
//         Fluttertoast.showToast(msg: "Please select a resume");
//         return;
//       }
//
//       File file = File(result.files.single.path!);
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       String apiUrl = '$urls/user_apply_vacancy/';
//
//       var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
//
//       request.fields['lid'] = lid;
//       request.fields['vacancy_id'] = vacancyId;
//
//       request.files.add(
//         await http.MultipartFile.fromPath(
//           'resume',
//           file.path,
//         ),
//       );
//
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       var jsonData = json.decode(responseData);
//
//       if (jsonData['status'] == 'ok') {
//         Fluttertoast.showToast(msg: 'Submitted successfully');
//       } else {
//         Fluttertoast.showToast(msg: 'Application failed');
//       }
//
//     } catch (e) {
//       print("Apply Error: $e");
//       Fluttertoast.showToast(msg: "Error uploading resume");
//     }
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
//         ),
//         body: users.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemCount: users.length,
//           itemBuilder: (context, index) {
//             final user = users[index];
//             return Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 5,
//               child: ListTile(
//                 title: Text(
//                   user['position'].toString(),
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("No of vacancy: ${user['no_of_vaccancy']}"),
//                     Text("Start: ${user['start']}"),
//                     Text("End: ${user['end']}"),
//                     Text("Company: ${user['COMPANY']}"),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () {
//                         applyVacancy(user['id']);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         minimumSize: const Size.fromHeight(50),
//                       ),
//                       child: const Text('Apply'),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:file_picker/file_picker.dart';

import 'home.dart';

void main() {
  runApp(const ViewVacancy());
}

class ViewVacancy extends StatelessWidget {
  const ViewVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewVacancyPage(title: 'View Vacancy'),
    );
  }
}

class ViewVacancyPage extends StatefulWidget {
  const ViewVacancyPage({super.key, required this.title});
  final String title;

  @override
  State<ViewVacancyPage> createState() => ViewVacancyPageState();
}

class ViewVacancyPageState extends State<ViewVacancyPage> {
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    viewUsers();
  }

  Future<void> viewUsers() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      String apiUrl = '$urls/user_view_vacancy/';
      var response = await http.post(Uri.parse(apiUrl), body: {'lid': lid});
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'position': item['position'].toString(),
            'no_of_vaccancy': item['no_of_vaccancy'].toString(),
            'start': item['start'].toString(),
            'end': item['end'].toString(),
            'COMPANY': item['COMPANY'].toString(),
          });
        }
        setState(() {
          users = tempList;
        });
      }
    } catch (e) {
      print("Error fetching : $e");
    }
  }

  Future<void> applyVacancy(String vacancyId) async {
    try {
      // 🔹 Pick Resume File
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result == null) {
        Fluttertoast.showToast(msg: "Please select a resume");
        return;
      }

      File file = File(result.files.single.path!);

      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      String apiUrl = '$urls/user_apply_vacancy/';

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

      request.fields['lid'] = lid;
      request.fields['vacancy_id'] = vacancyId;

      request.files.add(
        await http.MultipartFile.fromPath(
          'resume',
          file.path,
        ),
      );

      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);

      if (jsonData['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Submitted successfully');
      } else {
        Fluttertoast.showToast(msg: 'Application failed');
      }

    } catch (e) {
      print("Apply Error: $e");
      Fluttertoast.showToast(msg: "Error uploading resume");
    }
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
        backgroundColor: const Color(0xFFF8F9FC),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
          foregroundColor: const Color(0xFF2C3E50),
          title: Text(
            'View Vacancy',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          leading: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Color(0xFF2C3E50)),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const userHomePAge()),
                );
              },
            ),
          ),
        ),
        body: users.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
              ),
              SizedBox(height: 20),
              Text(
                "Loading vacancies...",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2C3E50),
                ),
              ),
            ],
          ),
        )
            : Column(
          children: [
            // Header Stats
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4361EE).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Available Vacancies",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "${users.length} Open Positions",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.work_outline_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),

            // Vacancy List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Position and Company Row
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4361EE).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.work_rounded,
                                  color: Color(0xFF4361EE),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['position'].toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C3E50),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      user['COMPANY'].toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                ),
                                child: Text(
                                  "${user['no_of_vaccancy']} slots",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Date Information
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.event_available_rounded,
                                        size: 18,
                                        color: Colors.blue.shade600,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Start Date",
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          Text(
                                            user['start'].toString(),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 30,
                                  width: 1,
                                  color: Colors.grey.shade300,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.event_busy_rounded,
                                          size: 18,
                                          color: Colors.red.shade600,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              "End Date",
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text(
                                              user['end'].toString(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Apply Button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => applyVacancy(user['id']),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.send_rounded, size: 18),
                                  SizedBox(width: 8),
                                  Text(
                                    'Apply Now',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}