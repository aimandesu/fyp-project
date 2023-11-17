import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyp_project/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

  signInWithEmail(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  signUpEmail(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //dptkn firebase id here when I sign in, this one only do when we load into the display

  //do some void to check first if userinfo is available or not, if available skip
  //this sign userinfo

  Future<bool> checkUserHasSignedBefore() async {
    //check with firebase if the stuff availabel or not then return true or false

    final authUID = FirebaseAuth.instance.currentUser!.uid;
    final collection = FirebaseFirestore.instance.collection("community");

    final result = collection.where("authUID", isEqualTo: authUID).get().then(
        (value) => value.docs.isNotEmpty); //if ada return true = isNotEmpty

    return result;
  }

  void signUserInfo() async {
    final result = await checkUserHasSignedBefore();
    String? fcmToken = await FirebaseMessaging.instance.getToken();

    if (!result) {
      final authUID = FirebaseAuth.instance.currentUser!.uid;
      //check if no data associated with this auth, then baru msukkn
      final collection = FirebaseFirestore.instance.collection("community");

      final Map<String, String> communityAt = {
        'district': '',
        'place': '',
        'postcode': '',
        'subDistrict': '',
      };

      final Map<String, String> identificationImage = {
        'back': '',
        'front': '',
      };

      final userModel = UserModel(
        communityAt: communityAt,
        identificationImage: null,
        identificationNo: '',
        name: '',
        authUID: authUID,
      );

      await collection
          .add(
        userModel.toJson(identificationImage),
      )
          .then((value) {
        collection.doc(value.id).update({
          'userUID': value.id,
          'fcmToken': fcmToken,
          'verified': false,
        });
      });
    }
  }
}
