// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart'; // ✅ ADDED
//
// import '../login.dart';
//
// enum Gender { male, female }
//
// class AppColors {
//   static const Color primaryBlue = Color(0xFF1453AE);
//   static const Color accentGreen = Color(0xFF34D399);
//   static const Color backgroundLight = Color(0xFFF7F7F7);
// }
//
// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});
//
//   @override
//   State<RegisterPage> createState() => RegisterPageState();
// }
//
// class RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _placeController = TextEditingController();
//   final TextEditingController _dobController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _postController = TextEditingController();
//   final TextEditingController _genderController = TextEditingController();
//   final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _stateController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _cpasswordController = TextEditingController();
//
//   File? _selectedImage;
//   File? _selectedResume;
//
//   Future<void> _chooseImage() async {
//     try {
//       final ImagePicker picker = ImagePicker();
//       final XFile? pickedFile = await picker.pickImage(
//         source: ImageSource.gallery,
//         maxWidth: 800,
//         maxHeight: 800,
//         imageQuality: 80,
//       );
//
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       } else {
//         Fluttertoast.showToast(msg: "No image selected");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Failed to pick image: $e");
//     }
//   }
//
//   // ✅ UPDATED TO PICK PDF
//   Future<void> _chooseResume() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//       );
//
//       if (result != null && result.files.single.path != null) {
//         setState(() {
//           _selectedResume = File(result.files.single.path!);
//         });
//       } else {
//         Fluttertoast.showToast(msg: "No Resume selected");
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Failed to pick Resume: $e");
//     }
//   }
//
//   Future<void> _sendData() async {
//     if (_formKey.currentState!.validate()) {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String? url = sh.getString('url');
//
//       if (url == null) {
//         Fluttertoast.showToast(msg: "Server URL not found.");
//         return;
//       }
//
//       final uri = Uri.parse('$url/user_registration/');
//       var request = http.MultipartRequest('POST', uri);
//
//       request.fields['name'] = _nameController.text;
//       request.fields['email'] = _emailController.text;
//       request.fields['place'] = _placeController.text;
//       request.fields['dob'] = _dobController.text;
//       request.fields['phone'] = _phoneController.text;
//       request.fields['password'] = _passwordController.text;
//       request.fields['post'] = _postController.text;
//       request.fields['pin'] = _pinController.text;
//       request.fields['gender'] = _genderController.text;
//       request.fields['city'] = _cityController.text;
//       request.fields['state'] = _stateController.text;
//       request.fields['cpassword'] = _cpasswordController.text;
//
//       if (_selectedImage != null) {
//         if (await _selectedImage!.exists()) {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               'photo',
//               _selectedImage!.path,
//               filename:
//               'current_student_${DateTime.now().millisecondsSinceEpoch}.jpg',
//             ),
//           );
//         }
//       }
//
//       // ✅ FIXED FIELD NAME + PDF EXTENSION
//       if (_selectedResume != null) {
//         if (await _selectedResume!.exists()) {
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               'resume', // ✅ CHANGED
//               _selectedResume!.path,
//               filename:
//               'resume_${DateTime.now().millisecondsSinceEpoch}.pdf', // ✅ CHANGED
//             ),
//           );
//         }
//       }
//
//       try {
//         var response = await request.send();
//         var respStr = await response.stream.bytesToString();
//         var data = jsonDecode(respStr);
//
//         if (response.statusCode == 200 && data['status'] == 'ok') {
//           Fluttertoast.showToast(msg: data['message']);
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => const MyLoginPage(title: '')),
//           );
//         } else {
//           Fluttertoast.showToast(
//               msg: data['message'] ?? "Unexpected response");
//         }
//       } catch (e) {
//         Fluttertoast.showToast(msg: "Network Error: $e");
//       }
//     } else {
//       Fluttertoast.showToast(msg: "Please fix errors in the form");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     const OutlineInputBorder focusedBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       borderSide: BorderSide(color: AppColors.accentGreen, width: 2.5),
//     );
//
//     const OutlineInputBorder defaultBorder = OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       borderSide: BorderSide(color: AppColors.primaryBlue, width: 1.5),
//     );
//
//     InputDecoration _buildInputDecoration(String label) {
//       return InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: AppColors.primaryBlue),
//         border: defaultBorder,
//         enabledBorder: defaultBorder,
//         focusedBorder: focusedBorder,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//         const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       );
//     }
//
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
//         );
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundLight,
//         appBar: AppBar(
//           title: const Text('New User Registration'),
//           centerTitle: true,
//           backgroundColor: AppColors.primaryBlue,
//           foregroundColor: Colors.white,
//           elevation: 5,
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 ElevatedButton(
//                   onPressed: _chooseImage,
//                   child: const Text("Add Photo"),
//                 ),
//                 if (_selectedImage != null)
//                   Image.file(
//                     _selectedImage!,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//
//                 ElevatedButton(
//                   onPressed: _chooseResume,
//                   child: const Text("Add Resume"),
//                 ),
//                 if (_selectedResume != null)
//                   Image.file(
//                     _selectedResume!,
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//
//
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: _buildInputDecoration('Full Name'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Name is required'
//                       : null,
//                 ),
//                 const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _placeController,
//                   decoration: _buildInputDecoration('Place'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Place is required'
//                       : null,
//                 ), const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _postController,
//                   decoration: _buildInputDecoration('Post'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'post is required'
//                       : null,
//                 ), const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _genderController,
//                   decoration: _buildInputDecoration('Gender'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Gender is required'
//                       : null,
//                 ),const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _pinController,
//                   decoration: _buildInputDecoration('Pin'),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Pin is required';
//                     }
//                     // if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                     //   return 'Enter a valid 10-digit phone number';
//                     // }
//                     return null;
//                   },
//                 ), const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _stateController,
//                   decoration: _buildInputDecoration('State'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'state is required'
//                       : null,
//                 ), const SizedBox(height: 15),
//                 // TextFormField(
//                 //   controller: _resumeController,
//                 //   decoration: _buildInputDecoration('Resume'),
//                 //   validator: (value) => value == null || value.trim().isEmpty
//                 //       ? 'resume is required'
//                 //       : null,
//                 // ), const SizedBox(height: 15),
//
//
//
//                 TextFormField(
//                   controller: _cityController,
//                   decoration: _buildInputDecoration('City'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'city is required'
//                       : null,
//                 ),
//
//
//                 const SizedBox(height: 15),
//                 TextFormField(
//                   controller: _dobController,
//                   readOnly: true,
//                   decoration: _buildInputDecoration('Date of Birth'),
//                   onTap: () async {
//                     DateTime? pickedDate = await showDatePicker(
//                       context: context,
//                       initialDate: DateTime(2000),
//                       firstDate: DateTime(1950),
//                       lastDate: DateTime.now(),
//                     );
//
//                     if (pickedDate != null) {
//                       setState(() {
//                         _dobController.text =
//                         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                       });
//                     }
//                   },
//                   validator: (value) =>
//                   value == null || value.isEmpty ? 'DOB is required' : null,
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 TextFormField(
//                   controller: _phoneController,
//                   decoration: _buildInputDecoration('Phone Number'),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Phone number is required';
//                     }
//                     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
//                       return 'Enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 15),
//
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: _buildInputDecoration('Email'),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.trim().isEmpty) {
//                       return 'Email is required';
//                     }
//                     if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//                       return 'Enter a valid email';
//                     }
//                     return null;
//                   },
//                 ),
//                 // const SizedBox(height: 15),
//                 // TextFormField(
//                 //   controller: _usernameController,
//                 //   decoration: _buildInputDecoration('Username'),
//                 //   validator: (value) => value == null || value.trim().isEmpty
//                 //       ? 'Username is required'
//                 //       : null,
//                 // ),
//                 const SizedBox(height: 15),
//
//                 TextFormField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: _buildInputDecoration('Password'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Password is required'
//                       : null,
//                 ),
//                 const SizedBox(height: 20),
//                 TextFormField(
//                   controller: _cpasswordController,
//                   obscureText: true,
//                   decoration: _buildInputDecoration(' Confirm Password'),
//                   validator: (value) => value == null || value.trim().isEmpty
//                       ? 'Password is required'
//                       : null,
//                 ),
//                 SizedBox(height: 20,),
//
//                 ElevatedButton(
//                   onPressed: _sendData,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.accentGreen,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     textStyle: const TextStyle(
//                         fontSize: 18, fontWeight: FontWeight.bold),
//                     elevation: 5,
//                     minimumSize: const Size.fromHeight(50),
//                   ),
//                   child: const Text("Register Account"),
//                 ),
//                 const SizedBox(height: 20),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../login.dart';

enum Gender { male, female }

class AppColors {
  static const Color primaryBlue = Color(0xFF1453AE);
  static const Color accentGreen = Color(0xFF34D399);
  static const Color backgroundLight = Color(0xFFF8FAFC);
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  File? _selectedImage;
  File? _selectedResume;
  bool _isLoading = false;

  Future<void> _chooseImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
        Fluttertoast.showToast(msg: "Image selected successfully");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to pick image");
    }
  }

  Future<void> _chooseResume() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedResume = File(result.files.single.path!);
        });
        Fluttertoast.showToast(msg: "Resume selected successfully");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to pick Resume");
    }
  }

  Future<void> _sendData() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      SharedPreferences sh = await SharedPreferences.getInstance();
      String? url = sh.getString('url');

      if (url == null) {
        Fluttertoast.showToast(msg: "Server URL not found.");
        setState(() => _isLoading = false);
        return;
      }

      final uri = Uri.parse('$url/user_registration/');
      var request = http.MultipartRequest('POST', uri);

      request.fields['name'] = _nameController.text;
      request.fields['email'] = _emailController.text;
      request.fields['place'] = _placeController.text;
      request.fields['dob'] = _dobController.text;
      request.fields['phone'] = _phoneController.text;
      request.fields['password'] = _passwordController.text;
      request.fields['post'] = _postController.text;
      request.fields['pin'] = _pinController.text;
      request.fields['gender'] = _genderController.text;
      request.fields['city'] = _cityController.text;
      request.fields['state'] = _stateController.text;
      request.fields['cpassword'] = _cpasswordController.text;

      if (_selectedImage != null) {
        if (await _selectedImage!.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'photo',
              _selectedImage!.path,
              filename: 'profile_${DateTime.now().millisecondsSinceEpoch}.jpg',
            ),
          );
        }
      }

      if (_selectedResume != null) {
        if (await _selectedResume!.exists()) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'resume',
              _selectedResume!.path,
              filename: 'resume_${DateTime.now().millisecondsSinceEpoch}.pdf',
            ),
          );
        }
      }

      try {
        var response = await request.send();
        var respStr = await response.stream.bytesToString();
        var data = jsonDecode(respStr);

        if (response.statusCode == 200 && data['status'] == 'ok') {
          Fluttertoast.showToast(msg: data['message'] ?? "Registration successful");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
          );
        } else {
          Fluttertoast.showToast(msg: data['message'] ?? "Registration failed");
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "Network Error. Please try again.");
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 22),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryBlue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    bool obscureText = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        obscureText: obscureText,
        onTap: onTap,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.primaryBlue),
          prefixIcon: Icon(icon, color: AppColors.primaryBlue, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: AppColors.accentGreen, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildFileUploadButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    File? selectedFile,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedFile != null ? AppColors.accentGreen : Colors.grey.shade300,
              width: selectedFile != null ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: selectedFile != null
                ? AppColors.accentGreen.withOpacity(0.05)
                : Colors.white,
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  selectedFile != null ? Icons.check_circle : icon,
                  color: selectedFile != null
                      ? AppColors.accentGreen
                      : AppColors.primaryBlue,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: selectedFile != null
                            ? AppColors.accentGreen
                            : Colors.grey.shade700,
                      ),
                    ),
                    if (selectedFile != null)
                      Text(
                        selectedFile.path.split('/').last,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryBlue,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Icon(
                Icons.upload_file,
                color: AppColors.primaryBlue,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyLoginPage(title: '')),
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Create Account',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: _isLoading
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
              ),
              SizedBox(height: 16),
              Text(
                'Creating your account...',
                style: TextStyle(color: AppColors.primaryBlue, fontSize: 16),
              ),
            ],
          ),
        )
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_add_alt_1,
                            size: 40,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Join Us Today!",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Fill in your details to create an account",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Documents Section
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader("Documents", Icons.upload_file),

                        // Photo Upload
                        _buildFileUploadButton(
                          label: "Upload Profile Photo",
                          icon: Icons.camera_alt,
                          onPressed: _chooseImage,
                          selectedFile: _selectedImage,
                        ),

                        // Resume Upload
                        _buildFileUploadButton(
                          label: "Upload Resume (PDF)",
                          icon: Icons.picture_as_pdf,
                          onPressed: _chooseResume,
                          selectedFile: _selectedResume,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Personal Information Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader("Personal Info", Icons.person_outline),

                        // _buildTextField(
                        //   controller: _nameController,
                        //   label: "Full Name",
                        //   icon: Icons.badge_outlined,
                        //   validator: (value) => value == null || value.trim().isEmpty
                        //       ? 'Name is required'
                        //       : null,
                        // ),

                        _buildTextField(
                          controller: _nameController,
                          label: "Full Name",
                          icon: Icons.badge_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }

                            final nameRegex = RegExp(r'^[A-Za-z ]+$');

                            if (!nameRegex.hasMatch(value)) {
                              return 'Only letters and spaces are allowed';
                            }

                            return null;
                          },
                        ),

                        // _buildTextField(
                        //   controller: _dobController,
                        //   label: "Date of Birth",
                        //   icon: Icons.cake_outlined,
                        //   readOnly: true,
                        //   onTap: () async {
                        //     DateTime? pickedDate = await showDatePicker(
                        //       context: context,
                        //       initialDate: DateTime(2000),
                        //       firstDate: DateTime(1950),
                        //       lastDate: DateTime.now(),
                        //       builder: (context, child) {
                        //         return Theme(
                        //           data: Theme.of(context).copyWith(
                        //             colorScheme: const ColorScheme.light(
                        //               primary: AppColors.primaryBlue,
                        //               onPrimary: Colors.white,
                        //             ),
                        //           ),
                        //           child: child!,
                        //         );
                        //       },
                        //     );
                        //
                        //     if (pickedDate != null) {
                        //       setState(() {
                        //         _dobController.text =
                        //         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        //       });
                        //     }
                        //   },
                        //   validator: (value) =>
                        //   value == null || value.isEmpty ? 'DOB is required' : null,
                        // ),


                        _buildTextField(
                          controller: _dobController,
                          label: "Date of Birth",
                          icon: Icons.cake_outlined,
                          readOnly: true,
                          onTap: () async {

                            DateTime today = DateTime.now();
                            DateTime minAdultDate = DateTime(today.year - 18, today.month, today.day);

                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: minAdultDate,
                              firstDate: DateTime(1950),
                              lastDate: minAdultDate, // user must be at least 18
                              builder: (context, child) {
                                return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: const ColorScheme.light(
                                      primary: AppColors.primaryBlue,
                                      onPrimary: Colors.white,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (pickedDate != null) {
                              setState(() {
                                _dobController.text =
                                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              });
                            }
                          },
                          validator: (value) =>
                          value == null || value.isEmpty ? 'DOB is required' : null,
                        ),
                        _buildTextField(
                          controller: _genderController,
                          label: "Gender",
                          icon: Icons.people_outlined,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Gender is required'
                              : null,
                        ),


                        _buildTextField(
                          controller: _phoneController,
                          label: "Phone Number",
                          icon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Phone number is required';
                            }
                            if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
                              return 'Phone number must start with 6, 7, 8, or 9 and contain 10 digits';
                            }
                            return null;
                          },
                        ),

                        // _buildTextField(
                        //   controller: _phoneController,
                        //   label: "Phone Number",
                        //   icon: Icons.phone_outlined,
                        //   keyboardType: TextInputType.phone,
                        //   validator: (value) {
                        //     if (value == null || value.trim().isEmpty) {
                        //       return 'Phone number is required';
                        //     }
                        //     if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                        //       return 'Enter a valid 10-digit phone number';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        _buildTextField(
                          controller: _emailController,
                          label: "Email Address",
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Address Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader("Address", Icons.location_on_outlined),

                        _buildTextField(
                          controller: _placeController,
                          label: "Place",
                          icon: Icons.place_outlined,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Place is required'
                              : null,
                        ),

                        // _buildTextField(
                        //   controller: _postController,
                        //   label: "Post Office",
                        //   icon: Icons.local_post_office_outlined,
                        //   validator: (value) => value == null || value.trim().isEmpty
                        //       ? 'Post is required'
                        //       : null,
                        // ),



                        _buildTextField(
                          controller: _postController,
                          label: "Post Office",
                          icon: Icons.local_post_office_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Post is required';
                            }
                            if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
                              return 'Only letters and spaces are allowed';
                            }
                            return null;
                          },
                        ),

                        _buildTextField(
                          controller: _cityController,
                          label: "City",
                          icon: Icons.location_city_outlined,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'City is required'
                              : null,
                        ),

                        // _buildTextField(
                        //   controller: _stateController,
                        //   label: "State",
                        //   icon: Icons.map_outlined,
                        //   validator: (value) => value == null || value.trim().isEmpty
                        //       ? 'State is required'
                        //       : null,
                        // ),


                        _buildTextField(
                          controller: _stateController,
                          label: "State",
                          icon: Icons.map_outlined,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'State is required';
                            }
                            if (!RegExp(r'^[A-Za-z ]+$').hasMatch(value)) {
                              return 'Only letters and spaces are allowed';
                            }
                            return null;
                          },
                        ),

                        // _buildTextField(
                        //   controller: _pinController,
                        //   label: "PIN Code",
                        //   icon: Icons.pin_drop_outlined,
                        //   keyboardType: TextInputType.number,
                        //   validator: (value) {
                        //     if (value == null || value.trim().isEmpty) {
                        //       return 'PIN code is required';
                        //     }
                        //     return null;
                        //   },
                        // ),

                        _buildTextField(
                          controller: _pinController,
                          label: "PIN Code",
                          icon: Icons.pin_drop_outlined,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'PIN code is required';
                            }
                            if (!RegExp(r'^[0-9]{6}$').hasMatch(value)) {
                              return 'Enter a valid 6-digit PIN code';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Security Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader("Security", Icons.security_outlined),

                        _buildTextField(
                          controller: _passwordController,
                          label: "Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) => value == null || value.trim().isEmpty
                              ? 'Password is required'
                              : null,
                        ),

                        _buildTextField(
                          controller: _cpasswordController,
                          label: "Confirm Password",
                          icon: Icons.lock_outline,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Register Button
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _sendData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGreen,
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shadowColor: AppColors.accentGreen.withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.app_registration_rounded, size: 22),
                        SizedBox(width: 10),
                        Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyLoginPage(title: ''),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primaryBlue,
                      ),
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}