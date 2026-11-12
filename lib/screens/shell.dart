import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/core/custom_bottom_nav.dart';
import 'package:bni_mobile_pay/screens/favorites_screen.dart';
import 'package:bni_mobile_pay/screens/history_screen.dart';
import 'package:bni_mobile_pay/screens/home_screen.dart';
import 'package:bni_mobile_pay/screens/qris_screen.dart';
import 'package:bni_mobile_pay/screens/settings_screen.dart';

class Shell extends StatefulWidget {
  const Shell({super.key});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _i = 0;

  Widget _page() {
    switch (_i) {
      case 1:
        return const HistoryScreen();
      case 2:
        return const QrisScreen();
      case 3:
        return const FavoritesScreen();
      case 4:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }

  void _chat() {
    final msgs = <(bool, String)>[(false, 'Halo, Fajar! Ada yang bisa kami bantu?')];
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => SizedBox(
          height: MediaQuery.of(ctx).size.height * 0.6,
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.all(18),
              child: Row(children: [
                Icon(Icons.support_agent_rounded, color: AppColors.orange),
                SizedBox(width: 8),
                Text('Chat Us', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ]),
            ),
            Expanded(
              child: ListView(padding: const EdgeInsets.symmetric(horizontal: 16), children: [
                for (final m in msgs)
                  Align(
                    alignment: m.$1 ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      constraints: const BoxConstraints(maxWidth: 260),
                      decoration: BoxDecoration(
                          color: m.$1 ? AppColors.orange : const Color(0xFFEFF3F6),
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(m.$2, style: TextStyle(color: m.$1 ? Colors.white : AppColors.text)),
                    ),
                  ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              child: Wrap(spacing: 8, children: [
                for (final q in ['Cek saldo', 'Lupa PIN', 'Kartu hilang'])
                  ActionChip(
                    label: Text(q),
                    onPressed: () => setS(() {
                      msgs.add((true, q));
                      msgs.add((false, 'Terima kasih, tim kami akan membantu terkait "$q" (simulasi).'));
                    }),
                  ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        transitionBuilder: (c, a) => FadeTransition(opacity: a, child: c),
        child: KeyedSubtree(key: ValueKey(_i), child: _page()),
      ),
      floatingActionButton: _i == 0
          ? FloatingActionButton.extended(
              heroTag: 'chat',
              onPressed: _chat,
              backgroundColor: AppColors.teal,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.support_agent_rounded),
              label: const Text('Chat Us'),
            )
          : null,
      bottomNavigationBar: CustomBottomNav(currentIndex: _i, onTap: (i) => setState(() => _i = i)),
    );
  }
}
