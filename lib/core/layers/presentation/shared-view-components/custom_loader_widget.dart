import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

enum CustomLoaderTypes{shimmer, ring, ripple,}

class CustomLoader extends StatelessWidget {
  final CustomLoaderTypes customLoaderTypes;
  /////////////////////////
  const CustomLoader({this.customLoaderTypes = CustomLoaderTypes.ring,}) : super(key: null,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return Container(
      padding: const EdgeInsets.all(10.0,),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.15,),
        borderRadius: BorderRadius.circular(10.0,),
      ),
      child: _getLoader(customLoaderTypes,),
    );
  }
  /////////////////////////
  Widget _getLoader(CustomLoaderTypes customLoaderTypes,) {
    switch (customLoaderTypes){
      case CustomLoaderTypes.shimmer:
      return const ShimmerLoaderWidget();
      case CustomLoaderTypes.ring:
      return const RingLoaderWidget();
      case CustomLoaderTypes.ripple:
      return const RippleLoaderWidget();
    }
  }
}

class RingLoaderWidget extends StatelessWidget {
  final Color? loaderColor;
  /////////////////////////
  const RingLoaderWidget({Key? key, this.loaderColor,}) : super(key: key,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0,),),
      alignment: Alignment.center,
      width: 60.0,
      height: 60.0,
      child: SpinKitRing(
        color: loaderColor ?? Colors.blueAccent,
        lineWidth: 8.0,
      ),
    );
  }
}

class RippleLoaderWidget extends StatelessWidget {
  final Color? loaderColor;
  /////////////////////////
  const RippleLoaderWidget({Key? key, this.loaderColor,}) : super(key: key,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0,),),
      alignment: Alignment.center,
      width: 60.0,
      height: 60.0,
      child: SpinKitRipple(color: loaderColor ?? Colors.blueAccent,),
    );
  }
}

class ShimmerLoaderWidget extends StatelessWidget {
  const ShimmerLoaderWidget() : super(key: null,);
  /////////////////////////
  @override
  Widget build(BuildContext context,) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index,) => Card(
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0,),
          ),
          child: const SizedBox(height: 80.0,),
        ),
      ),
    );
  }
}
