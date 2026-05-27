import 'package:flutter/material.dart';

class TestDetailsPage extends StatelessWidget {
  final Map<String, dynamic> testData;

  const TestDetailsPage({super.key, required this.testData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  testData['test_name'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Type: ${testData['test_type']}"),
                Text("Date: ${testData['date']}"),
                Text("Start: ${testData['start']}"),
                Text("End: ${testData['end']}"),
                Text("Status: ${testData['status']}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}