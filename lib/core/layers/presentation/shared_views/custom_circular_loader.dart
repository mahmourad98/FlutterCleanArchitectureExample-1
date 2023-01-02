import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled05/core/delegations/helpers/app_colors_helper.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0,),),
      child: Container(
        height: 75.0,
        width: 75.0,
        padding: const EdgeInsets.all(10.0,),
        alignment: Alignment.center,
        child: const RingLoaderWidget(),
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.15,),
          borderRadius: BorderRadius.circular(10.0,),
        ),
      ),
    );
  }
}

class RingLoaderWidget extends StatelessWidget {
  final Color? loaderColor;

  const RingLoaderWidget({Key? key, this.loaderColor,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return Container(
      alignment: Alignment.center,
      width: 60.0,
      height: 60.0,
      child: SpinKitRing(
        color: loaderColor ?? AppColors.graspGreenColor,
        lineWidth: 8.0,
      ),
    );
  }
}

class RippleLoaderWidget extends StatelessWidget {
  final Color? loaderColor;

  const RippleLoaderWidget({Key? key, this.loaderColor,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return Container(
      alignment: Alignment.center,
      width: 60.0,
      height: 60.0,
      child: SpinKitRipple(color: loaderColor ?? AppColors.redColor_1,),
    );
  }
}
