// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class Sendreview extends StatefulWidget {
//   const Sendreview({super.key});
//
//   @override
//   State<Sendreview> createState() => _SendreviewState();
// }
//
// class _SendreviewState extends State<Sendreview> {
//
//   TextEditingController reviewController = TextEditingController();
//   double rating = 0;   // ⭐ rating variable
//   List g=[];
//   String? _selectedCompany;
//
//   Future<void> Sendreview_() async {
//
//     // ---------------- VALIDATION ----------------
//     if (reviewController.text.trim().isEmpty) {
//       Fluttertoast.showToast(
//         msg: "Review field cannot be empty!",
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//       return;
//     }
//
//     if (rating == 0) {
//       Fluttertoast.showToast(
//         msg: "Please give a rating!",
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
//       Uri.parse('$url/review_company/'),
//       body: {
//         'review': reviewController.text.trim(),
//         'lid': lid,
//         'rating': rating.toString(),
//         'Company_id':_selectedCompany
//         // ⭐ sending rating
//       },
//     );
//
//     if (res.statusCode == 200) {
//       final data = jsonDecode(res.body);
//
//       if (data['status'] == 'success') {
//         Fluttertoast.showToast(
//           msg: "Review submitted successfully!",
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//
//         reviewController.clear();
//         setState(() {
//           rating = 0;
//         });
//
//       } else {
//         Fluttertoast.showToast(
//           msg: "Submission failed!",
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       }
//
//     } else {
//       Fluttertoast.showToast(
//         msg: "Server Error!",
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
//           'Send Review',
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         centerTitle: true,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Colors.blueAccent, Colors.lightBlue],
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
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//
//                       const Icon(Icons.feedback_outlined,
//                           size: 70, color: Colors.blueAccent),
//
//                       const SizedBox(height: 10),
//
//                       const Text(
//                         'Submit Your Review',
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blueAccent,
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       // ⭐ Rating Section
//                       const Text(
//                         "Rate Us",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//
//                       const SizedBox(height: 10),
//
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(5, (index) {
//                           return IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 rating = index + 1.0;
//                               });
//                             },
//                             icon: Icon(
//                               index < rating
//                                   ? Icons.star
//                                   : Icons.star_border,
//                               color: Colors.amber,
//                               size: 32,
//                             ),
//                           );
//                         }),
//                       ),
//
//                       const SizedBox(height: 20),
//
//                       DropdownButtonFormField<String>(
//                         decoration: const InputDecoration(
//                           labelText: 'Select company',
//                           border: OutlineInputBorder(),
//                           prefixIcon: Icon(Icons.account_balance_rounded),
//                         ),
//                         value: _selectedCompany,
//                         items: g.map((vehicle) {
//                           return DropdownMenuItem<String>(
//                             value: vehicle['id'].toString(),
//                             child: Text(vehicle['name'] ?? 'N/A'),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _selectedCompany = newValue;
//                           });
//                         },
//                         validator: (value) => value == null ? 'Please select a vehicle' : null,
//                       ),
//                       const SizedBox(height: 20),
//
//                       TextFormField(
//                         controller: reviewController,
//                         maxLines: 5,
//                         decoration: InputDecoration(
//                           labelText: 'Write Review',
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: const BorderSide(
//                                 color: Colors.blueAccent, width: 2),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 30),
//
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton.icon(
//                           onPressed: Sendreview_,
//                           icon: const Icon(Icons.send, color: Colors.white),
//                           label: const Text(
//                             'Send Review',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blueAccent,
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       const SizedBox(height: 20),
//
//
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//   Future<void> getcompany() async {
//     SharedPreferences sh=await SharedPreferences.getInstance();
//     String? a=sh.getString('url');
//     final res= await http.post(Uri.parse('$a/companytocomplaint/'));
//     if(res.statusCode==200){
//       final data=jsonDecode(res.body);
//       setState(() {
//         g=data['data'];
//         print(g);
//       });
//
//
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getcompany();
//   }
// // }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Sendreview extends StatefulWidget {
  const Sendreview({super.key});

  @override
  State<Sendreview> createState() => _SendreviewState();
}

class _SendreviewState extends State<Sendreview> {
  TextEditingController reviewController = TextEditingController();
  double rating = 0;
  List g = [];
  String? _selectedCompany;
  bool _isLoading = false;

  // Elegant color scheme matching complaint page
  static const Color primaryPurple = Color(0xFF5E35B1); // Deep Purple
  static const Color accentCoral = Color(0xFFFF6B6B); // Coral
  static const Color starYellow = Color(0xFFFFC107);
  static const Color backgroundColor = Color(0xFFF8F9FF); // Soft Lavender
  static const Color surfaceColor = Colors.white;
  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  Future<void> Sendreview_() async {
    // Validation
    if (reviewController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Review field cannot be empty!",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
      return;
    }

    if (rating == 0) {
      Fluttertoast.showToast(
        msg: "Please give a rating!",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
      return;
    }

    if (_selectedCompany == null) {
      Fluttertoast.showToast(
        msg: "Please select a company!",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
      return;
    }

    setState(() => _isLoading = true);

    SharedPreferences prefer = await SharedPreferences.getInstance();
    String? url = prefer.getString('url');
    String? lid = prefer.getString('lid');

    try {
      final res = await http.post(
        Uri.parse('$url/review_company/'),
        body: {
          'review': reviewController.text.trim(),
          'lid': lid,
          'rating': rating.toString(),
          'Company_id': _selectedCompany
        },
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);

        if (data['status'] == 'success') {
          Fluttertoast.showToast(
            msg: "Review submitted successfully!",
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          reviewController.clear();
          setState(() {
            rating = 0;
            _selectedCompany = null;
          });
        } else {
          Fluttertoast.showToast(
            msg: "Submission failed!",
            backgroundColor: accentCoral,
            textColor: Colors.white,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Server Error!",
          backgroundColor: accentCoral,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Network error!",
        backgroundColor: accentCoral,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> getcompany() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String? a = sh.getString('url');
    try {
      final res = await http.post(Uri.parse('$a/companytocomplaint/'));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          g = data['data'];
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load companies");
    }
  }

  @override
  void initState() {
    super.initState();
    getcompany();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: primaryPurple,
        title: const Text(
          'Write a Review',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: primaryPurple,
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
            icon: Icon(Icons.arrow_back, color: primaryPurple),
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
              "Submitting your review...",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Elegant Header with Gradient
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
                      Icons.rate_review_rounded,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Share Your Experience",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your feedback helps us grow",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Main Review Card
            Container(
              width: double.infinity,
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
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Section Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.star_rounded,
                            color: starYellow,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Your Rating",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Tap on stars to rate your experience",
                      style: TextStyle(
                        fontSize: 13,
                        color: textSecondary,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Stars Container
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(5, (index) {
                            return IconButton(
                              onPressed: () {
                                setState(() {
                                  rating = index + 1.0;
                                });
                              },
                              icon: Icon(
                                index < rating
                                    ? Icons.star_rounded
                                    : Icons.star_border_rounded,
                                color: starYellow,
                                size: 40,
                              ),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            );
                          }),
                        ),
                      ),
                    ),

                    if (rating > 0) ...[
                      const SizedBox(height: 16),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: accentCoral.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: accentCoral.withOpacity(0.3)),
                          ),
                          child: Text(
                            _getRatingText(rating),
                            style: TextStyle(
                              color: accentCoral,
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 30),

                    // Company Selection Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: primaryPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.business_center_rounded,
                            color: primaryPurple,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Select Company",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Choose a company',
                          hintStyle: TextStyle(color: textSecondary.withOpacity(0.5)),
                          prefixIcon: Icon(
                            Icons.business_center_rounded,
                            color: primaryPurple,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        value: _selectedCompany,
                        items: g.map((company) {
                          return DropdownMenuItem<String>(
                            value: company['id'].toString(),
                            child: Text(
                              company['name'] ?? 'Unknown Company',
                              style: const TextStyle(fontSize: 15),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCompany = newValue;
                          });
                        },
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: primaryPurple,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Review Input Header
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
                          "Your Review",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: TextFormField(
                        controller: reviewController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText: "Write your detailed review here...",
                          hintStyle: TextStyle(
                            color: textSecondary.withOpacity(0.5),
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Character count
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${reviewController.text.length}/500 characters",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryPurple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Submit Button with Gradient
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
                        onPressed: _isLoading ? null : Sendreview_,
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
                            const Text(
                              "Submit Review",
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
            ),

            const SizedBox(height: 20),

            // Info Card with Coral accent
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: accentCoral.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentCoral.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: accentCoral.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: accentCoral,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Reviews are public",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Your review will be visible to other users and helps them make informed decisions",
                          style: TextStyle(
                            fontSize: 12,
                            color: textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // View Previous Reviews Button
            if (g.isNotEmpty)
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: primaryPurple.withOpacity(0.3)),
                ),
                child: TextButton.icon(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "View all reviews");
                  },
                  icon: Icon(Icons.history_rounded, color: primaryPurple),
                  label: Text(
                    "View Previous Reviews",
                    style: TextStyle(
                      color: primaryPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Footer
            Center(
              child: Text(
                "Thank you for your feedback! 💜",
                style: TextStyle(
                  fontSize: 13,
                  color: primaryPurple.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  String _getRatingText(double rating) {
    if (rating >= 4.5) return "Excellent ⭐⭐⭐⭐⭐";
    if (rating >= 4.0) return "Very Good ⭐⭐⭐⭐";
    if (rating >= 3.0) return "Good ⭐⭐⭐";
    if (rating >= 2.0) return "Average ⭐⭐";
    if (rating >= 1.0) return "Poor ⭐";
    return "Not Rated";
  }
}