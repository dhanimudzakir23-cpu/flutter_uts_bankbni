import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/data/dummy.dart';

class PromoCarousel extends StatefulWidget {
  final ValueChanged<Promo> onTap;
  const PromoCarousel({super.key, required this.onTap});

  @override
  State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  final _pc = PageController();
  int _page = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_pc.hasClients) return;
      final next = (_page + 1) % Dummy.promos.length;
      _pc.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 160,
        child: PageView.builder(
          controller: _pc,
          itemCount: Dummy.promos.length,
          onPageChanged: (i) => setState(() => _page = i),
          itemBuilder: (_, i) {
            final p = Dummy.promos[i];
            return GestureDetector(
              onTap: () => widget.onTap(p),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight, colors: p.colors),
                ),
                child: Row(children: [
                  Expanded(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(p.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                          const SizedBox(height: 6),
                          Text(p.subtitle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12, height: 1.35, color: Colors.white70)),
                        ]),
                  ),
                  const SizedBox(width: 12),
                  Icon(p.icon, size: 72, color: Colors.white38),
                ]),
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 10),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        for (var i = 0; i < Dummy.promos.length; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: _page == i ? 22 : 7,
            height: 7,
            decoration: BoxDecoration(
                color: _page == i ? AppColors.orange : AppColors.line,
                borderRadius: BorderRadius.circular(4)),
          ),
      ]),
    ]);
  }
}
