import 'package:app_asset_pdv/pages/materiel/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../composants/appbar.dart';
import '../constantes/constantes.dart';
import '../fonctions/fonctions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const CAppBarHome(name: "John Doe"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Liste des matériaux",
              style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: AppColors.primaryColor),
            ),
            const SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return MaterielItem(
                    libelle: "libelle", 
                    categorie: "categorie", 
                    modele: "modele", 
                    status: 1, 
                    onPressed: (){Get.to(const DetailTournePage());}
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterielItem extends StatelessWidget {
  final String libelle;
  final String categorie;
  final String modele;
  final int status;
  final VoidCallback onPressed;

  const MaterielItem ({
    super.key,
    required this.libelle,
    required this.categorie,
    required this.modele,
    required this.status,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    switch (status) {
      case 1:
        statusText = "Déployé";
        statusColor = Colors.green;
        break;
      case 2:
        statusText = "Annulé";
        statusColor = Colors.red;
        break;
      default:
        statusText = "En attente";
        statusColor = Colors.yellow.shade900;
        break;
    }
    return InkWell(
      onTap: onPressed,
      // splashColor: const Color.fromARGB(255, 199, 205, 247),
      // highlightColor: Colors.blue.withOpacity(0.2),
      child: Card(
        color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListTile(
                  title: Text(libelle),
                  subtitle: Text(categorie,style: const TextStyle(fontSize: 12.0),),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Text(statusText,style: TextStyle(color: statusColor, fontSize: 14.0)),
                  subtitle: Text(modele,style: const TextStyle(fontSize: 12.0),),
                )
              ),
               const Icon(Icons.navigate_next),
            ],
          ),
      ),
    );
  }
}


