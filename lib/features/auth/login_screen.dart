import 'package:flutter/material.dart';
import 'package:machine_test_user_api/core/services/api_services.dart';
import 'package:machine_test_user_api/features/auth/custom_button.dart';
import 'package:machine_test_user_api/features/home/user_details_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _searchUser() async {
    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a GitHub username';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await ApiServices.getUserData(name: username);

      if (!mounted) return;

      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserDetailsScreen(user: user)),
        );
      } else {
        setState(() {
          _errorMessage = 'User "$username" not found';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'UserName',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
            CustomButton(onTap: () => _searchUser(), margin: const EdgeInsets.only(top: 10)),
          ],
        ),
      ),
    );
  }
}
