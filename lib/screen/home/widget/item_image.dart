import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mood_press/providers/home_provider.dart';
import 'package:provider/provider.dart';

import '../../../ulti/function.dart';

class ItemImage extends StatelessWidget {
  final File file;
  final int index;
  const ItemImage({super.key, required this.file, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12)
          ),
          margin: const EdgeInsets.symmetric(horizontal: 32,vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(file)),
        ),
        Positioned(
          right: 20,
          child: InkWell(
            onTap: () {
              showDeleteConfirmationDialog(context).then((confirmDelete){
                if(confirmDelete != null && confirmDelete){
                  context.read<HomeProvider>().deleteImage(index);
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
              ),
              child: const Icon(Icons.close,color: Colors.white,size: 18,)
            ),
          )
        )
      ],
    );
  }
}
