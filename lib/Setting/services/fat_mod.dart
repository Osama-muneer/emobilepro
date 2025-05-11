class Invoice {
  final String? invoiceType;
  final GeneralInvoiceInfo? generalInvoiceInfo;
  String? billingReference;
  String? reasonsForIssuance='Cancellation';
  final Seller? seller;
  final Buyer? buyer;
  final List<InvoiceLine>? invoiceLines;
  final String? privateKey;
  final String? binarySecurityToken;
  final String? secret;

  Invoice({
     this.invoiceType,
     this.generalInvoiceInfo,
     this.billingReference,
     this.reasonsForIssuance,
     this.seller,
     this.buyer,
     this.invoiceLines,
     this.privateKey,
     this.binarySecurityToken,
     this.secret,
  });

  Map<String, dynamic> toJson() {

    if( billingReference.toString()!='null' &&  billingReference.toString().isNotEmpty){
      return (buyer!.name.toString()!='null' &&  buyer!.name.toString().isNotEmpty)?
         {
          'document': {
            'invoiceType': invoiceType,
            'generalInvoiceInfo': generalInvoiceInfo!.toJson(),
            'billingReference':billingReference,
            'reasonsForIssuance': reasonsForIssuance,
            'seller': seller!.toJson(),
            'buyer': buyer!.toJson(),
            'invoiceLines': invoiceLines!.map((line) => line.toJson()).toList(),
          },
          'privateKey': privateKey,
          'binarySecurityToken': binarySecurityToken,
          'secret': secret,
        }
      :
         {
          'document': {
            'invoiceType': invoiceType,
            'generalInvoiceInfo': generalInvoiceInfo!.toJson(),
            'billingReference':billingReference,
            'reasonsForIssuance': reasonsForIssuance,
            'seller': seller?.toJson(),
            'invoiceLines': invoiceLines!.map((line) => line.toJson()).toList(),
          },
          'privateKey': privateKey,
          'binarySecurityToken': binarySecurityToken,
          'secret': secret,
        };
    }else{

      return   (buyer!.name.toString()!='null' &&  buyer!.name.toString().isNotEmpty)?
      {
        'document': {
          'invoiceType': invoiceType,
          'generalInvoiceInfo': generalInvoiceInfo!.toJson(),
          'seller': seller?.toJson(),
          'buyer': buyer?.toJson(),
          'invoiceLines': invoiceLines!.map((line) => line.toJson()).toList(),
        },
        'privateKey': privateKey,
        'binarySecurityToken': binarySecurityToken,
        'secret': secret,
      }:
      {
        'document': {
          'invoiceType': invoiceType,
          'generalInvoiceInfo': generalInvoiceInfo!.toJson(),
          'seller': seller?.toJson(),
         // 'buyer': buyer?.toJson(),
          'invoiceLines': invoiceLines!.map((line) => line.toJson()).toList(),
        },
        'privateKey': privateKey,
        'binarySecurityToken': binarySecurityToken,
        'secret': secret,
      };
    }
  }
}

class GeneralInvoiceInfo {
   String? number;
  final String uuid;
  final int icv;
  final String issueDateTime;
  final String actualDeliveryDate;
  final String previousInvoiceHash;
  final String currency;
  final List<String> paymentMeans;
  final String vatCurrency;

  GeneralInvoiceInfo({
     this.number,
    required this.uuid,
    required this.icv,
    required this.issueDateTime,
    required this.actualDeliveryDate,
    required this.previousInvoiceHash,
    required this.currency,
    required this.paymentMeans,
    required this.vatCurrency,
  });

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'uuid': uuid,
      'icv': icv,
      'issueDateTime': issueDateTime,
      'actualDeliveryDate': actualDeliveryDate,
      'previousInvoiceHash': previousInvoiceHash,
      'currency': currency,
      'paymentMeans': paymentMeans,
      'vatCurrency': vatCurrency,
    };
  }
}

class Seller {
  final String name;
  final Address address;
  final String vatNumber;
  final Id id;

  Seller({
    required this.name,
    required this.address,
    required this.vatNumber,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address.toJson(),
      'vatNumber': vatNumber,
      'id': id.toJson(),
    };
  }
}

class Buyer {
 var name;
  var address;
  var vatNumber;
   Id? id;
   bool? CUS_EX=false;

  Buyer({
     this.name,
     this.address,
     this.vatNumber,
     this.id,
  });

  Map<String, dynamic> toJson() {
    if(CUS_EX==true) {
      return {
        'name': name,
        'address': address.toJson(),
        'vatNumber': vatNumber,
        'id': id!.toJson(),
      };
    }else{
      return {
        'name': name,
        'address': address.toJson(),
        'vatNumber': vatNumber,
        // 'id': id!.toJson(),
      };
    }
  }
}

class Address {
  final String street;
  final String buildingNumber;
  final String district;
  final String city;
  final String postalCode;
  final String countryCode;

  Address({
    required this.street,
    required this.buildingNumber,
    required this.district,
    required this.city,
    required this.postalCode,
    required this.countryCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'buildingNumber': buildingNumber,
      'district': district,
      'city': city,
      'postalCode': postalCode,
      'countryCode': countryCode,
    };
  }
}

class InvoiceLine {
  var quantity;
  var price;
  var discount;
  var netAmount;
  var vatAmount;
  var amountInclusiveVAT;
  var itemName;
  bool? dis=false;
   Vat? vat;
   allowances? Allowances;

  InvoiceLine({
     this.quantity,
     this.price,
     this.itemName,
     this.dis,
     this.vat,
     this.Allowances,
  });

  Map<String, dynamic> toJson() {
    if(dis==true){
      return {
        'quantity': quantity,
        'price': price,
        'itemName': itemName,
        'vat': vat!.toJson(),
        'Allowances': Allowances?.toJson(),
      };
    }else{
      return {
        'quantity': quantity,
        'price': price,
        'itemName': itemName,
        'vat': vat!.toJson(),
        //'Allowances': Allowances!.toJson(),
      };
    }
  }
}

class Vat {
  final String categoryCode;
  final double percent;
   String? taxExemptionReasonCode;
   String? taxExemptionReason;

  Vat({
    required this.categoryCode,
    required this.percent,
     this.taxExemptionReasonCode,
     this.taxExemptionReason,
  });

  Map<String, dynamic> toJson() {
    if(categoryCode=='S'){
      return {
        'categoryCode': categoryCode,
        'percent': percent,
      };
    }else{
      return {
        'categoryCode': categoryCode,
        'percent': percent,
        'taxExemptionReasonCode': taxExemptionReasonCode,
        'taxExemptionReason': taxExemptionReason,
      };
    }
  }
}

class Id {
  final String idType;
  final String value;

  Id({
    required this.idType,
    required this.value,
  });

  Map<String, dynamic> toJson() {
    return {
      'idType': idType,
      'value': value,
    };
  }
}

class allowances {
   String? reason='90';
   String? reasonCode='Discount';
   var amount;
   Vat? vat;
   bool? chargeIndicator=false;

  allowances({
     this.reason,
     this.reasonCode,
     this.amount,
     this.vat,
     this.chargeIndicator,
  });

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'reasonCode': reasonCode,
      'amount': amount,
      'vat': vat!.toJson(),
      'chargeIndicator': chargeIndicator,
    };
  }
}

class API_TYP {
   String? TYP_V;
   String? PRO_TYP_V;
   String? SUBSI_V;
   String? FISINO_V;
   var REQ_DAT_C;
   var TAX_TYP;
   var ICV_N;
   var PIH_V;
   var UUID_V;

  API_TYP({
     this.TYP_V,
     this.PRO_TYP_V,
     this.SUBSI_V,
     this.FISINO_V,
     this.REQ_DAT_C,
     this.TAX_TYP,
     this.ICV_N,
     this.PIH_V,
     this.UUID_V,
  });

  Map<String, dynamic> toJson() {
    return {
      'TYP_V': TYP_V,
      'PRO_TYP_V': PRO_TYP_V,
      'SUBSI_V': SUBSI_V,
      'FISINO_V': FISINO_V,
      'REQ_DAT_C': REQ_DAT_C,
      'TAX_TYP': TAX_TYP,
      'ICV_N': ICV_N,
      'PIH_V': PIH_V,
      'UUID_V': UUID_V,
    };
  }
}

class INV_RE_TYP {
  var INV_HASH_V;
   var INV_QR_V;
   var INV_STATUS_V;
   var INV_INF_V;
   var INV_INF_C;
   var INV_ERR_C;
   var INV_WAR_C;
   var INV_XML_C;
   var INV_TOTAMO_N;
   var INV_LINAMO_N;
   var INV_TOTWVAT_N;
   var ZATHTTPST_N;
   var PZATST_V;
   var RES_DAT_C;
   var RES_COD_V;
   var API_ERR_N;
   var ERR_TYP_N;
   var ERR_V;
   var REQ_DAT_C;
   var JSON_C;
   var BMMGU;
   var UUID_V;
   var ICV_N;

   INV_RE_TYP({
     this.INV_HASH_V,
     this.INV_QR_V,
     this.INV_STATUS_V,
     this.INV_INF_V,
     this.INV_ERR_C,
     this.INV_WAR_C,
     this.INV_XML_C,
     this.INV_TOTAMO_N,
     this.INV_LINAMO_N,
     this.INV_TOTWVAT_N,
     this.ZATHTTPST_N,
     this.PZATST_V,
     this.RES_DAT_C,
     this.RES_COD_V,
     this.API_ERR_N,
     this.ERR_TYP_N,
     this.ERR_V,
     this.REQ_DAT_C,
     this.JSON_C,
     this.BMMGU,
     this.UUID_V,
     this.ICV_N,
  });

  Map<String, dynamic> toJson() {
    return {
      'INV_HASH_V': INV_HASH_V,
      'INV_QR_V': INV_QR_V,
      'INV_STATUS_V': INV_STATUS_V,
      'INV_INF_V': INV_INF_V,
      'INV_ERR_C': INV_ERR_C,
      'INV_WAR_C': INV_ERR_C,
      'INV_XML_C': INV_XML_C,
      'INV_TOTAMO_N': INV_TOTAMO_N,
      'INV_LINAMO_N': INV_LINAMO_N,
      'INV_TOTWVAT_N': INV_TOTWVAT_N,
      'ZATHTTPST_N': ZATHTTPST_N,
      'PZATST_V': PZATST_V,
      'RES_DAT_C': RES_DAT_C,
      'RES_COD_V': RES_COD_V,
      'API_ERR_N': API_ERR_N,
      'ERR_TYP_N': ERR_TYP_N,
      'ERR_V': ERR_V,
      'REQ_DAT_C': REQ_DAT_C,
      'JSON_C': JSON_C,
      'BMMGU': BMMGU,
      'UUID_V': UUID_V,
      'ICV_N': ICV_N,
    };
  }
}

class TYP_NAM {
   var ID_V;
   var NAM_V;

  TYP_NAM({
     this.ID_V,
     this.NAM_V,
  });

  Map<String, dynamic> toJson() {
    return {
      'ID_V': ID_V,
      'NAM_V': NAM_V,
    };
  }

   TYP_NAM.fromMap(Map<dynamic, dynamic> map) {
     ID_V = map['ID_V'];
     NAM_V = map['NAM_V'];
   }
}


class Message  {
  final String code;
  final String message;
  final String category;
  final String type;
  final String status;

  Message ({
    required this.code,
    required this.message,
    required this.category,
    required this.type,
    required this.status,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message (
      code: json['code'],
      message: json['message'],
      category: json['category'],
      type: json['type'],
      status: json['status'],
    );
  }
}

class RESPONSE  {
   List<Message>? infoMessages;
    List<Message>? errorMessages;
    List<Message>? warningMessages;
   var status;
   String? invoiceHash;
   String? qrCode;
   var httpStatus;
   var zatcaHttpStatus;
   var errors;
   var json;
   final double? totalAmount;
   final double? sumOfLineNetAmount;
   final double? totalAmountWithVat;

   RESPONSE({
      this.infoMessages,
      this.errorMessages,
      this.warningMessages,
      this.errors,
     this.status,
     this.invoiceHash,
     this.qrCode,
     this.httpStatus,
     this.zatcaHttpStatus,
     this.json,
     this.totalAmount,
     this.sumOfLineNetAmount,
     this.totalAmountWithVat,
  });

  factory RESPONSE.fromJson(Map<String, dynamic> json) {
    var infoMessagesJson = json['infoMessages'] as List;
    var errorMessagesJson = json['errorMessages'] as List;
    var warningMessagesJson = json['warningMessages'] as List;
    return RESPONSE(
      infoMessages: infoMessagesJson.map((msg) => Message.fromJson(msg)).toList(),
      errorMessages: errorMessagesJson.map((msg) => Message.fromJson(msg)).toList(),
      warningMessages: warningMessagesJson.map((msg) => Message.fromJson(msg)).toList(),
      errors: json['errors'],
      status: json['status'],
      invoiceHash: json['invoiceHash'],
      qrCode: json['qrCode'],
      httpStatus: json['httpStatus'],
      zatcaHttpStatus: json['zatcaHttpStatus'],
      json: json['json'],
      totalAmount: json['totalAmount'],
      sumOfLineNetAmount: json['sumOfLineNetAmount'],
      totalAmountWithVat: json['totalAmountWithVat'],
    );
  }
}