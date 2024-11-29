import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<Either<String,User?>> signUp({required String email,required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("user ${userCredential.user?.email}");
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("exception ${e.toString()}");
      return Left(e.message ??"Error While registering");
    }
  }

  Future<Either<String,User?>> login({required String email,required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(userCredential.user);
    } on FirebaseAuthException catch (e) {
      print("exception ${e.toString()}");
      return Left(e.message ??"Error While login");
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? get currentUser => _firebaseAuth.currentUser;
}
