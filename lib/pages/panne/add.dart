import 'dart:io';

import 'package:app_asset_pdv/pages/panne/list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../composants/appbar.dart';
import '../../composants/button.dart';
import '../../constantes/constantes.dart';

class AddPannePage extends StatefulWidget {
  const AddPannePage({super.key});

  @override
  State<AddPannePage> createState() => _AddPannePageState();
}

class _AddPannePageState extends State<AddPannePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  List<File> images = [];  // Liste pour stocker les images sélectionnées


  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    if (source == ImageSource.gallery) {
      final List<XFile>? pickedFiles = await picker.pickMultiImage();
      if (pickedFiles != null) {
        setState(() {
          if (images.length + pickedFiles.length <= 4) {
            images.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
          } else {
            Get.snackbar("Limite atteinte", "Vous ne pouvez ajouter que 4 photos.");
          }
        });
      }
    } else {
      final XFile? pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          if (images.length < 4) {
            images.add(File(pickedFile.path));
          } else {
            Get.snackbar("Limite atteinte", "Vous ne pouvez ajouter que 4 photos.");
          }
        });
      }
    }
    // final getImages = await picker.pickImage(source: source);

    // if (getImages != null) {
    //   setState(() {
    //     if (images.length < 4) {
    //       images.add(File(getImages.path));
    //     } else {
    //       Get.snackbar("Limite atteinte", "Vous ne pouvez ajouter que 4 photos.");
    //     }
    //   });
    // }
  }

  void _showPicker(TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galerie'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Caméra'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void saveForm() {
    if (formKey.currentState!.validate()) {
      String description = descriptionController.text;
      List<File> selectedImages = images;

      // Print description and file paths for debugging
      print('Description: $description');
      print('Images:');
      for (var image in selectedImages) {
        print(image.path);
      }

      Get.snackbar("Formulaire envoyé", "Votre description et vos images ont été envoyées.");
    }
    _clearForm();
  }
    void _clearForm() {
    setState(() {
      descriptionController.clear();
      imageController.clear();
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(title: "Ajouter une pannes", onPressed: (){Get.to(const ListPannePage());}),
       body: SingleChildScrollView(
        child: Center(
          child: _form()
        ),
      ),
    );
  }
  Widget _form() {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.primaryColor)
    );

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    // hintText: "Description",
                    labelText: "Entrer une description",
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: border,
                    enabledBorder: border,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer une description";
                    }
                    return null;
                    },
                ),
              ),
              textButom("Ajouter une photo", () { _showPicker(imageController);}),
              _buildImageGrid(),
              // ElevatedButton(
              //   onPressed: _pickImage,
              //   child: Text("Ajouter une photo"),
              // ),
              const SizedBox(height: 50),
              // Obx(() {
              //   return CButton(
              //     title: "SOUMETTRE",
              //     isLoading: demandeController.isLoading.value,
              //     onPressed: () async {saveForm();},
              //   );
              // }),
              CButton(
                title: "ENREGISTRER", 
                onPressed: (){
                  saveForm();
                  // Get.to(const ListPannePage());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildImageGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Image.file(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget textButom(String title,VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor), // Couleur du bouton
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