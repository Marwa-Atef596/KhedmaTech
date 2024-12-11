
import 'package:flutter/material.dart';
import 'package:khedma_tech/core/reusable/text_style_helper.dart';

class ReceiverMessage extends StatelessWidget {
  ReceiverMessage({super.key, this.msg});
  String? msg;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.75,
          ),
          decoration: const BoxDecoration(
            color: Color(0xffE5F0FF),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(21),
              topLeft: Radius.circular(21),
              bottomLeft: Radius.circular(21),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start
            children: [
              Text(
                msg!,
                style: AppTextStyleHelper.font14w400Black,
              ),
            ],
          ),
        ),
        // Optional: Add some spacing after the message container
        SizedBox(width: 8),
      ],
    );
  }
}
