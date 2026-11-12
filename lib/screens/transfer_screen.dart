import 'package:flutter/material.dart';
import 'package:bni_mobile_pay/core/colors.dart';
import 'package:bni_mobile_pay/core/format.dart';
import 'package:bni_mobile_pay/data/dummy.dart';

class TransferScreen extends StatefulWidget {
  final String? prefill;
  const TransferScreen({super.key, this.prefill});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _dest = TextEditingController(text: widget.prefill ?? '');
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String _bank = 'Sesama BNI MOBILE';

  @override
  void dispose() {
    _dest.dispose();
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final nominal = int.parse(_amount.text);
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Transfer'),
        content: Text('Kirim ${rupiah(nominal)} ke ${_dest.text} ($_bank)?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Batal')),
          FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Kirim')),
        ],
      ),
    );
    if (ok == true) {
      nav.pop();
      messenger.showSnackBar(SnackBar(content: Text('Transfer ${rupiah(nominal)} berhasil (simulasi)')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transfer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: AppColors.teal, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                const Icon(Icons.account_balance_wallet_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Sumber dana', style: TextStyle(color: Colors.white70, fontSize: 11)),
                    Text(rupiah(Dummy.main.balance),
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            const Text('Bank tujuan', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Wrap(spacing: 8, children: [
              for (final b in ['Sesama BNI MOBILE', 'BCA', 'Mandiri', 'BRI'])
                ChoiceChip(label: Text(b), selected: _bank == b, onSelected: (_) => setState(() => _bank = b)),
            ]),
            const SizedBox(height: 16),
            TextFormField(
              controller: _dest,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Nomor rekening tujuan', border: OutlineInputBorder()),
              validator: (v) => (v == null || v.trim().length < 6) ? 'Masukkan nomor tujuan yang valid' : null,
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _amount,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Nominal (Rp)', border: OutlineInputBorder()),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n <= 0) return 'Masukkan nominal yang valid';
                if (n > Dummy.main.balance) return 'Saldo tidak mencukupi';
                return null;
              },
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _note,
              decoration: const InputDecoration(labelText: 'Catatan (opsional)', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: _submit,
                style: FilledButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                child: const Text('Lanjutkan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
