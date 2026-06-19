import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cadastro_pet_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF2D6A9F);
    const Color lightBlue = Color(0xFFABCBE5); //azul escuro

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: lightBlue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),

                  child: Stack(
                    children: [
                      const Align(
                        alignment: Alignment.center,

                        child: Text(
                          'Olá, usuário!',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //icon paw
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.white.withOpacity(0.4),
                                highlightColor: Colors.white.withOpacity(0.1),
                                onTap: () {
                                  print('Click paw');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/paw-icon.svg',
                                    height: 28,
                                  ),
                                ),
                              ),
                            ),

                            //espaço entre icons
                            const SizedBox(width: 12),

                            //icons person
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                splashColor: Colors.white.withOpacity(0.4),
                                highlightColor: Colors.white.withOpacity(0.1),
                                onTap: () {
                                  print('Click person');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: SvgPicture.asset(
                                    'assets/icons/person-icon.svg',
                                    height: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //Fundo branco
                Expanded(
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/paw-big-home.svg',
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),

            //Barra de pesquisa
            Positioned(
              top: 115,
              left: 24,
              right: 24,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    //lupa icon
                    prefixIcon: const Padding(
                      padding: EdgeInsetsGeometry.all(12.0),
                      child: Icon(Icons.search, color: Colors.grey, size: 28),
                    ),
                    hintText: 'Pesquisar por raça, cor ou local...',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      //navbar de navegação
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: lightBlue,
        showSelectedLabels: false,
        showUnselectedLabels: false,

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/home-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),

          //Icone de add dog
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/add-dog.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/add-dog.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'AddDog',
          ),

          //Icone de localização
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/icon-loc.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/add-dog.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Localização',
          ),

          //Icone de mensagem
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/send-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(lightBlue, BlendMode.srcIn),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/send-icon.svg',
              height: 26,
              colorFilter: const ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Send',
          ),
        ],
        onTap: (int index) {
          // O Flutter avisa qual botão foi clicado através desse 'index'
          if (index == 1) {
            // Se o index for 1 (AddDog), abre a tela de cadastro!
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CadastroPetScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}
