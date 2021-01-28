import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout/repositories/database_connection.dart';

class TeamService {
  DatabaseConnection _databaseConnection;
  QuerySnapshot _teamsSnapshot;
  List<QueryDocumentSnapshot> _teamsList;

  TeamService() {
    _databaseConnection = DatabaseConnection();
  }

  Future<QuerySnapshot> getTeams() async {
    CollectionReference _teamsCollectionRef =
        await _databaseConnection.setTeamsCollectionRef();
    try {
      _teamsSnapshot = await _teamsCollectionRef.get();
    } catch (error) {
      print('"Error on getting teams collection: $error');
    }
    return _teamsSnapshot;
  }

  getTeamsList() async {
    if (_teamsSnapshot == null) {
      await getTeams();
    }
    return _teamsSnapshot.docs;
  }
}
