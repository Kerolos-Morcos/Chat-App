import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  late String username;
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      username = userCredential.user!.displayName ?? 'username';
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        emit(LoginFailure('wrong email or password !'));
      } else {
        emit(LoginFailure('something went wrong !'));
      }
      return Future.error(e.message.toString());
    }
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String username}) async {
    var auth = FirebaseAuth.instance;
    try {
      emit(RegisterLoading());
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = userCredential.user!;
      await user.updateDisplayName(username);
      // final firestore = FirebaseFirestore.instance;
      // final docRef = firestore.collection('users').doc(user.uid);
      // docRef.set({
      //   'username': username,
      //   'email': user.email,
      // });
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure('The password provided is too weak !'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure('The account already exists for that email !'));
      } else {
        emit(RegisterFailure('Sorry, an error occurred !'));
      }
      return Future.error(e.toString());
    }
  }
}
