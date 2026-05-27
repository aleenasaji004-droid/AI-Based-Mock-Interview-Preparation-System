
import 'package:flutter/material.dart';
import 'package:mock_interview/review_company.dart';
import 'package:mock_interview/send_complaint.dart';
import 'package:mock_interview/view_applied_vacancy.dart';
import 'package:mock_interview/view_profile.dart';
import 'package:mock_interview/view_vacancy.dart';

import 'login.dart';
import 'send_feedback.dart';


void main() {
  runApp(const userHome());
}

class userHome extends StatelessWidget {
  const userHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const userHomePAge(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class userHomePAge extends StatefulWidget {
  const userHomePAge({super.key});

  @override
  State<userHomePAge> createState() => _HomePageState();
}

class _HomePageState extends State<userHomePAge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Home'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const SizedBox(height: 30),
            const Text(
              'Hello, User!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewProfile()),
                );
              },
              child: const Text('View Profile'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Send_complaintPage(title: '')),
                );
              },
              child: const Text('Send Complaint'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SendFeedback()),
                );
              },
              child: const Text('Send feedback'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewVacancyPage(title: '',)),
                );
              },
              child: const Text('View Vacancy'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),

                   const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewAppliedVacancy()),
                );
              },
              child: const Text('View Applied Vacancy'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Sendreview( )),
                );
              },
              child: const Text('Review Company'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLoginPage(title: '')),
                  );
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

