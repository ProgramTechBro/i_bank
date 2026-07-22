import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/app_assets.dart';

class FaceIdScanWidget extends StatelessWidget {
  const FaceIdScanWidget({super.key, required this.isMatched});

  final bool isMatched;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      isMatched ? AppIcons.faceIdActive : AppIcons.faceIdInactive,
      width: 100,
      height: 100,
    );
  }
}
