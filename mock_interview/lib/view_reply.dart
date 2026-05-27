import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mock_interview/send_complaint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const cstd_viewComplaints());
}

class cstd_viewComplaints extends StatelessWidget {
  const cstd_viewComplaints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cstd_viewComplaintsPage(title: 'View Reply'),
    );
  }
}

class cstd_viewComplaintsPage extends StatefulWidget {
  const cstd_viewComplaintsPage({super.key, required this.title});
  final String title;

  @override
  State<cstd_viewComplaintsPage> createState() => cstd_viewComplaintsPageState();
}

class cstd_viewComplaintsPageState extends State<cstd_viewComplaintsPage> {
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
      String sid = sh.getString('lid') ?? '';

      String apiUrl = '$urls/user_viewreply/';
      var response = await http.post(Uri.parse(apiUrl), body: {
        'lid':sid
      });
      var jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        List<Map<String, dynamic>> tempList = [];
        for (var item in jsonData['key']) {
          tempList.add({
            'id': item['id'].toString(),
            'replay': item['reply'].toString(),
            'complaint': item['complaint'].toString(),
            'date': item['date'].toString(),


          });
        }
        setState(() {
          users = tempList;
        });
      }
    } catch (e) {
      print("Error fetching Complaints: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Send_complaintPage(title: '',)),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: users.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return Card(
              margin: const EdgeInsets.all(10),
              elevation: 5,
              child: ListTile(
                title: Text("Complaint: ${
                    user['complaint']}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date : ${user['date']}"),
                    Text("Reply : ${user['replay']}"),



                  ],


                ),


              ),

            );
          },
        ),
      ),
    );
  }
}