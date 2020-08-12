import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
class CustomFlutterSwiper{
  Widget swipper(final model , BuildContext context){
    return Swiper(
      itemBuilder: ( _, int index) {
        return InkWell(
          onTap: null,
          child: ClipRRect(
              borderRadius:
              BorderRadius.all(Radius.circular(10.0)),
              child: Image.asset(
                model[index],
                fit: BoxFit.fill,
              )),
        );
      },
      itemCount: model.length,
      pagination:  SwiperPagination(),
      control:  SwiperControl(),
      itemWidth: MediaQuery.of(context).size.width,
      viewportFraction: 0.8,
      scale: 0.85,
      autoplay: true,
      loop: true,
    );
  }
}