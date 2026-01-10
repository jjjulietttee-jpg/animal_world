// import 'package:flutter/material.dart';
// import '../../constants/game_constants.dart';
// import '../../constants/image_source.dart';
// import '../../theme/app_colors.dart';
// import '../../theme/app_fonts.dart';

// class BaseDialogWidget extends StatelessWidget {
//   final String title;
//   final Widget? content;
//   final Widget primaryButton;
//   final Widget secondaryButton;

//   const BaseDialogWidget({
//     super.key,
//     required this.title,
//     this.content,
//     required this.primaryButton,
//     required this.secondaryButton,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;

//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: 400,
//           maxHeight: screenSize.height * 0.6,
//         ),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.bottomCenter,
//             end: Alignment.topCenter,
//             colors: [
//               AppColors.scaffoldBgColor,
//               AppColors.cardBackground,
//               AppColors.scaffoldBgColor,
//             ],
//             stops: const [0.0, 0.5, 1.0],
//           ),
//           borderRadius: BorderRadius.circular(GameConstants.dialogBorderRadius),
//           border: Border.all(
//             color: AppColors.primaryColor.withOpacity(0.5),
//             width: 2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.5),
//               blurRadius: 20,
//               spreadRadius: 5,
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Positioned(
//               top: -30,
//               right: -30,
//               child: Opacity(
//                 opacity: 0.1,
//                 child: Image.asset(
//                   ImageSource.plane,
//                   width: 120,
//                   height: 120,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(32),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: AppColors.primaryColor.withOpacity(0.2),
//                       border: Border.all(
//                         color: AppColors.primaryColor,
//                         width: 3,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.primaryColor.withOpacity(0.3),
//                           blurRadius: 15,
//                           spreadRadius: 3,
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: Image.asset(
//                         ImageSource.plane,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 24),
//                   Text(
//                     title,
//                     style: AppFonts.displayLarge.copyWith(
//                       fontSize: GameConstants.dialogTitleFontSize,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor,
//                       letterSpacing: 1,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   if (content != null) ...[
//                     const SizedBox(height: 16),
//                     content!,
//                   ],
//                   const SizedBox(height: 32),
//                   primaryButton,
//                   const SizedBox(height: GameConstants.dialogButtonSpacing),
//                   secondaryButton,
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

