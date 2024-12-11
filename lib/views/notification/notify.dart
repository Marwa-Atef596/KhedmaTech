import 'package:flutter/material.dart';
import 'package:khedma_tech/views/notification/widget/customCon.dart';

import '../widget/customAppService.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: customAppService(
                  txxt: 'الاشعارات',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 10),
                    child: MyWidget(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
