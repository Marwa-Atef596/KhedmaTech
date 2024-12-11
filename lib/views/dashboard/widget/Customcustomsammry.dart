
import 'package:flutter/material.dart';

import '../../../core/constent.dart';

class CustomSammry extends StatelessWidget {
  const CustomSammry({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration:
                    const BoxDecoration(color: background, shape: BoxShape.circle),
                width: 100,
                child: Image.asset(
                  'assets/images/11.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text(
                'مروه عاطف',
                style: txtstyle6,
              ),
              const Spacer(),
              Container(
                width: 60,
                // height: 26,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: kcolor1),
                  color: Colors.white,
                ),
                child: const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '5',
                        //  widget.RatingNames[index],
                        style: txtstyle1,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const SizedBox(
            width: 300,
            child: Text(
              'الحرفي وصل ف المعاد ومشكلتي اتحلت ف اسرع خصوصا اني مش من هنا ولسه ناقله جديد',
              maxLines: 2,
              style: TextStyle(
                  height: 1.3, fontWeight: FontWeight.w500, fontSize: 14),
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.favorite_sharp,
                    color: ksmry,
                  )),
              const Text('4'),
              const SizedBox(
                width: 50,
              ),
              const Text(
                'يومان فائتان',
                style: TextStyle(color: kcolor1, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }
}