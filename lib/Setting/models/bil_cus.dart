import 'dart:convert';
import '../../Setting/controllers/login_controller.dart';
import 'package:equatable/equatable.dart';

class Bil_Cus_Local extends Equatable{
  int? BCID;
  String? BCNA;
  String? BCNE;
  String? AANO;
  int? BCTY;
  int? BCFN;
  int? BCTID;
  int? ATTID;
  int? BCST;
  String? BCTL;
  String? BCFX;
  String? BCBX;
  String? BCMO;
  String? BCEM;
  String? BCWE;
  String? CWID;
  String? CWID2;
  String? CTID;
  String? CTID2;
  String? BCAD;
  int? BDID;
  int? BAID;
  String? BAID2;
  int? BCLA;
  int? PKID;
  var BCBL;
  int? BCPR;
  var BCBA;
  var BCBAA;
  String? BCIN;
  String? BCNAF;
  int? OKID;
  int? BCCT;
  int? SCID;
  int? BCDM;
  String? BCHN;
  String? BCHT;
  String? BCHG;
  int? BCPS;
  String? BCPD;
  String? BCDO;
  String? SUID;
  String? BCDC;
  String? SUCH;
  int? BIID;
  String? GUID;
  String? BCN3;
  String? BCQN;
  String? BCQND;
  String? BCSN;
  String? BCSND;
  String? BCBN;
  String? BCBND;
  String? BCON;
  String? BCPC;
  String? BCAD2;
  String? BCSA;
  String? BCSW;
  String? BCSWD;
  String? BCAB;
  String? BCABD;
  String? BCAB2;
  String? BCAB2D;
  String? BCTX;
  String? BCTXG;
  String? BCTX2;
  String? BCTX2G;
  String? BCC1;
  String? BCC2;
  String? BCC3;
  String? BCC4;
  String? BCC5;
  String? BCC6;
  String? BCC7;
  String? BCC8;
  String? BCC9;
  String? BCC10;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  int? SYST_L ;
  int? BCDL_L ;
  String? CIID_L;
  String? BCNA_D;
  String? BINA_D;
  String? BANA_D;
  String? DATEI;
  String? DEVI;
  String? DATEU;
  String? DEVU;
  int? AANO_D;
  String? BANA;
  String? BANE;
  String? CWNA;
  String? CWNE;
  String? CTNA;
  String? CTNE;
  String? BCLON;
  String? BCLAT;
  String? CWWC2;
  String? CWNA_D;
  String? CTNA_D;
  String? BAID_D;
  String? ITSY;
  String? ILDE;
  String? BDNA;
  String? BDNE;
  String? BCJT;
  int? BCCR;

  Bil_Cus_Local({this.BCID,this.BCNA,this.BCNE,this.AANO,this.SCID,this.BIID,this.SUID,this.SUCH,this.BCAB,this.BCAB2,
    this.BCAB2D,this.BCABD,this.BCAD,this.BCAD2,this.BCBA,this.BCBAA,this.BCBL,this.BCBN,this.BCBND,this.BCBX,this.BCC1
    ,this.BCC2,this.BCC3,this.BCC4,this.BCC5,this.BCC6,this.BCC7,this.BCC8,this.BCC9,this.BCC10,this.BCCT,this.BCDC,
     this.BCDM,this.BCDO,this.BCEM,this.BCFN,this.BCFX,this.BCHG,this.BCHN,this.BCHT,this.BCIN,this.BCLA,this.BCMO,
     this.BCN3,this.BCNAF,this.BCON,this.BCPC,this.BCPD,this.BCPR,this.BCPS,this.BCQN,this.BCQND,this.BCSA,this.BCSN,
     this.BCSND,this.BCST,this.BCSW,this.BCSWD,this.BCTID,this.ATTID,this.BCTL,this.BCTX,this.BCTX2,this.BCTX2G,this.BCTXG,
     this.BCTY,this.BCWE,this.BDID,this.CTID,this.CWID,this.GUID,this.OKID,this.PKID,this.BAID,this.CTID2,this.CWID2,
     this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,this.BCNA_D,this.BINA_D,this.SYST_L,this.BCDL_L,this.BAID2,
     this.DATEI,this.DEVI,this.DATEU,this.DEVU,this.BANA_D,this.AANO_D,this.BCLON,this.BCLAT,this.BCJT,this.BCCR});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'BCID': BCID,
      'BCNA': BCNA,
      'BCNE': BCNE,
      'AANO': AANO,
      'BCTY': BCTY,
      'BCFN': BCFN,
      'BCTID': BCTID,
      'ATTID': ATTID ?? 1,
      'BCDL_L': BCDL_L ?? 1,
      'BCST': BCST,
      'BCTL': BCTL,
      'BCFX': BCFX,
      'BCBX': BCBX,
      'BCMO': BCMO,
      'BCEM': BCEM,
      'BCWE': BCWE,
      'CWID': CWID,
      'CWID2': CWID2,
      'CTID': CTID,
      'CTID2': CTID2,
      'BCAD': BCAD,
      'BDID': BDID,
      'BAID': BAID,
      'BAID2': BAID2,
      'BCLA': BCLA,
      'PKID': PKID,
      'BCBL': BCBL,
      'BCPR': BCPR,
      'BCBA': BCBA,
      'BCBAA': BCBAA,
      'BCIN': BCIN,
      'BCNAF': BCNAF,
      'OKID': OKID,
      'BCCT': BCCT,
      'SCID': SCID,
      'BCDM': BCDM,
      'BCHN': BCHN,
      'BCHT': BCHT,
      'BCHG': BCHG,
      'BCPS': BCPS,
      'BCPD': BCPD,
      'BCDO': BCDO,
      'SUID': SUID,
      'BCDC': BCDC,
      'SUCH': SUCH,
      'BIID': BIID,
      'GUID': GUID,
      'BCN3': BCN3,
      'BCQN': BCQN,
      'BCQND': BCQND,
      'BCSN': BCSN,
      'BCSND': BCSND,
      'BCBN': BCBN,
      'BCBND': BCBND,
      'BCON': BCON,
      'BCPC': BCPC,
      'BCAD2': BCAD2,
      'BCSA': BCSA,
      'BCSW': BCSW,
      'BCSWD': BCSWD,
      'BCAB': BCAB,
      'BCABD': BCABD,
      'BCAB2': BCAB2,
      'BCAB2D': BCAB2D,
      'BCTX': BCTX,
      'BCTXG': BCTXG,
      'BCTX2': BCTX2,
      'BCTX2G': BCTX2G,
      'BCC1': BCC1,
      'BCC2': BCC2,
      'BCC3': BCC3,
      'BCC4': BCC4,
      'BCC5': BCC5,
      'BCC6': BCC6,
      'BCC7': BCC7,
      'BCC8': BCC8,
      'BCC9': BCC9,
      'BCC10': BCC10,
      'DATEI': DATEI,
      'DEVI': DEVI,
      'DATEU': DATEU,
      'DEVU': DEVU,
      'BCLON': BCLON,
      'BCLAT': BCLAT,
      'BCJT': BCJT,
     // 'BCCR': BCCR,
      'SYST_L': SYST_L ?? 1,
      'JTID_L': JTID_L ?? LoginController().JTID_L,
      'SYID_L': SYID_L ?? LoginController().SYID_L,
      'BIID_L': BIID_L ?? LoginController().BIID_L,
      'CIID_L': CIID_L ?? LoginController().CIID_L,
    };
    return map;
  }

  Bil_Cus_Local.fromMap(Map<dynamic, dynamic> map) {
    BCID = map['BCID'];
    BCNA = map['BCNA'];
    BCNE = map['BCNE'];
    AANO = map['AANO'];
    BCTY = map['BCTY'];
    BCFN = map['BCFN'];
    BCTID = map['BCTID'];
    ATTID = map['ATTID'];
    BCST = map['BCST'];
    BCTL = map['BCTL'];
    BCFX = map['BCFX'];
    BCBX = map['BCBX'];
    BCMO = map['BCMO'];
    BCEM = map['BCEM'];
    BCWE = map['BCWE'];
    CWID = map['CWID'];
    CWID2 = map['CWID2'];
    CTID = map['CTID'];
    CTID2 = map['CTID2'];
    BCAD = map['BCAD']==''?'null':map['BCAD'];
    BCSN = map['BCSN'];
    BCSND = map['BCSND'];
    BCBN = map['BCBN'];
    BCBND = map['BCBND'];
    BCON = map['BCON'];
    BDID = map['BDID'];
    BAID = map['BAID'];
    BAID2 = map['BAID2'];
    BCCT = map['BCCT'];
    BCDM = map['BCDM'];
    BCHN = map['BCHN'];
    BCHT = map['BCHT'];
    BCHG = map['BCHG'];
    BCPS = map['BCPS'];
    BCPD = map['BCPD'];
    BCDO = map['BCDO'];
    SUID = map['SUID'];
    BCDC = map['BCDC'];
    SUCH = map['SUCH'];
    BIID = map['BIID'];
    GUID = map['GUID'];
    BCN3 = map['BCN3'];
    BCQN = map['BCQN'];
    BCQND = map['BCQND'];
    BCLA = map['BCLA'];
    PKID = map['PKID'];
    BCBL = map['BCBL'];
    BCPR = map['BCPR'];
    BCBA = map['BCBA'];
    BCBAA = map['BCBAA'];
    BCIN = map['BCIN'];
    BCNAF = map['BCNAF'];
    OKID = map['OKID'];
    SCID = map['SCID'];
    BCTX = map['BCTX'];
    BCTX2 = map['BCTX2'];
    BCTXG = map['BCTXG'];
    BCTX2G = map['BCTX2G'];
    BCC1 = map['BCC1'];
    BCC2 = map['BCC2'];
    BCC3 = map['BCC3'];
    BCC4 = map['BCC4'];
    BCC5 = map['BCC5'];
    BCC6 = map['BCC6'];
    BCC7 = map['BCC7'];
    BCC8 = map['BCC8'];
    BCC9 = map['BCC9'];
    BCC10 = map['BCC10'];
    SYST_L = map['SYST_L'];
    DATEI = map['DATEI'];
    DEVI = map['DEVI'];
    DATEU = map['DATEU'];
    DEVU = map['DEVU'];
    BCAD2 = map['BCAD2'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
    BCNA_D = map['BCNA_D'];
    BINA_D = map['BINA_D'];
    BANA_D = map['BANA_D'];
    AANO_D = map['AANO_D'];
    BCDL_L = map['BCDL_L'];
    BANA = map['BANA'];
    BANE = map['BANE'];
    CWNA = map['CWNA'];
    CWNE = map['CWNE'];
    CTNA = map['CTNA'];
    CTNE = map['CTNE'];
    BCLON = map['BCLON'];
    BCLAT = map['BCLAT'];
    BCPC = map['BCPC'];
    CWWC2 = map['CWWC2'];
    CWNA_D = map['CWNA_D'];
    CTNA_D = map['CTNA_D'];
    CWWC2 = map['CWWC2'];
    BAID_D = map['BAID_D'];
    ITSY = map['ITSY'];
    ILDE = map['ILDE'];
    BDNA = map['BDNA'];
    BDNE = map['BDNE'];
    BCJT = map['BCJT'];
    //BCCR = map['BCCR'];
  }

  String Bil_Cus_toJson(List<Bil_Cus_Local> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

  @override
  // TODO: implement props
  List<Object?> get props => [BCID];
}
