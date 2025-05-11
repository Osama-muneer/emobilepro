import '../../Setting/controllers/login_controller.dart';
late List<Syn_Dat_Local> SYN_DATList=[] ;
class Syn_Dat_Local {
  String? STMID;
  int? SDSQ;
  String? SDNO;
  String? GUID;
  String? SDTB;
  int? SDTN;
  String? SDTY;
  int? JTID;
  int? CIID;
  int? BIID;
  int? SDST;
  String? DATEI;
  String? SYER;
  int? SMID;
  String? SDBR_A;
  String? SDPO_A;
  int? SYID;
  String? DATEU;
  int? SOMSQ;
  String? SOGU;
  String? SYDV_ID;
  String? SYDV_GU;
  String? SYDV_NAME;
  String? SYDV_IP;
  String? SYDV_SER;
  String? SYDV_POI;
  String? SYDV_NO;
  String? SYDV_LATITUDE;
  String? SYDV_LONGITUDE;
  String? SYDV_APPV;
  String? SYDV_APIV;
  String? SYDV_TY;
  int? SLTY2;
  String? SLIT2;
  String? SLSC2;
  String? SLTYP;
  String? SDC2;
  String? SDC3;
  String? SDNO2;
  String? SDNO3;
  String? DEVI;
  String? SUID;
  int? JTID_L;
  int? BIID_L;
  int? SYID_L;
  String? CIID_L;
  String? SUCH;
  String? DEVU;

  Syn_Dat_Local({this.STMID,this.SDSQ,this.SDNO,this.GUID,this.SDTB,this.SDTN,this.SDTY,this.JTID,this.CIID,this.BIID,this.SDST
    ,this.DATEI,this.SYER,this.SMID,this.SDBR_A,this.SDPO_A,this.SYID,this.DATEU,this.SOMSQ,this.SOGU,this.SYDV_ID
    ,this.SYDV_GU,this.SYDV_NAME,this.SYDV_IP,this.SYDV_SER, this.SYDV_POI,this.SYDV_NO,this.SYDV_LATITUDE,this.SYDV_LONGITUDE,
    this.SYDV_APPV,this.SYDV_APIV,this.SYDV_TY,this.SLTY2,this.SLIT2,this.SLSC2,this.SDC2,this.SDC3,this.SDNO2,this.SDNO3,
    this.DEVI,this.SUID,this.JTID_L,this.SYID_L,this.BIID_L,this.CIID_L,});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'STMID': STMID,
      'SDSQ': SDSQ,
      'SDNO': SDNO,
      'GUID': GUID,
      'SDTB': SDTB,
      'SDTN': SDTN,
      'SDTY': SDTY,
      'JTID': JTID,
      'CIID': CIID,
      'BIID': BIID,
      'SDST': SDST,
      'DATEI': DATEI,
      'SYER': SYER,
      'SMID': SMID,
      'SDBR_A': SDBR_A,
      'SDPO_A': SDPO_A,
      'SYID': SYID,
      'DATEU': DATEU,
      'SOMSQ': SOMSQ,
      'SOGU': SOGU,
      'SUID': SUID,
      'SYDV_ID': SYDV_ID,
      'SYDV_GU': SYDV_GU,
      'SYDV_NAME': SYDV_NAME,
      'SYDV_IP': SYDV_IP,
      'SYDV_SER': SYDV_SER,
      'SYDV_POI': SYDV_POI,
      'SYDV_NO': SYDV_NO,
      'SYDV_LATITUDE': SYDV_LATITUDE,
      'SYDV_LONGITUDE': SYDV_LONGITUDE,
      'SYDV_APPV': SYDV_APPV,
      'SYDV_APIV': SYDV_APIV,
      'SYDV_TY': SYDV_TY,
      'SLTY2': SLTY2,
      'SLIT2': SLIT2,
      'SLSC2': SLSC2,
      'SLTYP': SLTYP,
      'SDC2': SDC2,
      'SDC3': SDC3,
      'SDNO2': SDNO2,
      'SDNO3': SDNO3,
      'DEVI': DEVI,
      'DEVU': DEVU,
      'SUCH': SUCH,
      'JTID_L': JTID_L ?? LoginController().JTID,
      'SYID_L': SYID_L ?? LoginController().SYID,
      'BIID_L': BIID_L ?? LoginController().BIID,
      'CIID_L': CIID_L ?? LoginController().CIID,
    };
    return map;
  }
  Syn_Dat_Local.fromMap(Map<dynamic, dynamic> map) {
    STMID = map['STMID'];
    SDSQ = map['SDSQ'];
    SDNO = map['SDNO'];
    GUID = map['GUID'];
    SDTB = map['SDTB'];
    SDTN = map['SDTN'];
    SDTY = map['SDTY'];
    JTID = map['JTID'];
    CIID = map['CIID'];
    BIID = map['BIID'];
    SDST = map['SDST'];
    DATEI = map['DATEI'];
    SYER = map['SYER'];
    SMID = map['SMID'];
    SDBR_A = map['SDBR_A'];
    SDPO_A = map['SDPO_A'];
    SYID = map['SYID'];
    DATEU = map['DATEU'];
    SOMSQ = map['SOMSQ'];
    SOGU = map['SOGU'];
    SYDV_ID = map['SYDV_ID'];
    SYDV_GU = map['SYDV_GU'];
    SYDV_NAME = map['SYDV_NAME'];
    SYDV_IP = map['SYDV_IP'];
    SYDV_SER = map['SYDV_SER'];
    SYDV_POI = map['SYDV_POI'];
    SYDV_NO = map['SYDV_NO'];
    SYDV_LATITUDE = map['SYDV_LATITUDE'];
    SYDV_LONGITUDE = map['SYDV_LONGITUDE'];
    SYDV_APPV = map['SYDV_APPV'];
    SYDV_APIV = map['SYDV_APIV'];
    SYDV_TY = map['SYDV_TY'];
    SLTY2 = map['SLTY2'];
    SLIT2 = map['SLIT2'];
    SLSC2 = map['SLSC2'];
    SLTYP = map['SLTYP'];
    SDC2 = map['SDC2'];
    SDC3 = map['SDC3'];
    SDNO2 = map['SDNO2'];
    SDNO3 = map['SDNO3'];
    DEVI = map['DEVI'];
    SUID = map['SUID'];
    SUCH = map['SUCH'];
    DEVU = map['DEVU'];
    JTID_L = map['JTID_L'];
    SYID_L = map['SYID_L'];
    BIID_L = map['BIID_L'];
    CIID_L = map['CIID_L'];
  }

}
