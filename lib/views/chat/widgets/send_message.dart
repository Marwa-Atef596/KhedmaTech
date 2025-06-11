import 'package:flutter/material.dart';
import '../../../core/reusable/text_style_helper.dart';

class SendMessage extends StatelessWidget {
   SendMessage({super.key, this. msg});
  String? msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // CustomPaint(
        //   painter: TrianglePainter(
        //       color: ColorHelper.primaryColor
        //   ),
        //   size: const Size(10, 12),
        // ),
        Container(
          padding: const EdgeInsets.only(top: 16,left: 16,right: 16,bottom: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.75,
          ),
          decoration: const BoxDecoration(
            color: Color(0xff0B60B0),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(21),
              bottomRight: Radius.circular(21),
              topRight: Radius.circular(21),
            ),
          ),
          child:  Column(
            children: [
              Text(
                msg!,
                style: AppTextStyleHelper.font14w400White,

              ),
            ],
          ),
        ),
      ],
    );
  }
}