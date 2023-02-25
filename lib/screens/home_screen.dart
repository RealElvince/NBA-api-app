import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nbaapiapp/constants/constants.dart';
import 'package:nbaapiapp/models/nba_teams.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

// List of teams

  List<NbaTeams> teams = [];

// get data meathod

  Future getData() async {
    var response = await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));

    // Make our Data readable
    var jsonData = jsonDecode(response.body);

    for (var eachTeam in jsonData['data']) {
      // create individual team
      final nbateam =
          NbaTeams(fullname: eachTeam['full_name'], city: eachTeam['city']);

      teams.add(nbateam);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NBA TEAMS',
          style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            // if it is done loading,show teams data
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: const [
                          BoxShadow(color: Colors.grey, blurRadius: 6.0)
                        ]),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            teams[index].fullname,
                            style: kNBAteamsTextColor,
                          ),
                          subtitle: Text(
                            teams[index].city,
                            style: kNBAteamsTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              // if it is still laoding
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 10.0,
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          }),
    );
  }
}
