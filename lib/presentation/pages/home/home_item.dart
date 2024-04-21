import 'package:flutter/material.dart';
import 'package:getx_clean_arch/app_colors.dart';

class HomeItem extends StatelessWidget {
  final String? name;
  final String? email;
  final String? imageUrl;

  const HomeItem({
    super.key,
    this.name,
    this.email,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      surfaceTintColor: AppColors.colorWhite,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Text(name ?? ""),
              const SizedBox(
                height: 5,
              ),
              Text(email ?? "")
            ],
          ),
        ),
      ),
    );
  }
}
