import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/team.dart';
import '../services/wallet_service.dart';
import '../services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BetCard extends StatelessWidget {
  final Team team;
  const BetCard({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<WalletService>(context, listen: false);
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.group)),
        title: Text(team.name),
        subtitle: Text('Wins: ${team.wins}'),
        trailing: ElevatedButton(
          onPressed: () => _showBetDialog(context, wallet, team.id),
          child: const Text('Place Bet'),
        ),
      ),
    );
  }

  void _showBetDialog(BuildContext context, WalletService wallet, String teamId) {
    final controller = TextEditingController(text: '100');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Place No-Loss Bet'),
        content: TextField(controller: controller, keyboardType: TextInputType.number),
        actions: [
          TextButton(onPressed: ()=> Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              final stake = int.tryParse(controller.text) ?? 0;
              if (stake <= 0) return;
              // local simulation
              wallet.placeBet(teamId: teamId, stake: stake);
              // if signed in, also push to Firestore
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                final fs = FirestoreService();
                await fs.placeBet(user.uid, teamId, stake);
              }
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bet placed — stake is safe!')));
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}
