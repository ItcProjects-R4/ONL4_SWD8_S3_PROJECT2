import 'package:flutter/material.dart';
import 'package:my_app/widgets/interest_tile.dart';
import 'package:my_app/widgets/custom_decore.dart';
import 'package:my_app/widgets/passwordField.dart';
import 'package:my_app/widgets/section_title.dart';
import 'package:my_app/screens/resultScreen.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String gender = "Male";

  bool sports = false, music = false, reading = false, isObsecured = false;

  double age = 18;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  List<String> getInterests() {
    final list = <String>[];
    if (sports) list.add("Sports");
    if (music) list.add("Music");
    if (reading) list.add("Reading");
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery
        .of(context)
        .size
        .width;
    final isWide = w >= 600;
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text(
          "Registration",
          style: TextStyle(fontWeight: FontWeight.w700, fontFamily: "dancing"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 520 : 520),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionTitle("Personal Info"),
                        const SizedBox(height: 10),

                        TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: dec("Name", Icons.person_outline),
                          validator: (v) =>
                          (v == null || v
                              .trim()
                              .isEmpty)
                              ? "Please enter your name"
                              : null,
                        ),
                        const SizedBox(height: 12),

                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: dec("Email", Icons.email_outlined),
                          validator: (v) {
                            if (v == null || v
                                .trim()
                                .isEmpty) {
                              return "Please enter your email";
                            }
                            final email = v.trim();
                            final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(email);
                            if (!ok) return "Enter a valid email";
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Passwordfield(),

                        const SizedBox(height: 16),
                        const SectionTitle("Gender"),
                        const SizedBox(height: 8),

                        DropdownButtonFormField<String>(
                          decoration: dec("Select Gender", Icons.wc_outlined),
                          items: const [
                            DropdownMenuItem(
                                value: 'Male', child: Text("Male")),
                            DropdownMenuItem(
                                value: "Female", child: Text("Female")),
                          ],
                          onChanged: (v) =>
                              setState(() => gender = v ?? "Male"),
                        ),

                        const SizedBox(height: 16),
                        const SectionTitle("Interests"),
                        const SizedBox(height: 8),

                        InterestTile(
                          title: "Sports",
                          value: sports,
                          onChanged: (v) => setState(() => sports = v),
                        ),
                        InterestTile(
                          title: "Music",
                          value: music,
                          onChanged: (v) => setState(() => music = v),
                        ),
                        InterestTile(
                          title: "Reading",
                          value: reading,
                          onChanged: (v) => setState(() => reading = v),
                        ),

                        const SizedBox(height: 16),
                        const SectionTitle("Age"),
                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("10"),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEF2FF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "${age.round()} years",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Text("60"),
                          ],
                        ),
                        Slider(
                          value: age,
                          min: 10,
                          max: 60,
                          divisions: 50,
                          activeColor: Colors.blue[500],
                          inactiveColor: Colors.grey[500],
                          onChanged: (v) => setState(() => age = v),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text(
                              "Submit",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                fontFamily: "dancing",
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();

                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        ResultScreen(
                                          name: nameController.text.trim(),
                                          email: emailController.text.trim(),
                                          password: passwordController.text,
                                          gender: gender,
                                          interests: getInterests(),
                                          age: age.round(),
                                        ),
                                  ),
                                );
                              }
                            },
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
      ),
    );
  }
}