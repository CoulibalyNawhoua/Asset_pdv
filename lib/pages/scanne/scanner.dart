import 'dart:io';

import 'package:app_asset_pdv/pages/materiel/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../composants/appbar.dart';
import '../../constantes/constantes.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(title: "Scanner un QR code", onPressed: (){Get.to(const DetailTournePage());}),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        controller.pauseCamera();
        _showConfirmationBottomSheet(scanData.code);
        //  _showConfirmationDialog(result!.code);
        // You can navigate to another page or display the result here
        // Navigator.pop(context, result!.code);
      });
    });
  }

   void _showConfirmationBottomSheet(String? code) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Code scanné avec succès !',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Le code scanné est : $code',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              textButom(
                "Confirmation", () { 
                  Get.snackbar("Confirmation succès", "Matériel livré avec succès.");
                  Get.to(DetailTournePage());
                  // resetScanner(); 
                }
              )
            ],
          ),
        );
      },
    );
  }

  void resetScanner() {
    setState(() {
      result = null;
    });
    controller?.resumeCamera();
  }
  
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Widget textButom(String title,VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor), // Couleur du bouton
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