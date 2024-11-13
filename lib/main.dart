import 'package:bugiganga/FIRESTORE/firestore.dart';
import 'package:bugiganga/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bugiganga',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Teste(),
    );
  }
}

class Teste extends StatelessWidget {
  const Teste({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => FirestoreApi().addDB(
                    Colecao.cidades,
                    "teste",
                    Cidade(
                      nome: "Teste",
                      estado: 'Teste2',
                      ddi: 12,
                      regioes: [],
                    )),
                child: const Text("Adicionar"),
              ),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('cidades')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return ListView(
                      children: snapshot.data!.docs
                          .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return ListTile(
                              title: Text(data['nome']),
                            );
                          })
                          .toList()
                          .cast(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
