class Team {
  final String id;
  final String name;
  final String logoUrl;
  final int wins;
  final int losses;

  Team({required this.id, required this.name, required this.logoUrl, this.wins = 0, this.losses = 0});

  factory Team.fromMap(Map<String, dynamic> m, String id) {
    return Team(
      id: id,
      name: m['name'] ?? 'Unknown',
      logoUrl: m['logoUrl'] ?? '',
      wins: m['wins'] ?? 0,
      losses: m['losses'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'logoUrl': logoUrl,
        'wins': wins,
        'losses': losses,
      };
}
