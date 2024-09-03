import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthBlocState> {
  late String username;
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginBlocLoading());
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          username = userCredential.user!.displayName ?? 'username';
          emit(LoginBlocSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'invalid-credential') {
            emit(LoginBlocFailure('wrong email or password !'));
          } else {
            emit(LoginBlocFailure('something went wrong !'));
          }
          return Future.error(e.message.toString());
        }
      }
    });
  }
}
