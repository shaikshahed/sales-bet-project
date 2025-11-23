class Bet {
  final String id;
  final String teamId;
  final int stake; // credits staked
  final bool won;

  Bet({required this.id, required this.teamId, required this.stake, this.won = false});

  Map<String, dynamic> toMap() => {
        'teamId': teamId,
        'stake': stake,
        'won': won,
      };
}
