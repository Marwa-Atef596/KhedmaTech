import 'package:flutter/material.dart';
import 'package:khedma_tech/core/constent.dart';

class OurCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OurCustomAppBar(
      {super.key, required this.label, required this.hasLeading});

  final String label;
  final bool hasLeading;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: AppBar(
          title: Text(
            label,
            textDirection: TextDirection.rtl,
            style: txtstyle2,
          ),
          surfaceTintColor: Colors.transparent,
          leading: hasLeading == true ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.blue,
              size: 34,
            ),
            onPressed: () {
             Navigator.pop(context);
              //GoRouter.of(context).pop();
            },
          ) : null,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(66);
}
