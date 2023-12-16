import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  const MyTextBox({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.sandColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(
        left: 15,
        bottom: 15,
      ),
      margin: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(sectionName, style: TextStyle(color: AppColors.backgroundcolor),),

              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(Icons.settings, color: AppColors.buttomcolor,),
              ),
              
            ],
          ),

          // text
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
