import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function() onTap;
  const ItemSetting({super.key, required this.title, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Row(
          children: [
            if(icon != null)
            Icon(icon,color: Colors.blueGrey.shade100,size: 22,),
            if(icon != null)
            const SizedBox(width: 10,),
            Text(title,style: TextStyle(color: Colors.blueGrey.shade100,fontSize: 16,fontWeight: FontWeight.w500),),
            const Spacer(),
            Icon(Icons.arrow_forward_ios,color: Colors.blueGrey.shade100,size: 18,)
          ],
        ),
      ),
    );
  }
}
