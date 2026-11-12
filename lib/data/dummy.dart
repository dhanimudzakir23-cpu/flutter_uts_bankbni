import 'package:flutter/material.dart';

class Txn {
  final String title, category, date;
  final int amount;
  final IconData icon;
  const Txn(this.title, this.category, this.amount, this.date, this.icon);
  bool get income => amount > 0;
}

class Account {
  final String label, number;
  final int balance;
  const Account(this.label, this.number, this.balance);
}

class Fav {
  final String name, number;
  const Fav(this.name, this.number);
}

class MenuData {
  final String label;
  final IconData icon;
  final List<Color> colors;
  const MenuData(this.label, this.icon, this.colors);
}

class Promo {
  final String title, subtitle;
  final IconData icon;
  final List<Color> colors;
  const Promo(this.title, this.subtitle, this.icon, this.colors);
}

class Dummy {
  static const userName = 'FAJAR RAMADHANI';
  static const initials = 'FR';
  static const points = 1250;

  static const main = Account('BNI MOBILE DIGITAL', '1786609623', 12450000);
  static const others = <Account>[
    Account('TABUNGAN BERENCANA', '1786609700', 5000000),
    Account('DEPOSITO DIGITAL', '1786609811', 25000000),
  ];

  static const menus = <MenuData>[
    MenuData('Transfer', Icons.swap_horiz_rounded, [Color(0xFF3BC3C8), Color(0xFF16A2B5)]),
    MenuData('E-Wallet', Icons.account_balance_wallet_rounded, [Color(0xFF3B9BF5), Color(0xFF1B6FE0)]),
    MenuData('Pembayaran', Icons.receipt_long_rounded, [Color(0xFF8A7BF5), Color(0xFF5B49D8)]),
    MenuData('Pembelian', Icons.shopping_cart_rounded, [Color(0xFF4C8DF7), Color(0xFF2358D6)]),
    MenuData('Investasi', Icons.trending_up_rounded, [Color(0xFF34C77B), Color(0xFF16965A)]),
    MenuData('Life Goals', Icons.flag_circle_rounded, [Color(0xFF3CCFD6), Color(0xFF1AA3BC)]),
    MenuData('Digital Loan', Icons.volunteer_activism_rounded, [Color(0xFFFFC443), Color(0xFFF2A21A)]),
    MenuData('Kartu Kredit', Icons.credit_card_rounded, [Color(0xFFB88CF7), Color(0xFF8E5CE0)]),
    MenuData('Rekeningku', Icons.contact_page_rounded, [Color(0xFFFF9A3D), Color(0xFFF57C20)]),
    MenuData('Mobile Tunai', Icons.atm_rounded, [Color(0xFFFF8F3A), Color(0xFFF2650F)]),
    MenuData('DiKado', Icons.card_giftcard_rounded, [Color(0xFFD94CB4), Color(0xFFB02A92)]),
  ];

  static const promos = <Promo>[
    Promo('Waspada Penipuan Online', 'Jangan bagikan PIN, OTP, atau data pribadi kepada siapa pun.',
        Icons.gpp_maybe_rounded, [Color(0xFFB02A2A), Color(0xFFE5533D)]),
    Promo('Cashback QRIS 10%', 'Bayar dengan QRIS di merchant pilihan. Berlaku sampai akhir bulan.',
        Icons.qr_code_2_rounded, [Color(0xFF0B8DA0), Color(0xFF3BC3C8)]),
    Promo('Investasi Mulai Rp10.000', 'Mulai reksa dana tanpa ribet langsung dari aplikasi.',
        Icons.trending_up_rounded, [Color(0xFF1B6FE0), Color(0xFF8A7BF5)]),
  ];

  static final txns = <Txn>[
    const Txn('Gaji Bulanan', 'Pemasukan', 8500000, 'Hari ini, 09:00', Icons.arrow_downward_rounded),
    const Txn('Transfer ke Budi Santoso', 'Transfer', -250000, 'Kemarin, 14:20', Icons.send_rounded),
    const Txn('Token Listrik PLN', 'Pembayaran', -200000, '9 Nov, 19:45', Icons.bolt_rounded),
    const Txn('Top Up E-Wallet', 'E-Wallet', -150000, '8 Nov, 12:05', Icons.account_balance_wallet_rounded),
    const Txn('Terima dari Siti Aminah', 'Transfer', 500000, '7 Nov, 10:10', Icons.call_received_rounded),
    const Txn('Pembelian Pulsa', 'Pembelian', -100000, '6 Nov, 17:30', Icons.phone_android_rounded),
    const Txn('Tagihan Internet', 'Pembayaran', -350000, '4 Nov, 20:00', Icons.wifi_rounded),
    const Txn('Cashback DiKado', 'Reward', 25000, '3 Nov, 08:15', Icons.card_giftcard_rounded),
  ];
}

final favorites = ValueNotifier<List<Fav>>(const [
  Fav('Budi Santoso', '1786600111'),
  Fav('Siti Aminah', '1786600222'),
  Fav('Listrik PLN', '5320000333'),
]);
