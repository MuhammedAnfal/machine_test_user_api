import 'package:flutter/material.dart';
import 'package:machine_test_user_api/models/user_model.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: CircleAvatar(radius: 40),
              ),

              _buildDetailsTile(field: 'bio'),
              _buildDetailsTile(field: 'Name'),
              _buildDetailsTile(field: 'No Of Repositories'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsTile({required String field}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Row(
        children: [
          Text('$field: ', style: TextStyle(fontSize: 20)),
          Text('Name ', style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
