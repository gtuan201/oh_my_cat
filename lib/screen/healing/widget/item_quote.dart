import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mood_press/gen/colors.gen.dart';

class ItemQuote extends StatelessWidget {
  final String imageUrl;
  const ItemQuote({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorName.darkBlue,width: 2.5),
                borderRadius: BorderRadius.circular(12),
                color: ColorName.colorBackground
              ),
              child: const Center(child: FaIcon(FontAwesomeIcons.hourglassHalf,color: Colors.grey,size: 60,)),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}
