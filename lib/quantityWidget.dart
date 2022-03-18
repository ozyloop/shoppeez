import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quantityChangeNotifier.dart';



class QuantityTextWidget extends StatefulWidget {
  _QuantityTextWidgetState createState() => _QuantityTextWidgetState();
}

class _QuantityTextWidgetState extends State<QuantityTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuantityChangeNotifier>(
        builder: (context, notifier, child) =>

            Row(children: [
              Text(notifier.ingredientquantity.toString()),
              Text(notifier.quantityType)])


        );
  }
  }
