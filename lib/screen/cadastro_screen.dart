import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  const CadastroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando a mesma cor azul padrão do seu app
    const Color primaryColor = Color(0xFF2D6A9F);

    return Scaffold(
      backgroundColor: Colors.white,
      // O AppBar vazio com cor de fundo branca e elevação zero serve apenas
      // para colocar automaticamente a "setinha de voltar" no topo da tela!
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // Diferente da tela de login onde tudo era centralizado,
            // aqui nós alinhamos os itens à esquerda (start) por causa dos títulos (Nome, Sobrenome, etc)
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. TÍTULO
              const Text(
                'Novo usuário!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 30),

              // 2. CAMPO: NOME
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
                decoration: InputDecoration(
                  hintText: 'Nome...',
                  hintStyle: const TextStyle(color: Color(0xFF5A809E)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 3. CAMPO: SOBRENOME
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
                decoration: InputDecoration(
                  hintText: 'Sobrenome...',
                  hintStyle: const TextStyle(color: Color(0xFF5A809E)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 4. CAMPO: E-MAIL
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
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Digite seu E-mail...',
                  hintStyle: const TextStyle(color: Color(0xFF5A809E)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // 5. CAMPO: SENHA E CONFIRMAR SENHA
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
                obscureText: true, // Esconde o texto
                decoration: InputDecoration(
                  hintText: 'Senha...',
                  hintStyle: const TextStyle(color: Color(0xFF5A809E)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                obscureText: true, // Esconde o texto
                decoration: InputDecoration(
                  hintText: 'Repita a senha...',
                  hintStyle: const TextStyle(color: Color(0xFF5A809E)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // 6. BOTÃO FINALIZAR
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
                  onPressed: () {
                    // Ação de finalizar o cadastro
                  },
                  child: const Text(
                    'Finalizar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ), // Um espacinho extra no final para o scroll ficar confortável
            ],
          ),
        ),
      ),
    );
  }
}
