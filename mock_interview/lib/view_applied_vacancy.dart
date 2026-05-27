// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// import 'home.dart';
//
// void main() {
//   runApp(const ViewAppliedVacancy());
// }
//
// class ViewAppliedVacancy extends StatelessWidget {
//   const ViewAppliedVacancy({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ViewAppliedVacancyPage(title: 'Applied Vacancies'),
//     );
//   }
// }
//
// class ViewAppliedVacancyPage extends StatefulWidget {
//   const ViewAppliedVacancyPage({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewAppliedVacancyPage> createState() =>
//       ViewAppliedVacancyPageState();
// }
//
// class ViewAppliedVacancyPageState
//     extends State<ViewAppliedVacancyPage> {
//
//   List<Map<String, dynamic>> appliedList = [];
//
//   @override
//   void initState() {
//     super.initState();
//     viewAppliedVacancy();
//   }
//
//   Future<void> viewAppliedVacancy() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       String apiUrl = '$urls/view_applied_vacancy/';
//
//       var response = await http.post(
//         Uri.parse(apiUrl),
//         body: {'lid': lid},
//       );
//
//       var jsonData = json.decode(response.body);
//
//       if (jsonData['status'] == 'ok') {
//         List<Map<String, dynamic>> tempList = [];
//
//         for (var item in jsonData['data']) {
//           tempList.add({
//             'id': item['id'].toString(),
//             'position': item['VACCANCY'].toString(),
//             'company': item['company'].toString(),
//             'status': item['status'].toString(),
//             'date': item['date'].toString(),
//             'start': item['start'].toString(),
//             'end': item['end'].toString(),
//           });
//         }
//
//         setState(() {
//           appliedList = tempList;
//         });
//       }
//     } catch (e) {
//       print("Error fetching applied vacancies: $e");
//     }
//   }
//
//   Color getStatusColor(String status) {
//     if (status.toLowerCase() == "approved") {
//       return Colors.green;
//     } else if (status.toLowerCase() == "rejected") {
//       return Colors.red;
//     } else {
//       return Colors.orange;
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
//         body: appliedList.isEmpty
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           itemCount: appliedList.length,
//           itemBuilder: (context, index) {
//             final item = appliedList[index];
//
//             return Card(
//               margin: const EdgeInsets.all(10),
//               elevation: 5,
//               child: ListTile(
//                 title: Text(
//                   item['position'],
//                   style: const TextStyle(
//                       fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   crossAxisAlignment:
//                   CrossAxisAlignment.start,
//                   children: [
//                     Text("Company: ${item['company']}"),
//                     Text("Date: ${item['date']}"),
//                     Text("Start: ${item['start']}"),
//                     Text("End: ${item['end']}"),
//                     const SizedBox(height: 8),
//                     Text(
//                       "Status: ${item['status']}",
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: getStatusColor(
//                             item['status']),
//                       ),
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
import 'package:flutter/material.dart';
import 'package:mock_interview/test_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class ViewAppliedVacancy extends StatelessWidget {
  const ViewAppliedVacancy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewAppliedVacancyPage(title: 'Applied Vacancies'),
    );
  }
}

class ViewAppliedVacancyPage extends StatefulWidget {
  const ViewAppliedVacancyPage({super.key, required this.title});
  final String title;

  @override
  State<ViewAppliedVacancyPage> createState() =>
      ViewAppliedVacancyPageState();
}

class ViewAppliedVacancyPageState
    extends State<ViewAppliedVacancyPage> {

  List<Map<String, dynamic>> appliedList = [];

  @override
  void initState() {
    super.initState();
    viewAppliedVacancy();
  }

  Future<void> viewAppliedVacancy() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';

      String apiUrl = '$urls/view_applied_vacancy/';

      var response = await http.post(
        Uri.parse(apiUrl),
        body: {'lid': lid},
      );

      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];

        for (var item in jsonData['data']) {
          tempList.add({
            'id': item['id'].toString(),
            'position': item['VACCANCY'].toString(),
            'company': item['company'].toString(),
            'status': item['status'].toString(),
            'date': item['date'].toString(),
            'start': item['start'].toString(),
            'end': item['end'].toString(),
          });
        }

        setState(() {
          appliedList = tempList;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> viewTest(String candidateId) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String urls = sh.getString('url') ?? '';

    String apiUrl = '$urls/user_view_test/';

    var response = await http.post(
      Uri.parse(apiUrl),
      body: {'candidate_id': candidateId},
    );

    var jsonData = json.decode(response.body);

    if (jsonData['status'] == 'ok') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestDetailsPage(
            testData: jsonData['data'][0],
          ),
        ),
      );
    }
  }

  Color getStatusColor(String status) {
    if (status.toLowerCase() == "accepted") {
      return Colors.green;
    } else if (status.toLowerCase() == "rejected") {
      return Colors.red;
    } else {
      return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: appliedList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: appliedList.length,
        itemBuilder: (context, index) {
          final item = appliedList[index];

          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['position'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  const SizedBox(height: 6),
                  Text("Company: ${item['company']}"),
                  Text("Date: ${item['date']}"),
                  Text("Start: ${item['start']}"),
                  Text("End: ${item['end']}"),
                  const SizedBox(height: 8),
                  Text(
                    "Status: ${item['status']}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getStatusColor(item['status']),
                    ),
                  ),

                  /// ✅ Show Button Only If Accepted
                  if (item['status'].toLowerCase() == "accepted")
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          viewTest(item['id']);
                        },
                        child: const Text("View Test"),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}