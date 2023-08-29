import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleSignInAccount!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //dptkn firebase id here when I sign in, this one only do when we load into the display

  void signUserInfo() {
    final authUID = FirebaseAuth.instance.currentUser!.uid;
    //check if no data associated with this auth, then baru msukkn
    final collection = FirebaseFirestore.instance.collection("pathUser");
    collection.add({
      "authUID": authUID,
      "name": "",
      "address": "",
      "position": "",
      //files stuff, with map technique
    });
  }
}
