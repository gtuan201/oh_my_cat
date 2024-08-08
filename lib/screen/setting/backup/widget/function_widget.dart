import 'package:flutter/material.dart';

class FunctionWidget extends StatelessWidget {
  final String title;
  final String content;
  final IconData iconData;
  final Function() onTap;
  const FunctionWidget({super.key, required this.title, required this.content, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),),
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      child: Text(content,style: TextStyle(color: Colors.blueGrey.shade100,fontWeight: FontWeight.w500,fontSize: 16),)
                    ),
                  ],
                ),
              ),
              Icon(iconData,color: Colors.white,),
              const SizedBox(width: 16,)
            ],
          ),
        ),
        Divider(color: Colors.blueGrey.shade100,height: 32,),
      ],
    );
  }
}
