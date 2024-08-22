import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';

class CustomRichText extends StatelessWidget {
  final List<TextSpan> text;
  final TextAlign? textAlign;
  final int? numOfLine;
  final String? textWithemogi;
  final bool withtextWithemogi;

  final AlignmentGeometry alignmentGeometry;
  final double paddingVertical;
  final double paddingHorizantal;

  const CustomRichText(
      {required this.text,
      this.alignmentGeometry = Alignment.centerLeft,
      this.paddingVertical = 0,
      this.paddingHorizantal = 0,
      this.textAlign,
      this.numOfLine,
      this.withtextWithemogi = false,
      this.textWithemogi,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (withtextWithemogi) {
      final regex = RegExp(r'(@\w+)');
      final matches = regex.allMatches(textWithemogi!);
      List<TextSpan> spans = [];
      int currentIndex = 0;

      for (final match in matches) {
        if (match.start > currentIndex) {
          spans.add(TextSpan(
            text: textWithemogi!.substring(currentIndex, match.start),
            style: Styles.w400TextStyle()
                .copyWith(fontSize: 16.sp, color: Styles.colorTextInactive),
          ));
        }

        spans.add(TextSpan(
          text: match.group(0),
          style: Styles.w600TextStyle().copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Styles.colorTextInactive),
        ));

        currentIndex = match.end;
      }

      if (currentIndex < text.length) {
        spans.add(TextSpan(
          text: textWithemogi!.substring(currentIndex),
          style: Styles.w300TextStyle()
              .copyWith(fontSize: 16.sp, color: Styles.colorTextInactive),
        ));
      }
      return Container(
          padding: EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizantal),
          alignment: alignmentGeometry,
          child: RichText(
            textAlign: textAlign ?? TextAlign.start,
            text: TextSpan(children: spans),
          ));
    } else {
      return Container(
        padding: EdgeInsets.symmetric(
            vertical: paddingVertical, horizontal: paddingHorizantal),
        alignment: alignmentGeometry,
        child: RichText(
          textAlign: textAlign ?? TextAlign.start,
          text: new TextSpan(
              style: Styles.w300TextStyle()
                  .copyWith(fontSize: 16.sp, color: Styles.colorTextTitle),
              children: text),
        ),
      );
    }
  }
}
