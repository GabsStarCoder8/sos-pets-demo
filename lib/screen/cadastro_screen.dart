import 'package:flutter/material.dart';
import '../services/auth_service.dart'; // Importamos o serviço que criamos!
import 'home_screen.dart';

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({super.key});

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  static const Color primaryColor = Color(0xFF2D6A9F);

  // 2. Criamos as "Antenas" (Controllers) para capturar os textos
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();

  // Variável para controlar a bolinha de carregamento
  bool _isLoading = false;

  // 3. Função que será chamada ao clicar em "Finalizar"
  void _cadastrar() async {
    // Validação básica: as senhas são iguais?
    if (_senhaController.text != _confirmaSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'As senhas não coincidem!',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return; // Para a execução da função aqui
    }

    // Liga a bolinha de carregamento
    setState(() {
      _isLoading = true;
    });

    // Chama o AuthService para criar a conta lá no Firebase
    String? erro = await AuthService().cadastrarUsuario(
      nome: _nomeController.text
          .trim(), // .trim() tira os espaços em branco no começo e fim
      sobrenome: _sobrenomeController.text.trim(),
      email: _emailController.text.trim(),
      senha: _senhaController.text,
    );

    // Desliga a bolinha de carregamento
    setState(() {
      _isLoading = false;
    });

    if (erro == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    } else {
      // Deu erro (ex: email já existe). Mostra uma faixa vermelha com o erro.
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erro), backgroundColor: Colors.red),
        );
      }
    }
  }

  // 4. É boa prática destruir as antenas quando a tela for fechada
  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo usuário!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Nome',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nomeController, // <-- ANTENA CONECTADA
                decoration: _decoracaoPadrao('Nome...'),
              ),
              const SizedBox(height: 16),

              const Text(
                'Sobrenome',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _sobrenomeController, // <-- ANTENA CONECTADA
                decoration: _decoracaoPadrao('Sobrenome...'),
              ),
              const SizedBox(height: 16),

              const Text(
                'E-mail',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController, // <-- ANTENA CONECTADA
                keyboardType: TextInputType.emailAddress,
                decoration: _decoracaoPadrao('Digite seu E-mail...'),
              ),
              const SizedBox(height: 24),

              const Text(
                'Crie sua senha',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _senhaController, // <-- ANTENA CONECTADA
                obscureText: true,
                decoration: _decoracaoPadrao('Senha...'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmaSenhaController, // <-- ANTENA CONECTADA
                obscureText: true,
                decoration: _decoracaoPadrao('Repita a senha...'),
              ),
              const SizedBox(height: 40),

              // BOTÃO FINALIZAR (Com efeito de carregamento)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  // Se estiver carregando, desativa o botão (null). Se não, chama _cadastrar.
                  onPressed: _isLoading ? null : _cadastrar,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        ) // Bolinha girando
                      : const Text(
                          'Finalizar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Função auxiliar para deixar o código menor e mais limpo
  InputDecoration _decoracaoPadrao(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF5A809E)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.black12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor),
      ),
    );
  }
}
