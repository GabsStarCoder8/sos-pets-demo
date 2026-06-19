import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sos_pets_demo/screen/home_screen.dart';

class ReviewPetScreen extends StatelessWidget {
  const ReviewPetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D6A9F);
    const Color lightBlue = Color(0xFFABCBE5);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // 1. CABEÇALHO AZUL CLARO
            // ==========================================
            Container(
              height: 260,
              width: double.infinity,
              color: lightBlue,
              child: SafeArea(
                child: Stack(
                  children: [
                    // Botão Voltar
                    Positioned(
                      top: 10,
                      left: 10,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context); // Volta para a tela de edição
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: primaryColor,
                          size: 18,
                        ),
                        label: const Text(
                          'Voltar',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Ícone da Pata Gigante (Aqui não tem o ícone de câmera da tela anterior)
                    Center(
                      child: SvgPicture.asset(
                        'assets/icons/paw-big-home.svg',
                        height: 140,
                        colorFilter: ColorFilter.mode(
                          primaryColor.withOpacity(0.5),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ==========================================
            // 2. RESUMO DOS DADOS (FORMULÁRIO DE LEITURA)
            // ==========================================
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //função auxiliar para montar os dados
                  _buildInfoItem('Nome do Animal', 'nome...'),
                  const SizedBox(height: 24),

                  _buildInfoItem('Especie do Animal', 'especie...'),
                  const SizedBox(height: 24),

                  _buildInfoItem('Data de Nascimento', 'DD/MM/AA'),
                  const SizedBox(height: 24),

                  _buildInfoItem('Descrição', 'subtitle'),
                  const SizedBox(height: 40),

                  // Botão avançar
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
                        // Aqui no futuro será a ação de "Salvar no Banco de Dados"
                        print('Pet cadastrado com sucesso!');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Avançar',
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
          ],
        ),
      ),
    );
  }

  //Função auxiliar para padronizar os textos de revisão
  Widget _buildInfoItem(String titulo, String valorDigitado) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            color: Color(0xFF2D6A9F),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          valorDigitado,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
