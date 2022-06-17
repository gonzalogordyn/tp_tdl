import 'package:flutter/material.dart';
import '../model/match/match_participant.dart';
import '../model/match/match.dart';
import '../model/summoner.dart';
import 'navigation_drawer.dart';
import '../components/user_header.dart';
import '../components/match_details/match_summary.dart';
import '../components/match_details/match_details_header.dart';

class MatchDetails extends StatefulWidget {
  final Match match;
  final MatchParticipant matchParticipant;
  final Summoner summoner;
  final String display = "MATCH_SUMMARY";

  const MatchDetails({Key? key,
    required this.match,
    required this.matchParticipant,
    required this.summoner}) : super(key: key);

  @override
  _MatchDetails createState() => _MatchDetails();
}

class _MatchDetails extends State<MatchDetails> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff263F65),
        drawer: NavigationDrawer(),
        appBar: userHeader(widget.summoner.summonerIconId!, widget.summoner.summonerLevel!),
        body: Column (
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              MatchDetailsHeader(),
              SizedBox(height: 10,),
              selectDisplay(),
              ]
        )
    );
  }

  Widget selectDisplay() {
    switch(widget.display) {
      case "MATCH_SUMMARY": {
        return MatchSummary(matchParticipant: widget.matchParticipant,
            match: widget.match,
            summoner: widget.summoner);
      }
      default: {
        throw Exception("Invalid display type for match_details");
      }
    }
  }

}