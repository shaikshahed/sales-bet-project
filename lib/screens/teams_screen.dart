import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firestore_service.dart';

class TeamsScreen extends StatelessWidget {
  const TeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fs = FirestoreService();
    return Scaffold(
      appBar: AppBar(title: const Text('Teams')),
      body: StreamBuilder<QuerySnapshot>(
        stream: fs.streamTeams(),
        builder: (context, snap) {
          if (snap.hasError) return const Center(child: Text('Error loading teams'));
          if (!snap.hasData) return const Center(child: CircularProgressIndicator());
          final docs = snap.data!.docs;
          if (docs.isEmpty) return const Center(child: Text('No teams yet. Seed some in Firestore.'));
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, i) {
              final d = docs[i];
              final m = d.data() as Map<String, dynamic>;
              return ListTile(title: Text(m['name'] ?? 'Unnamed'));
            },
          );
        },
      ),
    );
  }
}
