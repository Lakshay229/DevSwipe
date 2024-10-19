import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jobify/models/project_model.dart';
import 'package:jobify/models/user_model.dart';

const String USER_COLLECTION_REF = "Users";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;
  late final CollectionReference _userRef;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  DatabaseService() {
    _userRef =
        _firestore.collection(USER_COLLECTION_REF).withConverter<UserModel>(
            fromFirestore: (snapshots, _) => UserModel.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (user, _) => user.toJson());
  }

  Stream<DocumentSnapshot<UserModel>> getUserDetails(String userId) {
    return _userRef
        .doc(userId)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson(),
        )
        .snapshots();
  }

  Future<String> uploadReadmeFile(String userId, String readmeContent) async {
    try {
      // Create a reference to the Firebase Storage location
      final ref = _storage.ref().child('profileReadme').child('$userId.md');

      // Upload the .md file
      await ref.putString(readmeContent);

      // Get the download URL of the uploaded file
      String downloadUrl = await ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      throw Exception("Failed to upload ReadMe file: $e");
    }
  }
  void addUser(UserModel userDetails, User? user) async {
    await _userRef.doc(user!.uid).set(userDetails);
  }

  Future<void> addProjectToUser(String userId, ProjectModel project) async {
    try {
      final userDocRef = _userRef.doc(userId);

      await _firestore.runTransaction((transaction) async {
        final userSnapshot = await transaction.get(userDocRef);

        if (userSnapshot.exists) {
          final userModel = userSnapshot.data() as UserModel;

          final updatedProjects = userModel.projects ?? {};
          updatedProjects[project.projectName] = project;

          final updatedNumberProjects = userModel.numberProjects + 1;

          transaction.update(userDocRef, {
            'Projects': updatedProjects.map((key, value) => MapEntry(key, value.toJson())),
            'NumberProjects': updatedNumberProjects,
          });
        } else {
          // Handle case where user does not exist
          throw Exception("User does not exist.");
        }
      });
    } catch (e) {
      throw Exception("Failed to add project: $e");
    }
  }



  Future<void> updateUserDetails(String userId, Map<String, Object?> updatedData) async {
    await _userRef.doc(userId).update(updatedData);
  }


}
