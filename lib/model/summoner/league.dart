import 'dart:convert';

class League {
  final String? queueType;
  final String? tier;
  final String? rank;
  final int? lp;
  final int? wins;
  final int? losses;

  League({
    this.queueType,
    this.tier,
    this.rank,
    this.lp,
    this.wins,
    this.losses
  });

  factory League.fromJson(Map<String, dynamic> data) {
    final queueType = _parseQueueType(data["queueType"]);
    final tier = _parseTier(data["tier"]);
    final rank = data["rank"];
    final lp = data["leaguePoints"];
    final wins = data["wins"];
    final losses = data["losses"];

    return League(
        queueType: queueType,
        tier: tier,
        rank: rank,
        lp: lp,
        wins: wins,
        losses: losses
    );
  }
    factory League.unranked() {

      final queueType = "";
      final tier = "";
      final rank = "UNRANKED";
      final lp = 0;
      final wins = 0;
      final losses = 0;

      return League(
          queueType: queueType,
          tier: tier,
          rank: rank,
          lp: lp,
          wins: wins,
          losses: losses
      );
  }

  double getWinrate() {
    if(losses == 0) {
      return 100;
    }

    return ((wins!) / (wins! + losses!)) * 100;
  }

  static String _parseQueueType(String queueId) {
    switch(queueId) {
      case "RANKED_FLEX_SR":
        return "Ranked flex";
      case "RANKED_SOLO_5x5":
        return "Ranked solo";
      default:
        return queueId;
    }
  }

  static String _parseTier(String tier) {
    String lowerCased = tier.toLowerCase();
    String capitalized = lowerCased[0].toUpperCase() + lowerCased.substring(1);
    return capitalized;
  }

  Map<String, dynamic> toJson() {
    return {
      "queueType": queueType,
      "tier": tier,
      "rank": rank,
      "leaguePoints": lp,
      "wins": wins,
      "losses": losses,
    };
  }
}