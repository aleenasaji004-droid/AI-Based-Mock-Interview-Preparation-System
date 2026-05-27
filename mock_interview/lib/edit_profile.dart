// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'home.dart';
//
//
//
// class EditprofilePage extends StatefulWidget {
//   const EditprofilePage({Key? key}) : super(key: key);
//
//   @override
//   State<EditprofilePage> createState() => _MyEditState();
// }
//
// class _MyEditState extends State<EditprofilePage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController resumeController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   File? _imageFile;
//   String photo_ = "";
//   String img_url_ = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileDetails();
//   }
//
//
//   String _buildImageUrl() {
//     if (photo_.isEmpty) return '';
//     if (photo_.startsWith('http')) return photo_;
//     if (img_url_.endsWith('/') && photo_.startsWith('/')) {
//       return "${img_url_}${photo_.substring(1)}";
//     } else if (!img_url_.endsWith('/') && !photo_.startsWith('/')) {
//       return "$img_url_/$photo_";
//     } else {
//       return "$img_url_$photo_";
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _imageFile = File(picked.path);
//       });
//     }
//   }
//
//   Future<void> _loadProfileDetails() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String urls = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String img_url = sh.getString('img_url') ?? '';
//
//     setState(() {
//       img_url_ = img_url;
//     });
//
//     var res = await http.post(
//       Uri.parse('$urls/user_profileviewforedit/'),
//       body: {'lid': lid},
//     );
//
//     var jsonData = json.decode(res.body);
//     if (jsonData['status'] == 'ok') {
//       setState(() {
//         nameController.text = jsonData['name'];
//         placeController.text = jsonData['place'];
//         emailController.text = jsonData['email'];
//         phoneController.text = jsonData['phone'];
//         cityController.text = jsonData['city'];
//         genderController.text = jsonData['gender'];
//         stateController.text = jsonData['state'];
//         postController.text = jsonData['post'];
//         pinController.text = jsonData['pin'];
//         resumeController.text = jsonData['resume'];
//         dobController.text = jsonData['dob'];
//         photo_ = jsonData['photo'] ?? '';
//
//       });
//     } else {
//       Fluttertoast.showToast(msg: 'Failed to load profile.');
//     }
//   }
//
//   Future<void> _updateProfile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String urls = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//
//     try {
//       var request =
//       http.MultipartRequest('POST', Uri.parse('$urls/user_edit_profile/'));
//       request.fields['lid'] = lid;
//       request.fields['name'] = nameController.text;
//       request.fields['place'] = placeController.text;
//       request.fields['email'] = emailController.text;
//       request.fields['phone'] = phoneController.text;
//       request.fields['city'] = cityController.text;
//       request.fields['state'] = stateController.text;
//       request.fields['post'] = postController.text;
//       request.fields['pin'] = pinController.text;
//       request.fields['gender'] = genderController.text;
//       request.fields['resume'] = resumeController.text;
//       request.fields['dob'] = dobController.text;
//       if (_imageFile != null) {
//         request.files
//             .add(await http.MultipartFile.fromPath('photo', _imageFile!.path));
//       }
//
//       var response = await request.send();
//       var res = await http.Response.fromStream(response);
//       var jsonData = json.decode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         // Fluttertoast.showToast(msg: jsonData['message']);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userHomePAge()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: 'Update failed. Try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//       print('Update error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String finalImageUrl = _buildImageUrl();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             Center(
//               child: GestureDetector(
//                 onTap: _pickImage,
//                 child: CircleAvatar(
//                   radius: 70,
//                   backgroundColor: Colors.grey[300],
//                   backgroundImage: _imageFile != null
//                       ? FileImage(_imageFile!)
//                       : (finalImageUrl.isNotEmpty
//                       ? NetworkImage(finalImageUrl) as ImageProvider
//                       : const AssetImage('assets/person.png')),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: Container(
//                       decoration: const BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.blue,
//                       ),
//                       padding: const EdgeInsets.all(5),
//                       child: const Icon(
//                         Icons.edit,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: cityController,
//               decoration: const InputDecoration(labelText: 'City'),
//             ),
//             TextField(
//               controller: postController,
//               decoration: const InputDecoration(labelText: 'Post'),
//             ),
//             TextField(
//               controller: pinController,
//               decoration: const InputDecoration(labelText: 'Pin'),
//             ),
//             TextField(
//               controller: resumeController,
//               decoration: const InputDecoration(labelText: 'Resume'),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: placeController,
//               decoration: const InputDecoration(labelText: 'Place'),
//             ),
//
//             const SizedBox(height: 10),
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//
//             const SizedBox(height: 10),
//             TextField(
//               controller: phoneController,
//               decoration: const InputDecoration(labelText: 'Phone'),
//             ),
//
//             const SizedBox(height: 10),
//             TextField(
//               controller: stateController,
//               decoration: const InputDecoration(labelText: 'State'),
//             ),
//             TextField(
//               controller: dobController,
//               decoration: const InputDecoration(labelText: 'DOB'),
//             ),
//             TextField(
//               controller: genderController,
//               decoration: const InputDecoration(labelText: 'Gender'),
//             ),
//
//             // TextField(
//             //   controller: doController,
//             //   readOnly: true,
//             //   decoration: const InputDecoration(
//             //     labelText: 'Date of Birth',
//             //     suffixIcon: Icon(Icons.calendar_today),
//             //   ),
//             //   onTap: () async {
//             //     DateTime initialDate = DateTime.now();
//             //
//             //     // if DOB already exists, parse it
//             //     try {
//             //       if (dobController.text.isNotEmpty) {
//             //         initialDate = DateTime.parse(dobController.text);
//             //       }
//             //     } catch (_) {}
//             //
//             //     DateTime? pickedDate = await showDatePicker(
//             //       context: context,
//             //       initialDate: initialDate,
//             //       firstDate: DateTime(1950),
//             //       lastDate: DateTime.now(),
//             //     );
//             //
//             //     if (pickedDate != null) {
//             //       setState(() {
//             //         dobController.text =
//             //         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//             //       });
//             //     }
//             //   },
//             // ),
//
//             const SizedBox(height: 25),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _updateProfile,
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 15),
//                   backgroundColor: Colors.blue,
//                 ),
//                 child: const Text(
//                   'Save Changes',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'home.dart';
//
// class EditprofilePage extends StatefulWidget {
//   const EditprofilePage({Key? key}) : super(key: key);
//
//   @override
//   State<EditprofilePage> createState() => _MyEditState();
// }
//
// class _MyEditState extends State<EditprofilePage> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController placeController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController stateController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController postController = TextEditingController();
//   TextEditingController pinController = TextEditingController();
//   TextEditingController dobController = TextEditingController();
//   TextEditingController resumeController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   File? _imageFile;
//   String photo_ = "";
//   String img_url_ = "";
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadProfileDetails();
//   }
//
//   String _buildImageUrl() {
//     if (photo_.isEmpty) return '';
//     if (photo_.startsWith('http')) return photo_;
//     if (img_url_.endsWith('/') && photo_.startsWith('/')) {
//       return "${img_url_}${photo_.substring(1)}";
//     } else if (!img_url_.endsWith('/') && !photo_.startsWith('/')) {
//       return "$img_url_/$photo_";
//     } else {
//       return "$img_url_$photo_";
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final picked = await picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _imageFile = File(picked.path);
//       });
//     }
//   }
//
//   Future<void> _loadProfileDetails() async {
//     setState(() => _isLoading = true);
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String urls = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String img_url = sh.getString('img_url') ?? '';
//
//     setState(() {
//       img_url_ = img_url;
//     });
//
//     try {
//       var res = await http.post(
//         Uri.parse('$urls/user_profileviewforedit/'),
//         body: {'lid': lid},
//       );
//
//       var jsonData = json.decode(res.body);
//       if (jsonData['status'] == 'ok') {
//         setState(() {
//           nameController.text = jsonData['name'] ?? '';
//           placeController.text = jsonData['place'] ?? '';
//           emailController.text = jsonData['email'] ?? '';
//           phoneController.text = jsonData['phone'] ?? '';
//           cityController.text = jsonData['city'] ?? '';
//           genderController.text = jsonData['gender'] ?? '';
//           stateController.text = jsonData['state'] ?? '';
//           postController.text = jsonData['post'] ?? '';
//           pinController.text = jsonData['pin'] ?? '';
//           resumeController.text = jsonData['resume'] ?? '';
//           dobController.text = jsonData['dob'] ?? '';
//           photo_ = jsonData['photo'] ?? '';
//         });
//       } else {
//         Fluttertoast.showToast(msg: 'Failed to load profile.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error loading profile');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   Future<void> _updateProfile() async {
//     setState(() => _isLoading = true);
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String urls = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//
//     try {
//       var request = http.MultipartRequest('POST', Uri.parse('$urls/user_edit_profile/'));
//       request.fields['lid'] = lid;
//       request.fields['name'] = nameController.text;
//       request.fields['place'] = placeController.text;
//       request.fields['email'] = emailController.text;
//       request.fields['phone'] = phoneController.text;
//       request.fields['city'] = cityController.text;
//       request.fields['state'] = stateController.text;
//       request.fields['post'] = postController.text;
//       request.fields['pin'] = pinController.text;
//       request.fields['gender'] = genderController.text;
//       request.fields['resume'] = resumeController.text;
//       request.fields['dob'] = dobController.text;
//
//       if (_imageFile != null) {
//         request.files.add(await http.MultipartFile.fromPath('photo', _imageFile!.path));
//       }
//
//       var response = await request.send();
//       var res = await http.Response.fromStream(response);
//       var jsonData = json.decode(res.body);
//
//       if (jsonData['status'] == 'ok') {
//         Fluttertoast.showToast(msg: 'Profile updated successfully!');
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const userHomePAge()),
//         );
//       } else {
//         Fluttertoast.showToast(msg: 'Update failed. Try again.');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//       print('Update error: $e');
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }
//
//   Widget _buildTextField({
//     required TextEditingController controller,
//     required String label,
//     required IconData icon,
//     TextInputType? keyboardType,
//     bool readOnly = false,
//     VoidCallback? onTap,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         readOnly: readOnly,
//         onTap: onTap,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Colors.grey[600]),
//           prefixIcon: Icon(icon, color: Colors.deepPurple, size: 22),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey.shade300),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
//           ),
//           filled: true,
//           fillColor: Colors.white,
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     String finalImageUrl = _buildImageUrl();
//
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.deepPurple,
//         foregroundColor: Colors.white,
//         title: const Text(
//           'Edit Profile',
//           style: TextStyle(
//             fontSize: 22,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Loading profile...',
//               style: TextStyle(color: Colors.deepPurple, fontSize: 16),
//             ),
//           ],
//         ),
//       )
//           : SingleChildScrollView(
//         child: Column(
//           children: [
//             // Profile Image Section with Cover
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.deepPurple,
//                 borderRadius: const BorderRadius.vertical(
//                   bottom: Radius.circular(35),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.deepPurple.withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: SafeArea(
//                 bottom: false,
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20),
//                     // Profile Image with Edit Option
//                     Stack(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: Colors.white,
//                               width: 4,
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 15,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child: CircleAvatar(
//                             radius: 65,
//                             backgroundColor: Colors.white,
//                             backgroundImage: _imageFile != null
//                                 ? FileImage(_imageFile!)
//                                 : (finalImageUrl.isNotEmpty
//                                 ? NetworkImage(finalImageUrl) as ImageProvider
//                                 : const AssetImage('assets/person.png')),
//                             child: _imageFile == null && finalImageUrl.isEmpty
//                                 ? Icon(Icons.person, size: 65, color: Colors.deepPurple[200])
//                                 : null,
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 5,
//                           right: 5,
//                           child: GestureDetector(
//                             onTap: _pickImage,
//                             child: Container(
//                               padding: const EdgeInsets.all(8),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 shape: BoxShape.circle,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.2),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 2),
//                                   ),
//                                 ],
//                               ),
//                               child: Icon(
//                                 Icons.camera_alt,
//                                 color: Colors.deepPurple,
//                                 size: 22,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       nameController.text.isNotEmpty
//                           ? nameController.text
//                           : "Your Name",
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Container(
//                       margin: const EdgeInsets.only(bottom: 25),
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 6,
//                       ),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.2),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: Text(
//                         emailController.text.isNotEmpty
//                             ? emailController.text
//                             : "email@example.com",
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             // Form Container
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   // Personal Information Card
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.deepPurple.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Icon(
//                                   Icons.person_outline,
//                                   color: Colors.deepPurple,
//                                   size: 24,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               const Text(
//                                 "Personal Information",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepPurple,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           _buildTextField(
//                             controller: nameController,
//                             label: "Full Name",
//                             icon: Icons.badge_outlined,
//                           ),
//                           _buildTextField(
//                             controller: emailController,
//                             label: "Email Address",
//                             icon: Icons.email_outlined,
//                             keyboardType: TextInputType.emailAddress,
//                           ),
//                           _buildTextField(
//                             controller: phoneController,
//                             label: "Phone Number",
//                             icon: Icons.phone_outlined,
//                             keyboardType: TextInputType.phone,
//                           ),
//                           // _buildTextField(
//                           //   controller: dobController,
//                           //   label: "Date of Birth",
//                           //   icon: Icons.cake_outlined,
//                           //   readOnly: true,
//                           //   onTap: () async {
//                           //     DateTime initialDate = DateTime.now();
//                           //     try {
//                           //       if (dobController.text.isNotEmpty) {
//                           //         initialDate = DateTime.parse(dobController.text);
//                           //       }
//                           //     } catch (_) {}
//                           //
//                           //     DateTime? pickedDate = await showDatePicker(
//                           //       context: context,
//                           //       initialDate: initialDate,
//                           //       firstDate: DateTime(1950),
//                           //       lastDate: DateTime.now(),
//                           //       builder: (context, child) {
//                           //         return Theme(
//                           //           data: Theme.of(context).copyWith(
//                           //             colorScheme: const ColorScheme.light(
//                           //               primary: Colors.deepPurple,
//                           //               onPrimary: Colors.white,
//                           //             ),
//                           //           ),
//                           //           child: child!,
//                           //         );
//                           //       },
//                           //     );
//                           //
//                           //     if (pickedDate != null) {
//                           //       setState(() {
//                           //         dobController.text =
//                           //         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                           //       });
//                           //     }
//                           //   },
//                           // ),
//
//
//
//                           _buildTextField(
//                             controller: dobController,
//                             label: "Date of Birth",
//                             icon: Icons.cake_outlined,
//                             readOnly: true,
//                             onTap: () async {
//
//                               DateTime today = DateTime.now();
//                               DateTime maxAdultDate = DateTime(today.year - 18, today.month, today.day);
//
//                               DateTime initialDate = maxAdultDate;
//
//                               try {
//                                 if (dobController.text.isNotEmpty) {
//                                   initialDate = DateTime.parse(dobController.text);
//                                 }
//                               } catch (_) {}
//
//                               DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: initialDate,
//                                 firstDate: DateTime(1950),
//                                 lastDate: maxAdultDate, // prevents selecting age < 18
//                                 builder: (context, child) {
//                                   return Theme(
//                                     data: Theme.of(context).copyWith(
//                                       colorScheme: const ColorScheme.light(
//                                         primary: Colors.deepPurple,
//                                         onPrimary: Colors.white,
//                                       ),
//                                     ),
//                                     child: child!,
//                                   );
//                                 },
//                               );
//
//                               if (pickedDate != null) {
//                                 setState(() {
//                                   dobController.text =
//                                   "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
//                                 });
//                               }
//                             },
//                           ),
//                           _buildTextField(
//                             controller: genderController,
//                             label: "Gender",
//                             icon: Icons.people_outlined,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Address Card
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.deepPurple.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Icon(
//                                   Icons.location_on_outlined,
//                                   color: Colors.deepPurple,
//                                   size: 24,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               const Text(
//                                 "Address Details",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepPurple,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           _buildTextField(
//                             controller: placeController,
//                             label: "Place",
//                             icon: Icons.place_outlined,
//                           ),
//                           _buildTextField(
//                             controller: cityController,
//                             label: "City",
//                             icon: Icons.location_city_outlined,
//                           ),
//                           _buildTextField(
//                             controller: stateController,
//                             label: "State",
//                             icon: Icons.map_outlined,
//                           ),
//
//
//
//
//
//
//
//
//
//                           _buildTextField(
//                             controller: postController,
//                             label: "Post Office",
//                             icon: Icons.local_post_office_outlined,
//                           ),
//                           _buildTextField(
//                             controller: pinController,
//                             label: "PIN Code",
//                             icon: Icons.pin_drop_outlined,
//                             keyboardType: TextInputType.number,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   // Resume Card
//                   Card(
//                     elevation: 2,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.deepPurple.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Icon(
//                                   Icons.description_outlined,
//                                   color: Colors.deepPurple,
//                                   size: 24,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               const Text(
//                                 "Resume",
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.deepPurple,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 20),
//                           _buildTextField(
//                             controller: resumeController,
//                             label: "Resume URL / File Name",
//                             icon: Icons.picture_as_pdf,
//                           ),
//                           if (resumeController.text.isNotEmpty)
//                             Container(
//                               margin: const EdgeInsets.only(top: 8),
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.blue.shade50,
//                                 borderRadius: BorderRadius.circular(10),
//                                 border: Border.all(color: Colors.blue.shade200),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     Icons.info_outline,
//                                     size: 18,
//                                     color: Colors.blue.shade700,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: Text(
//                                       "Current: ${resumeController.text.split('/').last}",
//                                       style: TextStyle(
//                                         fontSize: 12,
//                                         color: Colors.blue.shade700,
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 30),
//
//                   // Save Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       onPressed: _isLoading ? null : _updateProfile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple,
//                         foregroundColor: Colors.white,
//                         elevation: 5,
//                         shadowColor: Colors.deepPurple.withOpacity(0.5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: _isLoading
//                           ? const SizedBox(
//                         height: 25,
//                         width: 25,
//                         child: CircularProgressIndicator(
//                           strokeWidth: 2,
//                           valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                         ),
//                       )
//                           : const Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.save_rounded, size: 22),
//                           SizedBox(width: 10),
//                           Text(
//                             "Save Changes",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // Cancel Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 45,
//                     child: TextButton(
//                       onPressed: () => Navigator.pop(context),
//                       style: TextButton.styleFrom(
//                         foregroundColor: Colors.grey[600],
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text(
//                         "Cancel",
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




















import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'home.dart';

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({Key? key}) : super(key: key);

  @override
  State<EditprofilePage> createState() => _MyEditState();
}

class _MyEditState extends State<EditprofilePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController resumeController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  File? _imageFile;
  String photo_ = "";
  String img_url_ = "";
  bool _isLoading = false;

  // Validation regex patterns
  final RegExp _alphaOnly = RegExp(r'^[a-zA-Z]+$');
  final RegExp _alphaWithSpace = RegExp(r'^[a-zA-Z\s]+$');
  final RegExp _pinRegex = RegExp(r'^\d{6}$');
  final RegExp _phoneRegex = RegExp(r'^[6-9]\d{9}$');
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  void initState() {
    super.initState();
    _loadProfileDetails();
  }

  String _buildImageUrl() {
    if (photo_.isEmpty) return '';
    if (photo_.startsWith('http')) return photo_;
    if (img_url_.endsWith('/') && photo_.startsWith('/')) {
      return "${img_url_}${photo_.substring(1)}";
    } else if (!img_url_.endsWith('/') && !photo_.startsWith('/')) {
      return "$img_url_/$photo_";
    } else {
      return "$img_url_$photo_";
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<void> _loadProfileDetails() async {
    setState(() => _isLoading = true);

    SharedPreferences sh = await SharedPreferences.getInstance();
    String urls = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    String img_url = sh.getString('img_url') ?? '';

    setState(() {
      img_url_ = img_url;
    });

    try {
      var res = await http.post(
        Uri.parse('$urls/user_profileviewforedit/'),
        body: {'lid': lid},
      );

      var jsonData = json.decode(res.body);
      if (jsonData['status'] == 'ok') {
        setState(() {
          nameController.text = jsonData['name'] ?? '';
          placeController.text = jsonData['place'] ?? '';
          emailController.text = jsonData['email'] ?? '';
          phoneController.text = jsonData['phone'] ?? '';
          cityController.text = jsonData['city'] ?? '';
          genderController.text = jsonData['gender'] ?? '';
          stateController.text = jsonData['state'] ?? '';
          postController.text = jsonData['post'] ?? '';
          pinController.text = jsonData['pin'] ?? '';
          resumeController.text = jsonData['resume'] ?? '';
          dobController.text = jsonData['dob'] ?? '';
          photo_ = jsonData['photo'] ?? '';
        });
      } else {
        Fluttertoast.showToast(msg: 'Failed to load profile.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error loading profile');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
        msg: "Please correct the errors in the form",
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }

    setState(() => _isLoading = true);

    SharedPreferences sh = await SharedPreferences.getInstance();
    String urls = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';

    try {
      var request = http.MultipartRequest('POST', Uri.parse('$urls/user_edit_profile/'));
      request.fields['lid'] = lid;
      request.fields['name'] = nameController.text.trim();
      request.fields['place'] = placeController.text.trim();
      request.fields['email'] = emailController.text.trim();
      request.fields['phone'] = phoneController.text.trim();
      request.fields['city'] = cityController.text.trim();
      request.fields['state'] = stateController.text.trim();
      request.fields['post'] = postController.text.trim();
      request.fields['pin'] = pinController.text.trim();
      request.fields['gender'] = genderController.text.trim();
      request.fields['resume'] = resumeController.text.trim();
      request.fields['dob'] = dobController.text.trim();

      if (_imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('photo', _imageFile!.path));
      }

      var response = await request.send();
      var res = await http.Response.fromStream(response);
      var jsonData = json.decode(res.body);

      if (jsonData['status'] == 'ok') {
        Fluttertoast.showToast(msg: 'Profile updated successfully!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const userHomePAge()),
        );
      } else {
        Fluttertoast.showToast(msg: 'Update failed. Try again.');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
      print('Update error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    bool readOnly = false,
    VoidCallback? onTap,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(icon, color: Colors.deepPurple, size: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String finalImageUrl = _buildImageUrl();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            ),
            SizedBox(height: 16),
            Text(
              'Loading profile...',
              style: TextStyle(color: Colors.deepPurple, fontSize: 16),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Profile Image Section with Cover
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
                      Stack(
                        children: [
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
                              backgroundImage: _imageFile != null
                                  ? FileImage(_imageFile!)
                                  : (finalImageUrl.isNotEmpty
                                  ? NetworkImage(finalImageUrl) as ImageProvider
                                  : const AssetImage('assets/person.png')),
                              child: _imageFile == null && finalImageUrl.isEmpty
                                  ? Icon(Icons.person, size: 65, color: Colors.deepPurple[200])
                                  : null,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: _pickImage,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.deepPurple,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        nameController.text.isNotEmpty
                            ? nameController.text
                            : "Your Name",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        margin: const EdgeInsets.only(bottom: 25),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          emailController.text.isNotEmpty
                              ? emailController.text
                              : "email@example.com",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Personal Information Card
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
                                    Icons.person_outline,
                                    color: Colors.deepPurple,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Personal Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // _buildTextField(
                            //   controller: nameController,
                            //   label: "Full Name",
                            //   icon: Icons.badge_outlined,
                            //   validator: (value) {
                            //     if (value == null || value.trim().isEmpty) {
                            //       return 'Please enter your full name';
                            //     }
                            //     if (value.trim().length < 2) {
                            //       return 'Name is too short';
                            //     }
                            //     return null;
                            //   },
                            // ),

                            _buildTextField(
                              controller: nameController,
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

                            _buildTextField(
                              controller: emailController,
                              label: "Email Address",
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email is required';
                                }
                                if (!_emailRegex.hasMatch(value.trim())) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: phoneController,
                              label: "Phone Number",
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Phone number is required';
                                }
                                if (!_phoneRegex.hasMatch(value.trim())) {
                                  return 'Enter a valid 10-digit Indian mobile number';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: dobController,
                              label: "Date of Birth",
                              icon: Icons.cake_outlined,
                              readOnly: true,
                              onTap: () async {
                                DateTime today = DateTime.now();
                                DateTime maxAdultDate = DateTime(today.year - 18, today.month, today.day);
                                DateTime initialDate = maxAdultDate;

                                try {
                                  if (dobController.text.isNotEmpty) {
                                    initialDate = DateTime.parse(dobController.text);
                                  }
                                } catch (_) {}

                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: initialDate,
                                  firstDate: DateTime(1950),
                                  lastDate: maxAdultDate,
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: const ColorScheme.light(
                                          primary: Colors.deepPurple,
                                          onPrimary: Colors.white,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null) {
                                  setState(() {
                                    dobController.text =
                                    "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                  });
                                }
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Date of birth is required';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: genderController,
                              label: "Gender",
                              icon: Icons.people_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter gender';
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
                                    Icons.location_on_outlined,
                                    color: Colors.deepPurple,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  "Address Details",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            _buildTextField(
                              controller: placeController,
                              label: "Place",
                              icon: Icons.place_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter your place/locality';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: cityController,
                              label: "City",
                              icon: Icons.location_city_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter city';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: stateController,
                              label: "State",
                              icon: Icons.map_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter state';
                                }
                                if (!_alphaOnly.hasMatch(value.trim())) {
                                  return 'State should contain only letters (no spaces/numbers)';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: postController,
                              label: "Post Office",
                              icon: Icons.local_post_office_outlined,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter post office name';
                                }
                                if (!_alphaWithSpace.hasMatch(value.trim())) {
                                  return 'Only letters and spaces allowed';
                                }
                                return null;
                              },
                            ),

                            _buildTextField(
                              controller: pinController,
                              label: "PIN Code",
                              icon: Icons.pin_drop_outlined,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'PIN code is required';
                                }
                                if (!_pinRegex.hasMatch(value.trim())) {
                                  return 'PIN must be exactly 6 digits';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
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
                            const SizedBox(height: 20),
                            _buildTextField(
                              controller: resumeController,
                              label: "Resume URL / File Name",
                              icon: Icons.picture_as_pdf,
                            ),
                            if (resumeController.text.isNotEmpty)
                              Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.blue.shade200),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.info_outline,
                                      size: 18,
                                      color: Colors.blue.shade700,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "Current: ${resumeController.text.split('/').last}",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue.shade700,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          elevation: 5,
                          shadowColor: Colors.deepPurple.withOpacity(0.5),
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
                            Icon(Icons.save_rounded, size: 22),
                            SizedBox(width: 10),
                            Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Cancel Button
                    SizedBox(
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    placeController.dispose();
    phoneController.dispose();
    stateController.dispose();
    cityController.dispose();
    postController.dispose();
    pinController.dispose();
    dobController.dispose();
    resumeController.dispose();
    genderController.dispose();
    super.dispose();
  }
}