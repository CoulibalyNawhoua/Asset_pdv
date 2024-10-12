import 'package:flutter/material.dart';

import '../constantes/constantes.dart';
import '../fonctions/fonctions.dart';

class CAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  final String name;

  const CAppBarHome({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: AppColors.primaryColor,
          child: Text(
            getInitials(name),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.logout,
          color: AppColors.primaryColor,
        )
        ),
      ],
      automaticallyImplyLeading: false,

    );
    // return AppBar(
    //   backgroundColor: Colors.white,
    //   title: CircleAvatar(
    //     backgroundColor: AppColors.primaryColor,
    //     child: Text(
    //       getInitials(name),
    //       style: const TextStyle(
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    //   automaticallyImplyLeading: false,
    // );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onPressed;

  const CAppBar({
    super.key,
    required this.title,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      // elevation: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      // automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back,color: AppColors.primaryColor,),
        onPressed: onPressed,
        // onPressed: () {
        //   Get.back();
        // },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
