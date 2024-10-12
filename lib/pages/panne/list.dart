import 'package:app_asset_pdv/composants/appbar.dart';
import 'package:app_asset_pdv/pages/materiel/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import 'add.dart';
import 'detail.dart';

class ListPannePage extends StatefulWidget {
  const ListPannePage({super.key});

  @override
  State<ListPannePage> createState() => _ListPannePageState();
}

class _ListPannePageState extends State<ListPannePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(title: "Liste des pannes", onPressed: (){Get.to(const DetailTournePage());}),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textButom("Ajouter une panne", () {Get.to(const AddPannePage()); }),
            const SizedBox(height: 20.0,),
            Expanded(
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return PanneItem(
                    libelle: "libelle", 
                    categorie: "categorie", 
                    modele: "modele", 
                    status: 1, 
                    onPressed: (){Get.to(const DetailPannePage());}
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget textButom(String title,VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Couleur du bouton
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
      child: Text(title,style: const TextStyle(fontSize: 12.0), )
    );
  }
}

class PanneItem extends StatelessWidget {
  final String libelle;
  final String categorie;
  final String modele;
  final int status;
  final VoidCallback onPressed;

  const PanneItem ({
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


