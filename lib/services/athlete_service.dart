import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout/repositories/database_connection.dart';

class AthleteService {
  DatabaseConnection _databaseConnection;
  static QuerySnapshot _athletes;

  AthleteService() {
    _databaseConnection = DatabaseConnection();
  }

  Future<QuerySnapshot> getAthletes() async {
    CollectionReference _athletesCollectionRef =
        await _databaseConnection.setAthletesCollectionRef();
    _athletes = await _athletesCollectionRef.get();
    return _athletes;
  }
}
