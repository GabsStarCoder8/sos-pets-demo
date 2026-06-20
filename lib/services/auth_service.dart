import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/usuario_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função para cadastrar um novo usuário
  Future<String?> cadastrarUsuario({
    required String nome,
    required String sobrenome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential credencial = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      User? usuarioFirebase = credencial.user;

      if (usuarioFirebase != null) {
        UsuarioModel novoUsuario = UsuarioModel(
          uid: usuarioFirebase.uid,
          nome: nome,
          sobrenome: sobrenome,
          email: email,
          dataCriacao: DateTime.now(),
        );

        await _firestore
            .collection('usuarios')
            .doc(usuarioFirebase.uid)
            .set(novoUsuario.toMap());

        return null;
      }
    } on FirebaseAuthException catch (e) {
      // Tratamento de erros comuns
      if (e.code == 'weak-password') {
        return 'A senha deve ter pelo menos 6 caracteres.';
      } else if (e.code == 'email-already-in-use') {
        return 'Já existe uma conta com este e-mail.';
      } else if (e.code == 'invalid-email') {
        return 'O formato do e-mail é inválido.';
      } else {
        return 'Erro do firebase: ${e.message}';
      }
    } catch (e) {
      return 'Erro desconhecido: $e';
    }
  }

  Future<String?> loginUsuario({
    required String email,
    required String senha,
  }) async {
    try {
      // Tenta fazer o login no cofre do Firebase Auth
      await _auth.signInWithEmailAndPassword(email: email, password: senha);
      return null; // Retorna nulo se deu tudo certo!
    } on FirebaseAuthException catch (e) {
      // O Firebase nos avisa se a senha estiver errada ou a conta não existir
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return 'E-mail ou senha incorretos.';
      } else if (e.code == 'invalid-email') {
        return 'O formato do e-mail é inválido.';
      } else {
        return 'Erro do Firebase: ${e.message}';
      }
    } catch (e) {
      return 'Erro desconhecido: $e';
    }
  }
}
