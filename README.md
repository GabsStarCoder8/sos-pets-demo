# 📋 Pré-requisitos
Antes de começar, certifique-se de ter instalado no novo computador:

- Git → para clonar o repositório
- Flutter SDK → para rodar o aplicativo
- Android Studio ou VS Code → para editar e rodar o app

Emulador Android configurado ou celular conectado via USB com Depuração USB ativada

33 💡 Dica: Para verificar se o Flutter está instalado corretamente, rode no terminal:
flutter doctor

# 🔽 Passo 1: Clonar o Repositório
No terminal, vá até a pasta onde deseja salvar o projeto e rode:

- git clone https://github.com/SEU_USUARIO/sos-pets-demo.git

⚠️ Substitua SEU_USUARIO pela sua conta correta do GitHub.

## 📂 Passo 2: Acessar a Pasta do Projeto

- cd sos-pets-demo

## 📦 Passo 3: Instalar Dependências do Flutter
O Git não baixa as bibliotecas pesadas do Flutter (elas ficam no .gitignore). Para instalar tudo o que o projeto precisa:

- flutter pub get

## 🔑 Passo 4: Conectar ao Firebase

Se tentar rodar o app agora, provavelmente verá uma tela vermelha de erro. Isso acontece porque o Firebase ainda não está configurado localmente.
Faça login no Firebase pelo terminal:

- firebase login

Configure o projeto com o FlutterFire CLI:

- flutterfire configure

Selecione o projeto sos-pets-demo na lista usando as setas do teclado e pressione Enter.
O CLI vai gerar os arquivos de configuração (firebase_options.dart) automaticamente.

💡 Caso não tenha o FlutterFire CLI instalado, rode:

dart pub global activate flutterfire_cli

# ▶️ Passo 5: Rodar o Aplicativo
Com tudo configurado, abra o emulador Android ou conecte o celular via cabo e rode:

- flutter run

# 🛠️ Dicas Extras
Para rodar em modo release (mais rápido e otimizado):

flutter run --release
Para limpar cache e evitar erros de build:

- flutter clean
- flutter pub get

Se usar VS Code, instale as extensões:

- Flutter

- Dart

📚 Recursos Úteis
- https://docs.flutter.dev/?utm_source=copilot.com
- https://firebase.flutter.dev/docs/cli/?utm_source=copilot.com
