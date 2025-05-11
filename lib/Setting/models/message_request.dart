import 'dart:convert';

class MessageRequest {
  String org;
  String user;
  String pass;
  String phone;
  String message;
  bool checkRegistered;
  bool checkMyContact;
  String fileName;
  String base64File;
  bool convertPdfToImg;
  bool sendAsDoc;
  bool sendAsSticker;
  bool sendViewOnce;
  int delay;

  MessageRequest({
    required this.org,
    required this.user,
    required this.pass,
    required this.phone,
    required this.message,
    required this.checkRegistered,
    required this.checkMyContact,
    required this.fileName,
    required this.base64File,
    required this.convertPdfToImg,
    required this.sendAsDoc,
    required this.sendAsSticker,
    required this.sendViewOnce,
    required this.delay,
  });

  // تحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'org': org,
      'user': user,
      'pass': pass,
      'phone': phone,
      'message': message,
      'checkRegistered': checkRegistered,
      'checkMyContact': checkMyContact,
      'fileName': fileName,
      'base64File': base64File,
      'convertPdfToImg': convertPdfToImg,
      'sendAsDoc': sendAsDoc,
      'sendAsSticker': sendAsSticker,
      'sendViewOnce': sendViewOnce,
      'delay': delay,
    };
  }

  // تحويل JSON إلى كائن من هذا النوع
  factory MessageRequest.fromJson(Map<String, dynamic> json) {
    return MessageRequest(
      org: json['org'],
      user: json['user'],
      pass: json['pass'],
      phone: json['phone'],
      message: json['message'],
      checkRegistered: json['checkRegistered'],
      checkMyContact: json['checkMyContact'],
      fileName: json['fileName'],
      base64File: json['base64File'],
      convertPdfToImg: json['convertPdfToImg'],
      sendAsDoc: json['sendAsDoc'],
      sendAsSticker: json['sendAsSticker'],
      sendViewOnce: json['sendViewOnce'],
      delay: json['delay'],
    );
  }
}
