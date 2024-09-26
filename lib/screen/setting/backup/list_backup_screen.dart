import 'package:flutter/material.dart';
import 'package:mood_press/providers/backup_provider.dart';
import 'package:mood_press/screen/setting/backup/widget/item_backup_data.dart';
import 'package:provider/provider.dart';

import '../../../generated/l10n.dart';

class ListBackupScreen extends StatefulWidget {
  const ListBackupScreen({super.key});

  @override
  State<ListBackupScreen> createState() => _ListBackupScreenState();
}

class _ListBackupScreenState extends State<ListBackupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(S.of(context).existingBackup), // Localized title
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: false,
      ),
      body: Consumer<BackupProvider>(
        builder: (context,provider,_){
          return provider.files.isNotEmpty ? ListView.separated(
              itemBuilder:(context,index) => ItemBackupData(file: provider.files[index],),
              separatorBuilder: (context,index) => Divider(color: Colors.blueGrey.shade100,),
              itemCount: provider.files.length
          ) : Center(child: Text(S.of(context).noRecords,style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 16),),);
        }
      ),
    );
  }
}
