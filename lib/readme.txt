    FIREBASE CORE

#1 - Adicionar "firebase_core" em pubspec.yaml arquivo.

#2 - Instalar Node.js.

#3 - Em um CMD Admin, executar "npm install -g firebase-tools".

#4 - Em um CMD Admin, executar "firebase login" e entrar com e-mail.

#5 - Em um CMD Admin, executar "dart pub global activate flutterfire_cli".

#6 - Adicionar nas variaveis de ambiente, "C:\Users\%user%\AppData\Local\Pub\Cache\bin" e reiniciar a maquina.

#7 - Executar "flutterfire configure" no diretorio do projeto e seguir passo a passo, cuidar com o package, 
     seguir build.gradle arquivo.

#8 - Adicionar,
                await Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                ); em main.dart arquivo.
