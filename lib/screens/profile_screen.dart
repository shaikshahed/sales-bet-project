import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sales_bets/screens/auth_wrapper.dart';
import 'package:sales_bets/screens/sign_in.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text('Credits: ${user.credits}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await AuthService().signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed out successfully')),
                );
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              },
              child: const Text('Sign Out'),
            ),
            const SizedBox(height: 16),
            const Text('Achievements:'),
            const SizedBox(height: 8),
            const Text('- No-loss bettor (sample badge)'),
          ],
        ),
      ),
    );
  }
}
