import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';

class DevToolsWrapper extends StatelessWidget {
  final Widget appEntryPoint;
  ///CONSTRUCTOR
  const DevToolsWrapper(this.appEntryPoint, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: RequestsInspector(
        enabled: true,
        hideInspectorBanner: false,
        showInspectorOn: ShowInspectorOn.LongPress,
        child: DevicePreview(
          enabled: true,
          isToolbarVisible: true,
          backgroundColor: Colors.white,
          builder: (BuildContext context,) => DevicePreview.appBuilder(context, appEntryPoint,),
        ),
      ),
    );
  }
}
