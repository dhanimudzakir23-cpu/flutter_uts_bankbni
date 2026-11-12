import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const CustomBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = <int, (IconData, IconData, String)>{
    0: (Icons.home_outlined, Icons.home_rounded, 'Beranda'),
    1: (Icons.history_rounded, Icons.history_rounded, 'Riwayat'),
    3: (Icons.star_border_rounded, Icons.star_rounded, 'Favorit'),
    4: (Icons.settings_outlined, Icons.settings_rounded, 'Pengaturan'),
  };

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.of(context).padding.bottom;
    return SizedBox(
      height: 92 + inset,
      child: Stack(children: [
        Positioned(
          left: 0, right: 0, bottom: 0, height: 66 + inset,
          child: Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 204, 75, 75),
              boxShadow: [BoxShadow(color: Color(0x22000000), blurRadius: 12, offset: Offset(0, -2))],
            ),
          ),
        ),
        Positioned(
          left: 0, right: 0, bottom: inset, height: 66,
          child: Row(children: [_item(0), _item(1), const Expanded(child: SizedBox()), _item(3), _item(4)]),
        ),
        Positioned(
          top: 2, left: 0, right: 0,
          child: Center(
            child: GestureDetector(
              onTap: () => onTap(2),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFFF9A3D), AppColors.orange]),
                  border: Border.all(color: Colors.white, width: 5),
                  boxShadow: const [BoxShadow(color: Color(0x40F57C20), blurRadius: 14, offset: Offset(0, 4))],
                ),
                child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 30),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0, right: 0, bottom: inset + 8,
          child: Text('QRIS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: currentIndex == 2 ? AppColors.orange : AppColors.grey)),
        ),
      ]),
    );
  }

  Widget _item(int index) {
    final (outline, filled, label) = _items[index]!;
    final active = currentIndex == index;
    final color = active ? AppColors.orange : AppColors.grey;
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(active ? filled : outline, color: color, size: 26),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11, color: color, fontWeight: active ? FontWeight.w700 : FontWeight.normal)),
        ]),
      ),
    );
  }
}
