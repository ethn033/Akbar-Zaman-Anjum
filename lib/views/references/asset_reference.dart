import 'package:flutter/material.dart';
import 'package:mula_jan_shayeri/controllers/helper_controller.dart';

class IconReferences extends StatelessWidget {
  const IconReferences({
    Key? key,
    required this.helperController,
  }) : super(key: key);

  final HelperController helperController;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: () async {
              await helperController
                  .launchUrl('https://icons8.com/icon/VDBevfnxFpWP/social');
            },
            child: Text(
              'Social',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          Text(
            ' icon by  ',
            style: TextStyle(color: Colors.grey),
          ),
          InkWell(
              onTap: () async {
                await helperController.launchUrl('https://icons8.com');
              },
              child: Text('Icons8', style: TextStyle(color: Colors.blue)))
        ]));
  }
}
