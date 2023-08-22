import 'package:flutter/material.dart';

class GeneralErrorVisualisation extends StatelessWidget {
  final String message;
  /////////////////////////
  const GeneralErrorVisualisation({required this.message,}) : super(key: null,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return Center(
      child: InkWell(
        onTap: () => {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.signal_cellular_connected_no_internet_0_bar_outlined,
              size: 136.0,
              color: Colors.grey.withAlpha(100,),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0,),
              child: Text(
                "$message Tap for retry",
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}