import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socially/core/utils/common_sizes.dart';

class WaitingWidget extends StatelessWidget {
  const WaitingWidget({this.isStory = false, this.isSend = false, Key? key})
      : super(key: key);
  final isStory;
  final isSend;

  @override
  Widget build(BuildContext context) {
    return isSend
        ? Container()
        : Container(
            child: Center(
                child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: ListView.separated(
              separatorBuilder: (context, index) =>
                  isStory ? CommonSizes.hSmallSpace : CommonSizes.vSmallSpace,
              itemCount: 5,
              scrollDirection: isStory ? Axis.horizontal : Axis.vertical,
              itemBuilder: (context, index) {
                return isStory
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          height: 50.r,
                          width: 50.r,
                          color: Colors.white,
                        ),
                      )
                    : Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.circular(15.0)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          title: Container(
                            height: 60,
                            width: 200,
                            color: Colors.white,
                          ),
                        ));
              },
            ),
          ))
            // CircularProgressIndicator(),
            );
  }
}
