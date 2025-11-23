import 'package:flutter/material.dart';
import '../models/bet.dart';

class WalletService extends ChangeNotifier {
  int credits = 1000;
  List<Bet> bets = [];

  WalletService();

  // No-loss staking: staking does not reduce credits (local simulation)
  void placeBet({required String teamId, required int stake}) {
    final bet = Bet(id: DateTime.now().millisecondsSinceEpoch.toString(), teamId: teamId, stake: stake);
    bets.add(bet);
    notifyListeners();
  }

  // Mark bet as won — user gains stake * multiplier (simple)
  void markBetWon(String betId, {double multiplier = 1.5}) {
    final idx = bets.indexWhere((b) => b.id == betId);
    if (idx == -1) return;
    final b = bets[idx];
    final gain = (b.stake * multiplier).toInt();
    credits += gain;
    bets[idx] = Bet(id: b.id, teamId: b.teamId, stake: b.stake, won: true);
    notifyListeners();
  }
}
