// import 'dart:convert';
// import 'package:check/adminFeild/AdminDashboard.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import '../provider/constants.dart';
//
// class AccountCreationScreen extends StatefulWidget {
//   const AccountCreationScreen({super.key});
//
//   @override
//   _AccountCreationScreenState createState() => _AccountCreationScreenState();
// }
//
// class _AccountCreationScreenState extends State<AccountCreationScreen> {
//   final TextEditingController employeeIdController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController phoneNumberController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//
//   String? selectedGender;
//
//   Future<void> createEmployeeAccount() async {
//     const url = ApiConstants.createEmployeeAccount;
//     var headers = {
//       'x-dhundhoo-session':
//           'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJtYXJncmVnb3Jpb3NzY2hvb2xAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZDYwMGUzZmItMzE5Yy00MjRiLTlkZjYtZjVmNDk4ZDg1MGEyIiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJakkxWW1WbFpESmpMVGc0Wm1NdE5EaGtNaTA0TkdFNExUSm1Zak5sWkRRM1l6RmpOeUlzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVFU0TVRZME1Ea3lOMzAuNnc0OUhzWERRQ0ZfSDMzdkdJN1M3Unl5dUxmaFFvNndPdDhvcWtSY1p2dyIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzI5Njc3MDU5NTc0fQ.jYo3UoskR9D8iwn3aMuH1Z1OzoIUAq9x8nq3I7AOPFk',
//       'Content-Type': 'application/json'
//     };
//
//     var body = json.encode({
//       "orgHandle": "d600e3fb-319c-424b-9df6-f5f498d850a2",
//       "accounts": [
//         {
//           "accountId": employeeIdController.text,
//           "firstName": firstNameController.text,
//           "lastName": lastNameController.text,
//           "address": addressController.text,
//           "avatar": "",
//           "phoneNumber":"91${phoneNumberController.text}",
//           "emailId": emailController.text,
//           "type": "DHUNDHOO",
//           "role": "FIELD_EMPLOYEE",
//           "status": "ACTIVE",
//           "extra": {
//             "gender": selectedGender,
//             "guardians": ["91${phoneNumberController.text}"],
//           }
//         }
//       ]
//     });
//     print('body $body');
//     try {
//       var response =
//           await http.post(Uri.parse(url), headers: headers, body: body);
//
//       if (response.statusCode == 200) {
//         print('Employee account created successfully');
//         print(response.body);
//       } else {
//         print('Error: ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Create Account',
//           style: TextStyle(color: Colors.white, fontSize: 22),
//         ),
//         backgroundColor: Colors.grey.shade800,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => AdminDashboardScreen(),
//               ),
//             );
//           },
//         ),
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.deepOrangeAccent, Colors.orange],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Card(
//             elevation: 8.0,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(16.0),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ListView(
//                 children: [
//                   Text(
//                     'Create Account Form',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.grey.shade900,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                       label: 'Employee Id', controller: employeeIdController),
//                   _buildTextField(
//                       label: 'First Name', controller: firstNameController),
//                   _buildTextField(
//                       label: 'Last Name', controller: lastNameController),
//                   _buildTextField(
//                       label: 'PhoneNumber', controller: phoneNumberController),
//                   _buildTextField(
//                       label: 'Email Id', controller: emailController),
//                   _buildTextField(
//                       label: 'Address', controller: addressController),
//                   _buildDropdownField(
//                     label: 'Gender',
//                     items: ['MALE', 'FEMALE'],
//                     value: selectedGender,
//                     onChanged: (value) => setState(() {
//                       selectedGender = value;
//                     }),
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           createEmployeeAccount();
//                         },
//                         icon: const Icon(Icons.add),
//                         label: const Text(
//                           'Add New',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           // Cancel logic here
//                         },
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.redAccent,
//                           textStyle: const TextStyle(fontSize: 18),
//                         ),
//                         child: const Text('Cancel'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(
//       {required String label, required TextEditingController controller}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: TextField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDropdownField({
//     required String label,
//     required List<String> items,
//     String? value,
//     ValueChanged<String?>? onChanged,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12.0),
//       child: DropdownButtonFormField<String?>(
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         value: value,
//         onChanged: onChanged,
//         items: items
//             .map((item) => DropdownMenuItem<String?>(
//                   value: item,
//                   child: Text(item),
//                 ))
//             .toList(),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:check/adminFeild/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../provider/constants.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  _AccountCreationScreenState createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedGender;
  String? avatarBase64;
  final ImagePicker _picker = ImagePicker();

  Future<void> createEmployeeAccount() async {
    const url = ApiConstants.createEmployeeAccount;
    var headers = {
      'x-dhundhoo-session':
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhY2NvdW50SWQiOiJtYXJncmVnb3Jpb3NzY2hvb2xAZ21haWwuY29tIiwicm9sZSI6IkFETUlOIiwib3JnSGFuZGxlIjoiZDYwMGUzZmItMzE5Yy00MjRiLTlkZjYtZjVmNDk4ZDg1MGEyIiwiYWNjZXNzQ29kZSI6ImV5SjBlWEFpT2lKS1YxUWlMQ0poYkdjaU9pSklVekkxTmlKOS5leUowYjJ0bGJpSTZJakkxWW1WbFpESmpMVGc0Wm1NdE5EaGtNaTA0TkdFNExUSm1Zak5sWkRRM1l6RmpOeUlzSW5ScGJXVnpkR0Z0Y0NJNk1UY3lPVFU0TVRZME1Ea3lOMzAuNnc0OUhzWERRQ0ZfSDMzdkdJN1M3Unl5dUxmaFFvNndPdDhvcWtSY1p2dyIsInRpbWVab25lIjoiVVRDKzA1OjMwIiwidHlwZSI6Ik9SRyIsInZlcnNpb24iOiIwLjIuMCIsInBsYXRmb3JtIjoiV0VCIiwiZXhwaXJlc0F0IjoxNzI5Njc3MDU5NTc0fQ.jYo3UoskR9D8iwn3aMuH1Z1OzoIUAq9x8nq3I7AOPFk',
      'Content-Type': 'application/json'
    };

    var body = json.encode({
      "orgHandle": "d600e3fb-319c-424b-9df6-f5f498d850a2",
      "accounts": [
        {
          "accountId": employeeIdController.text,
          "firstName": firstNameController.text,
          "lastName": lastNameController.text,
          "address": addressController.text,
          "avatar": avatarBase64 ?? "",
          "phoneNumber": "91${phoneNumberController.text}",
          "emailId": emailController.text,
          "type": "DHUNDHOO",
          "role": "FIELD_EMPLOYEE",
          "status": "ACTIVE",
          "extra": {
            "gender": selectedGender,
            "guardians": ["91${phoneNumberController.text}"],
          }
        }
      ]
    });
    print('body $body');
    try {
      var response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 200) {
        print('Employee account created successfully');
        print(response.body);
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      final bytes = await imageFile.readAsBytes();
      setState(() {
        avatarBase64 = base64Encode(bytes);
      });
      print('Image selected and converted to base64');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.grey.shade800,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AdminDashboardScreen(),
              ),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrangeAccent, Colors.orange],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Text(
                    'Create Account Form',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(label: 'Employee Id', controller: employeeIdController),
                  _buildTextField(label: 'First Name', controller: firstNameController),
                  _buildTextField(label: 'Last Name', controller: lastNameController),
                  _buildTextField(label: 'PhoneNumber', controller: phoneNumberController),
                  _buildTextField(label: 'Email Id', controller: emailController),
                  _buildTextField(label: 'Address', controller: addressController),
                  _buildDropdownField(
                    label: 'Gender',
                    items: ['MALE', 'FEMALE'],
                    value: selectedGender,
                    onChanged: (value) => setState(() {
                      selectedGender = value;
                    }),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.image),
                    label: const Text('Upload Image'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: createEmployeeAccount,
                        icon: const Icon(Icons.add),
                        label: const Text(
                          'Add New',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Cancel logic here
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({required String label, required TextEditingController controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required List<String> items,
    String? value,
    ValueChanged<String?>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String?>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 18, color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        value: value,
        onChanged: onChanged,
        items: items
            .map((item) => DropdownMenuItem<String?>(
          value: item,
          child: Text(item),
        ))
            .toList(),
      ),
    );
  }
}
