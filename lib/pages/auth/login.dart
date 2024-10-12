import 'package:app_asset_pdv/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../composants/button.dart';
import '../../composants/passxord-input.dart';
import '../../composants/text-input.dart';
import '../../constantes/constantes.dart';
import '../../fonctions/fonctions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isObscurityText = true;



  void submit() async {
    if (_formKey.currentState!.validate()) {
      String phone = phoneController.text;
      String password = passwordController.text;
      // await authenticateController.login(phone: phone, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(child: SingleChildScrollView(child: _page())),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextInput(
                    inputType: TextInputType.phone, 
                    hint: "Entrez votre numero de téléphone", 
                    icon: Icons.phone, 
                    controller: phoneController, 
                    validator: validatePhone,
                  ),
                  const SizedBox(height: 20),
                  PasswordInput(
                    inputType: TextInputType.text, 
                    hint: "Entrez votre mot de passe", 
                    icon: Icons.lock, 
                    controller: passwordController, 
                    validator: validatePassword
                  ),
                  const SizedBox(height: 50),
                  CButton(
                    title: "CONNEXION",
                    // isLoading: authenticateController.isLoading.value,
                    onPressed: () {
                      // submit();
                      Get.to(const HomePage(),);
                    },
                  ),
                  
                  
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        shape: BoxShape.circle),
      child: const Icon(Icons.person, color: Colors.white, size: 120),
    );
  }

}