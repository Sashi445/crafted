import 'package:crafted/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {

  FirebaseAuth auth = FirebaseAuth.instance;

  User userFromFirebase(FirebaseUser user) {
    return user != null ? User(
        uid: user.uid,
        displayName: user.displayName,
        photoUrl: user.photoUrl,
        email: user.email
    ) : null;
  }

  Stream get isSignedIn => auth.onAuthStateChanged.map(userFromFirebase);


  Future<User> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken
      );
      final authResult = await auth.signInWithCredential(credential);
      FirebaseUser user = authResult.user;
      return userFromFirebase(user);
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<User> getCurrentUser() async{
    try{
      FirebaseUser user = await auth.currentUser();
      return userFromFirebase(user);
    }catch(e){
      throw Exception('FAILED TO GET USER $e');
    }
  }

  Future signOut() async{
    try{
      auth.signOut();
      print('SIGNED OUT!!');
    }catch(e){
      throw Exception('FAILED TO SIGN IN WITH $e');
    }
  }

}