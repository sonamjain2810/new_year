import 'package:flutter/material.dart';
import '../utils/SizeConfig.dart';

class DesignerContainer extends StatelessWidget {
  const DesignerContainer({
    Key? key,
    required this.child,
    required this.isLeft,
  }) : super(key: key);

  final Widget child;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isLeft
          ? BoxDecoration(
              color: Colors.yellow.shade700,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            )
          : BoxDecoration(
              color:Colors.pink.shade400,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(SizeConfig.height(20)),
              ),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0), blurRadius: 4, color: Colors.grey),
              ],
            ),
      child: child,
    );
  }
}
