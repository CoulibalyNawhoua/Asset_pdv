import 'package:app_asset_pdv/pages/home.dart';
import 'package:app_asset_pdv/pages/scanne/scanner.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../composants/appbar.dart';
import '../../constantes/constantes.dart';
import '../panne/detail.dart';

class DetailTournePage extends StatefulWidget {
  const DetailTournePage({super.key});

  @override
  State<DetailTournePage> createState() => _DetailTournePageState();
}

class _DetailTournePageState extends State<DetailTournePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(
        title: "Détails du matériel",
        onPressed: (){
          Get.to(const HomePage());
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textButom("Scanner", () { Get.to(const ScannerPage()); }),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ElevatedButton(
              //       onPressed: () {
              //         Get.to(const ListPannePage());
              //       },
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor,),
              //         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              //         ),
              //         padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10.0,),),
              //       ),
              //       child: const Text("Liste des pannes"),
              //     ),
              //     ElevatedButton(
              //       onPressed: () {
              //         Get.to(const ScannerPage());
              //       },
              //       style: ButtonStyle(
              //         backgroundColor: MaterialStateProperty.all<Color>(Colors.blue,),
              //         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              //         ),
              //         padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(10.0,),),
              //       ),
              //       child: const Text("Scanner"),
              //     ),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Information du matériel",style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20.0,),
                    buildRowItem("Numero de série:", "A3949403"),
                    const SizedBox(height: 10.0,),
                    buildRowItem("Categorie du materiel:", "Frigo"),
                    const SizedBox(height: 10.0,),
                    buildRowItem("Marque du materiel:", "ILUX"),
                    const SizedBox(height: 10.0,),
                    buildRowItem("Model du materiel:", "CX-111"),
                    const SizedBox(height: 10.0,),
                    buildRowItemStatus("Status", 1),
                    const SizedBox(height: 20.0,),
                    buildRowItemImage("Image du materiel:", "assets/images/frigo.jpg"),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Liste des pannes",style: TextStyle(fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10.0,),
                    SizedBox(
                      height: 400.0,
                      child: ListView.builder(
                        itemCount: 52,
                        itemBuilder: (context, index) {
                          return PanneItem(
                            code: "A3949403", 
                            date: "05-07-2024", 
                            status: 1, 
                            onPressed: (){Get.to(const DetailPannePage());}
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildRowItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
  Widget buildRowItemImage(String title, String image) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Image.asset(image,width: 100, height: 100,fit: BoxFit.cover,)
        // image.isNotEmpty
        //   ? Image.network(
        //       "${Api.imageUrl}${image}",
        //       width: 100,
        //       height: 100,
        //       fit: BoxFit.cover,
        //     )
        //   : Text('Image non disponible'),
      ],
    );
  }

  Widget buildRowItemStatus(String title, int value) {
    String statusText;
    Color statusColor;

    switch (value) {
      case 1:
        statusText = "Livré";
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        Text(
          statusText,
          style: TextStyle(color: statusColor),
        )
      ],
    );
  }
  Widget textButom(String title, VoidCallback onPressed) {
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
      child: Text(title, )
    );
  }
}

class PanneItem extends StatelessWidget {
  final String code;
  final String date;
  // final DateTime date;
  final int status;
  final VoidCallback onPressed;

  const PanneItem ({
    super.key,
    required this.code,
    required this.date,
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(code),
                    Text(date,style: const TextStyle(fontSize: 10.0),),
                  ],
                ),
                Text(statusText,style: TextStyle(color: statusColor, fontSize: 14.0)),
                //  const Icon(Icons.navigate_next),
              ],
            ),
          ),
      ),
    );
  }
}


