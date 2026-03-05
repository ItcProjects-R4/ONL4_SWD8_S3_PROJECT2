import 'package:flutter/material.dart';


class ResultScreen extends StatelessWidget {
  final String name;
  final String email;
  final String password;
  final String gender;
  final List<String> interests;
  final int age;

  const ResultScreen({
    super.key,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.interests,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    final interestsText = interests.isEmpty ? "None" : interests.join(", ");

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text("Your Data"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 520,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 18,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  const TextSpan(
                    text: "Registration Details\n\n",
                    style: TextStyle(fontSize: 20, fontFamily: "dancing", fontWeight: FontWeight.w900),
                  ),
                  _row("Name: ", name),
                  _row("Email: ", email),
                  _row("Password: ", password),
                  _row("Gender: ", gender),
                  _row("Interests: ", interestsText),
                  _row("Age: ", "$age"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static TextSpan _row(String label, String value) {
    return TextSpan(
      children: [
        TextSpan(
          text: label,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        TextSpan(text: "$value\n"),
      ],
    );
  }
}