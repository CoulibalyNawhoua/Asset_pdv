import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../composants/appbar.dart';
import '../../constantes/constantes.dart';

class DetailPannePage extends StatefulWidget {
  const DetailPannePage({super.key});

  @override
  State<DetailPannePage> createState() => _DetailPannePageState();
}

class _DetailPannePageState extends State<DetailPannePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(title: "Détail de la panne", onPressed: (){Get.back();}),
    );
  }
}