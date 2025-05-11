import '../../../Setting/Views/Sync/show_syn_log_archive.dart';
import '../../../Widgets/colors.dart';
import 'package:flutter/material.dart';
import '../../../Widgets/theme_helper.dart';


class Show_Syn_Log extends StatefulWidget {
  @override
  State<Show_Syn_Log> createState() => _Show_Syn_LogState();
}

class _Show_Syn_LogState extends State<Show_Syn_Log> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: AppColors.MainColor,
        title: ThemeHelper().buildText(context,'StrinSyncArchive', Colors.white,'L'),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body:  Show_Syn_LogGrid_archive(),
    );
  }
}

