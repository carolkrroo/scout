import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scout/pages/home_page.dart';

final _firestore = FirebaseFirestore.instance;

class DatabaseConnection {
  static DocumentReference userDocumentRef;

  static CollectionReference teamsCollectionRef;

  static CollectionReference athletesCollectionRef;

  setUserDocumentRef() async {
    if (userDocumentRef != null) return userDocumentRef;
    userDocumentRef = _firestore.collection("users").doc(loggedInUser.email);
    return userDocumentRef;
  }

  setTeamsCollectionRef() async {
    if (teamsCollectionRef != null) return teamsCollectionRef;
    DocumentReference _userCollectionRef = await setUserDocumentRef();
    teamsCollectionRef = _userCollectionRef.collection('teams');
    return teamsCollectionRef;
  }

  setAthletesCollectionRef() async {
    if (athletesCollectionRef != null) return athletesCollectionRef;
    DocumentReference _userDocumentRef = await setUserDocumentRef();
    athletesCollectionRef = _userDocumentRef.collection('athletes');
    return athletesCollectionRef;
  }
}
