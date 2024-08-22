import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todoapp/core/assets_path.dart';

import '../constants.dart';



class CustomPicture extends StatelessWidget {
  const CustomPicture(
      {required this.path,
        this.height,
        this.width,
      this.color,
        this.isSVG=false,
        this.withBorder=false,
        this.isCircleShape=false,
          this.fit= BoxFit.scaleDown,
      Key? key})
      : super(key: key);
  final String path;
  final double? height;
  final bool isSVG;
  final bool isCircleShape;
  final bool withBorder;

    final double? width;
  final BoxFit fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final  double aspectRatio;
    if(width==null||height==null){
  aspectRatio  =ScreenUtil().pixelRatio??3/4;
    }else{
        aspectRatio=width! / height!;
    }

    return
      !path.contains('http')?
      //local
      Center(
          child:
        // withApectRatio
        //       ?
        AspectRatio(
                  aspectRatio: aspectRatio,
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: isSVG
                        ? SvgPicture.asset(
                       path,
                            fit: fit,
                            width: width,
                            height: height,
                            color: color,
                          )
                        :

                    Container(
                         decoration:                                      withBorder?
                         BoxDecoration(
                            borderRadius: BorderRadius.circular(48.r),
                            border: Border.all(color: Colors.blueAccent,width: 2)

                        ):null,
                      child: ClipRRect(

                                  borderRadius:
                                  isCircleShape?
                                  BorderRadius.circular(width ??0 ):
                                  BorderRadius.circular(14.r),
                                  child:

                           FadeInImage(

                            placeholder: AssetImage(
                                     AssetsPath.PNG_NoItemImage),
                            imageErrorBuilder: (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return  Image.asset(

                              AssetsPath.PNG_NoItemImage);
                             },

                      image:
                          path == null || path == ""
                          ?  AssetImage(

                          AssetsPath.PNG_NoItemImage)  as ImageProvider
                              :AssetImage(
                          path)  as ImageProvider,      fit: fit,
                          )


                                ),
                    ),
                  ))): Center(
          child:
          // withApectRatio
          //       ?
          AspectRatio(
              aspectRatio: aspectRatio,
              child: SizedBox(
                width: width,
                height: height,
                child: isSVG
                    ? SvgPicture.network(
                  AppConfigurationsImageUrl + path,
                  fit: fit,
                  width: width,
                  height: height,
                  color: color,
                )
                    : ClipRRect(
                  borderRadius:
                  isCircleShape?
                  BorderRadius.circular(width??0 ):
                  BorderRadius.circular(14.r),
                  child:

                  CachedNetworkImage(
                      width: width,
                      height: height,
                      imageUrl:
                      AppConfigurationsImageUrl  + path
                      ,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              colorFilter:
                              ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>

                          Image.asset(

                              AssetsPath.PNG_NoItemImage)

                  ),

                ),
              )));
  }
}
