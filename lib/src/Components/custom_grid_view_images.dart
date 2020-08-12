import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
// ignore: must_be_immutable
class CustomGridViewImages extends StatefulWidget {

 
  @override
  _CustomGridViewImagesState createState() => _CustomGridViewImagesState();
}

class _CustomGridViewImagesState extends State<CustomGridViewImages> {
  var mapColor = [
    {"colorIcon": Colors.black87, "bgIcon": Colors.grey[400]},
    {"colorIcon": Colors.black87, "bgIcon": Colors.grey[400]},
    {"colorIcon": Colors.black87, "bgIcon": Colors.grey[400]},
  ];
  List<Asset> _multiImages = List<Asset>();

  Future<void> _loadAssets() async {
    setState(() {
      _multiImages = List<Asset>();
    });

    List<Asset> resultList = await MultiImagePicker.pickImages(
      maxImages: 3,
      enableCamera: false,
      selectedAssets: _multiImages,
      materialOptions: MaterialOptions(
        actionBarColor: "#74bb37",
        statusBarColor:  "#74bb37",
        actionBarTitle: "اختر صور للاعلان",
        allViewTitle: "All Photos",
        selectCircleStrokeColor: "#000000",
      ),
    );
    setState(() {
      _multiImages = resultList;
    });
    print(resultList[0].name);
    print(resultList[1].name);
    print(resultList[2].name);
    for (int i = 0; i > _multiImages.length; i++) {
      setState(() {
        mapColor[i]["colorIcon"] = Colors.white;
        mapColor[i]["bgIcon"] = Theme.of(context).primaryColor;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    if (_multiImages.length != 0) {
      return _multiImages.length == 3
          ? Padding(
        padding: const EdgeInsets.only(right: 20, left: 20),
        child: Container(
          height: _multiImages.length > 3 ? 260 : 130,
          child: GridView.count(
            crossAxisCount: 3,
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: List.generate(_multiImages.length, (index) {
              Asset asset = _multiImages[index];
              return Stack(
                children: <Widget>[
                  AssetThumb(
                    asset: asset,
                    width: 300,
                    height: 300,
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _multiImages.removeAt(index);
                        });
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    bottom: 5,
                    left: 5,
                  ),
                ],
              );
            }),
          ),
        ),
      )
          : Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Container(
              height: _multiImages.length > 3 ? 260 : 130,
              child: GridView.count(
                crossAxisCount: 3,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                children: List.generate(_multiImages.length, (index) {
                  Asset asset = _multiImages[index];
                  return Stack(
                    children: <Widget>[
                      AssetThumb(
                        asset: asset,
                        width: 300,
                        height: 300,
                      ),
                      Positioned(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _multiImages.removeAt(index);
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        bottom: 5,
                        left: 5,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _loadAssets();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      height: 50,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: CircleAvatar(
                                radius: 15.0,
                                backgroundColor: mapColor[index]["bgIcon"],
                                child: Icon(
                                  Icons.add,
                                  color: mapColor[index]["colorIcon"],
                                  size: 18,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "اضف صورة الاعلان",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return InkWell(
        onTap: () {
          _loadAssets();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Container(
                  height: 50,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: CircleAvatar(
                            radius: 15.0,
                            backgroundColor: mapColor[index]["bgIcon"],
                            child: Icon(
                              Icons.add,
                              color: mapColor[index]["colorIcon"],
                              size: 18,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "اضف صورة الاعلان",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
