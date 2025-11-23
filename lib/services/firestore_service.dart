import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> streamTeams() {
    return _db.collection('teams').orderBy('name').snapshots();
  }

  Future<DocumentSnapshot> getTeam(String id) {
    return _db.collection('teams').doc(id).get();
  }

  Future<void> followTeam(String userId, String teamId) async {
    final ref = _db.collection('users').doc(userId).collection('follows').doc(teamId);
    await ref.set({'followedAt': FieldValue.serverTimestamp()});
  }

  Future<void> unfollowTeam(String userId, String teamId) async {
    final ref = _db.collection('users').doc(userId).collection('follows').doc(teamId);
    await ref.delete();
  }

  Future<void> placeBet(String userId, String teamId, int stake) async {
    // No-loss: do NOT subtract credits here. Create a bet doc instead.
    final betRef = _db.collection('bets').doc();
    await betRef.set({
      'userId': userId,
      'teamId': teamId,  
      'stake': stake,
      'won': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
    // Optional: add reference to user's bets subcollection
    await _db.collection('users').doc(userId).collection('bets').doc(betRef.id).set({
      'teamId': teamId,
      'stake': stake,
      'won': false,
      'betId': betRef.id,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Call this when a bet is determined as won to credit the user's account
  Future<void> markBetWon(String userId, String betId, int reward) async {
    final userRef = _db.collection('users').doc(userId);
    final betRef = _db.collection('bets').doc(betId);

    // transaction to mark bet and add credits atomically
    await _db.runTransaction((tx) async {
      final userSnap = await tx.get(userRef);
      if (!userSnap.exists) throw Exception('User not found');
      final current = (userSnap.data()?['credits'] ?? 0) as int;
      final newCredits = current + reward;
      tx.update(userRef, {'credits': newCredits});
      tx.update(betRef, {'won': true, 'reward': reward, 'resolvedAt': FieldValue.serverTimestamp()});
      // also update user's bets doc if exists
      final userBetRef = userRef.collection('bets').doc(betId);
      tx.set(userBetRef, {'won': true, 'reward': reward}, SetOptions(merge: true));
    });
  }
}
