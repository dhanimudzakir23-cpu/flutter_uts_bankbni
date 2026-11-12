import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/core/format.dart';
import 'package:bni_mobile_pay/data/dummy.dart';

class BalanceCard extends StatefulWidget {
  const BalanceCard({super.key});

  @override
  State<BalanceCard> createState() => _BalanceCardState();
}

class _BalanceCardState extends State<BalanceCard> {
  bool _hidden = true;
  bool _expanded = false;

  String _money(int v) => _hidden ? 'Rp *******' : rupiah(v);

  Future<void> _copy(String number) async {
    final messenger = ScaffoldMessenger.of(context);
    await Clipboard.setData(ClipboardData(text: number));
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Nomor rekening $number disalin')));
  }

  @override
  Widget build(BuildContext context) {
    const a = Dummy.main;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 14, 12, 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        gradient: const LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.teal, AppColors.tealDark]),
        boxShadow: const [BoxShadow(color: Color(0x330B8DA0), blurRadius: 16, offset: Offset(0, 6))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: FittedBox(
                key: ValueKey(_hidden),
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(_money(a.balance),
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
          IconButton(
            tooltip: _hidden ? 'Tampilkan saldo' : 'Sembunyikan saldo',
            onPressed: () => setState(() => _hidden = !_hidden),
            icon: Icon(_hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.white),
          ),
        ]),
        Row(children: [
          Text(a.number, style: const TextStyle(fontSize: 18, color: Colors.white, letterSpacing: 0.5)),
          const SizedBox(width: 8),
          InkWell(
            onTap: () => _copy(a.number),
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: Icon(Icons.copy_rounded, size: 20, color: Colors.white),
            ),
          ),
        ]),
        Row(children: [
          Expanded(
            child: Text(a.label,
                style: const TextStyle(fontSize: 13, color: Colors.white70, letterSpacing: 0.8)),
          ),
          IconButton(
            onPressed: () => setState(() => _expanded = !_expanded),
            icon: AnimatedRotation(
              turns: _expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 250),
              child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 30),
            ),
          ),
        ]),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(right: 8, bottom: 8),
                  child: Column(children: [
                    for (final o in Dummy.others) ...[
                      const Divider(color: Colors.white24, height: 16),
                      Row(children: [
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(o.label,
                                style: const TextStyle(fontSize: 12, color: Colors.white70, letterSpacing: 0.6)),
                            Text(o.number, style: const TextStyle(fontSize: 14, color: Colors.white)),
                          ]),
                        ),
                        Text(_money(o.balance),
                            style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)),
                      ]),
                    ],
                  ]),
                )
              : const SizedBox(width: double.infinity),
        ),
      ]),
    );
  }
}
