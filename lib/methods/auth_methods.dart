import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rides_n_bikes/rnb_Screens/ProfileScreen/Profile/ProfilePic/default_profile_image.dart';
import 'package:rides_n_bikes/rnb_Models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Funktion zum Abrufen der Benutzerdetails aus der Datenbank

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot snap = await _firestore.collection('Users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
  }

  // Funktion zur Benutzerregistrierung

  Future<String> signUpUser({
    required String email,
    required String password,
    required String confirmPw,
    required String username,
  }) async {
    String res = 'Some error occurred';
    print(res);
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && password == confirmPw) {
        // Überprüfen, ob der Benutzername bereits vergeben ist
        bool isUsernameTaken = await isUsernameExists(username);
        if (isUsernameTaken) {
          return 'Username is already taken. Please choose a different username.';
        }

        // Benutzer registrieren
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // Benutzer zur Datenbank hinzufügen
        await createUserDocument(userCredential, email, username);

        res = 'success'; // Erfolgreiche Registrierung
        print(res);
      } else {
        if (password != confirmPw) {
          res = 'Passwords don\'t match. Please make sure your password and confirm password are the same.';
          print(res);
        } else {
          res = 'Please fill in all the required fields.';
          print(res);
        }
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          res = 'The email address is already in use. Please use a different email.';
          print(res);
          break;
        case 'invalid-email':
          res = 'Invalid email address.';
          print(res);
          break;
        case 'weak-password':
          res = 'The password provided is too weak. Please choose a stronger password.';
          print(res);
          break;
        default:
          res = 'Authentication failed. Please check your credentials and try again.';
          print(res);
          break;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Funktion zum Überprüfen, ob der Benutzername bereits in der Datenbank vorhanden ist

  Future<bool> isUsernameExists(String username) async {
    QuerySnapshot querySnapshot = await _firestore.collection('Users').where('username', isEqualTo: username).get();
    return querySnapshot.docs.isNotEmpty;
  }

  // Funktion zum Erstellen des Benutzerdokuments in der Datenbank

  Future<void> createUserDocument(UserCredential userCredential, String email, String username) async {
    try {
      model.User user = model.User(
        email: email,
        username: username,
        name: username,
        bio: 'Hello, my name is $username and I am new to this app.',
        profileImageUrl: defaultProfileImageUrl,
        uid: userCredential.user!.uid,
        followers: [],
        following: [],
      );

      await _firestore.collection('Users').doc(userCredential.user!.uid).set(
            user.toJson(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  // Funktion zum Einloggen des Benutzers

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some error occurred';
    print(res);
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = 'success';
        print(res);
      } else {
        res = 'Please enter all the fields';
        print(res);
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          res = 'Invalid email address';
          break;
        case 'user-not-found':
          res = 'User not found. Please check your email address.';
          break;
        case 'wrong-password':
          res = 'Invalid password. Please try again.';
          break;
        case 'user-disabled':
          res = 'User account has been disabled.';
          break;
        case 'too-many-requests':
          res = 'Too many login attempts. Please try again later.';
          break;
        case 'operation-not-allowed':
          res = 'Login is currently not allowed. Please contact support.';
          break;
        default:
          res = 'Authentication failed. Please check your credentials and try again.';
          break;
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Funktion zum Abmelden des Benutzers

  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Funktion zum Aktualisieren des Benutzerprofils

  Future<String> updateUserProfile({
    required String newName,
    required String newUsername,
    required String newBio,
  }) async {
    String res = 'Some error occurred';
    print(res);

    try {
      User currentUser = _auth.currentUser!;
      DocumentReference userDocRef = _firestore.collection('Users').doc(currentUser.uid);

      // Überprüfen, ob der neue Benutzername bereits vergeben ist
      bool isUsernameTaken = await isUsernameExists(newUsername);
      if (isUsernameTaken) {
        return 'Username is already taken. Please choose a different username.';
      }

      // Benutzerdaten in der Datenbank aktualisieren
      await userDocRef.update({
        'name': newName,
        'username': newUsername,
        'bio': newBio,
      });

      // Benutzername in den Beiträgen des Benutzers aktualisieren
      QuerySnapshot userPosts = await _firestore.collection('posts').where('uid', isEqualTo: currentUser.uid).get();
      for (QueryDocumentSnapshot postDoc in userPosts.docs) {
        String postId = postDoc.id;
        await _firestore.collection('posts').doc(postId).update({
          'username': newUsername,
        });

        // Benutzername in den Kommentaren zu jedem Beitrag aktualisieren
        QuerySnapshot postComments = await _firestore.collection('posts').doc(postId).collection('comments').where('uid', isEqualTo: currentUser.uid).get();
        for (QueryDocumentSnapshot commentDoc in postComments.docs) {
          String commentId = commentDoc.id;
          await _firestore.collection('posts').doc(postId).collection('comments').doc(commentId).update({
            'username': newUsername,
          });
        }
      }

      res = 'success'; // Benutzerprofil erfolgreich aktualisiert
      print(res);
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
