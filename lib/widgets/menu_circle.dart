import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/data/dummy.dart';

class MenuCircle extends StatelessWidget {
  final MenuData? data; // null = tombol "Menu Lain"
  final VoidCallback onTap;
  const MenuCircle({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final d = data;
    return InkWell(
      borderRadius: BorderRadius.circular(0),
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          width: 62,
          height: 62,
          decoration: d == null
              ? BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.line, width: 1.5))
              : BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: d.colors),
                ),
          child: d == null
              ? const Icon(Icons.more_horiz_rounded, color: AppColors.orange, size: 30)
              : Icon(d.icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(d?.label ?? 'Menu Lain',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, height: 1.2, color: AppColors.text)),
      ]),
    );
  }
}
