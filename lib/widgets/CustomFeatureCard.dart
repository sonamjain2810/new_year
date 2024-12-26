import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class CustomFeatureCard extends StatelessWidget {
  const CustomFeatureCard({
    Key? key,
    required this.size,
    this.imageUrl,
    required ontap,
  }) : super(key: key);

  final Size size;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width(5)),
        child: Container(
          
          //width: size.width * 0.8,
          height: 40 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), 
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl!,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fadeOutDuration: const Duration(seconds: 1),
            fadeInDuration: const Duration(seconds: 3),
          ),
        ),
      ),
    );
  }
}
