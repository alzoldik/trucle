import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class InputFieldArea extends StatefulWidget {
  final String hint;
  final String init;
  final icon;

  final String labelTxt;

  final suffixIcon;

  final TextEditingController controller;

  final TextInputType textInputType;

  final Function changedFunction;

  final Function error;

  final String errorTxt;

  final bool show;

  final Function iconChanged;

  final bool inputFieldWithBorder;

  final bool border;

  final inputScopeSur;

  final onFocus;

  final inputScopeDes;

  InputFieldArea(
      {this.hint,
      this.icon,
      this.controller,
      this.textInputType,
      this.changedFunction,
      this.errorTxt,
      this.show,
      this.iconChanged,
      this.inputFieldWithBorder,
      this.inputScopeSur,
      this.inputScopeDes,
      this.suffixIcon,
      this.labelTxt,
      this.border,
      this.onFocus,
      this.error, this.init});

  @override
  _InputFieldAreaState createState() => _InputFieldAreaState();
}

class _InputFieldAreaState extends State<InputFieldArea> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    return widget.show != null
        ? widget.inputFieldWithBorder == null
            ? Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    initialValue: widget.init,
                    autofocus: false,
                    focusNode: widget.inputScopeSur,
                    keyboardType: widget.textInputType,
                    onChanged: widget.changedFunction,
                    obscureText: show,
                    validator: widget.error,
                    controller: widget.controller,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'cairo'),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: show
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          }),
                      errorText: widget.errorTxt,
                      labelText: widget.labelTxt == null
                          ? widget.hint
                          : widget.labelTxt,
                      border: widget.border == false
                          ? UnderlineInputBorder()
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                      hintText: widget.hint,
                      suffix: widget.suffixIcon,
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      contentPadding: const EdgeInsets.only(
                          top: 5.0, right: 10.0, bottom: 5.0, left: 5.0),
                    ),
                  ),
                ),
              )
            : Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    initialValue: widget.init,
                    autofocus: false,
                    focusNode: widget.inputScopeSur,
                    keyboardType: widget.textInputType,
                    onChanged: widget.changedFunction,
                    controller: widget.controller,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'cairo'),
                    obscureText: show,
                    decoration: InputDecoration(
                      errorText: widget.errorTxt,
                      border: widget.border == false
                          ? UnderlineInputBorder()
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                      labelText: widget.labelTxt != null
                          ? widget.labelTxt
                          : widget.hint,
                      hintText: widget.hint,
                      suffixIcon: IconButton(
                          icon: show
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {
                              show = !show;
                            });
                          }),
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      contentPadding: const EdgeInsets.only(
                          top: 5.0, right: 10.0, bottom: 5.0, left: 10.0),
                    ),
                  ),
                ),
              )
        : widget.inputFieldWithBorder != null
            ? Container(
                margin: EdgeInsets.all(8),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    initialValue: widget.init,
                    autofocus: false,
                    controller: widget.controller,
                    focusNode: widget.inputScopeSur,
                    maxLines: 3,
                    minLines: 1,
                    keyboardType: widget.textInputType,
                    onChanged: widget.changedFunction,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'cairo',
                    ),
                    decoration: InputDecoration(
                      suffixIcon: widget.suffixIcon,
                      errorText: widget.errorTxt,
                      border: widget.border == false
                          ? UnderlineInputBorder()
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                      labelText: widget.labelTxt == null
                          ? widget.hint
                          : widget.labelTxt,
                      hintText: widget.hint,
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      contentPadding: const EdgeInsets.only(
                          top: 5.0, right: 10.0, bottom: 5.0, left: 10.0),
                    ),
                  ),
                ),
              )
            : Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    initialValue: widget.init,
                    autofocus: false,
                    controller: widget.controller,
                    focusNode: widget.inputScopeSur,
                    keyboardType: widget.textInputType,
                    onChanged: widget.changedFunction,
                    maxLines: 3,
                    minLines: 1,
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'cairo'),
                    decoration: InputDecoration(
                      suffixIcon: widget.suffixIcon,
                      errorText: widget.errorTxt,
                      labelText: widget.labelTxt == null
                          ? widget.hint
                          : widget.labelTxt,
                      border: widget.border == false
                          ? UnderlineInputBorder()
                          : OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                      hintText: widget.hint,
                      labelStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'cairo'),
                      contentPadding: const EdgeInsets.only(
                          top: 5.0, right: 10.0, bottom: 5.0, left: 5.0),
                    ),
                  ),
                ),
              );
  }
}
