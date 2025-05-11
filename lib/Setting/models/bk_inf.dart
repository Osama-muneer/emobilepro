class Bk_inf {
  final int biid; // الرقم
  final String bity; // النوع
  final String biur; // المسار
  final String bizi; // الحجم
  final String bida; // التاريخ
  final String biti; // الوقت
  final int jtidL;
  final int biidL;
  final int syidL;
  final String ciidL;

  Bk_inf({
    required this.biid,
    required this.bity,
    required this.biur,
    required this.bizi,
    required this.bida,
    required this.biti,
    required this.jtidL,
    required this.biidL,
    required this.syidL,
    required this.ciidL,
  });

  factory Bk_inf.fromMap(Map<String, dynamic> json) {
    return Bk_inf(
      biid: json['BIID'],
      bity: json['BITY'],
      biur: json['BIUR'],
      bizi: json['BIZI'],
      bida: json['BIDA'],
      biti: json['BITI'],
      jtidL: json['JTID_L'],
      biidL: json['BIID_L'],
      syidL: json['SYID_L'],
      ciidL: json['CIID_L'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'BIID': biid,
      'BITY': bity,
      'BIUR': biur,
      'BIZI': bizi,
      'BIDA': bida,
      'BITI': biti,
      'JTID_L': jtidL,
      'BIID_L': biidL,
      'SYID_L': syidL,
      'CIID_L': ciidL,
    };
  }
}

