import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/wallet_service.dart';
import '../models/team.dart';
import '../widgets/bet_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletService>(context);
    // sample teams
    final teams = [
      Team(id: 't1', name: 'Alpha Sales', logoUrl: '', wins: 5),
      Team(id: 't2', name: 'Beta Growth', logoUrl: '', wins: 3),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Credits: ${wallet.credits}', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            const Text('Ongoing Challenges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, i) {
                  final team = teams[i];
                  return BetCard(team: team);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
