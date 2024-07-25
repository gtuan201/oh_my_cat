import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemSetting extends StatelessWidget {
  final String title;
  final IconData icon;
  const ItemSetting({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Row(
        children: [
          Icon(icon,color: Colors.blueGrey.shade100,size: 22,),
          const SizedBox(width: 10,),
          Text(title,style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 16,fontWeight: FontWeight.w500),),
          const Spacer(),
          Icon(Icons.arrow_forward_ios,color: Colors.blueGrey.shade100,size: 18,)
        ],
      ),
    );
  }
}
