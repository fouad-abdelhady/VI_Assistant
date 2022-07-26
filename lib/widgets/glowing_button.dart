import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GlowingItem extends StatelessWidget {
  GlowingItem({
    Key? key,
    required this.screenWidth,
    required this.icon,
    required this.tappedIcon,
    required this.effectColor,
    required this.inAction,
    this.iconColor,
    this.onTap,
  }) : super(key: key);

  final double screenWidth;
  final effectColor;
  final IconData icon;
  final IconData tappedIcon;

  late final screenHight;
  bool inAction;

  Color? iconColor;
  Function? onTap;
  @override
  Widget build(BuildContext context) {
    screenHight = MediaQuery.of(context).size.height * 0.5;
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: _getGlowingButton(),
    );
  }

  Container _getGlowingButton() {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: screenHight,
      child: Align(
        alignment: Alignment.center,
        child: AvatarGlow(
            animate: !inAction,
            glowColor: effectColor,
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(200, 46, 45, 45)),
                child: Icon(
                  inAction ? tappedIcon : icon,
                  color: iconColor ?? effectColor,
                  size: 50,
                ),
              ),
            ),
            endRadius: screenWidth * 0.25),
      ),
    );
  }
}
