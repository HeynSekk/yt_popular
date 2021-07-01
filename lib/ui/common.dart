//plain frame
import 'package:flutter/material.dart';

class PlainFrame extends StatelessWidget {
  final Widget content;
  PlainFrame(this.content);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: this.content,
        ),
      ),
    );
  }
}

//normal frame
class NormalFrame extends StatelessWidget {
  final Widget appbar, content;
  NormalFrame(this.appbar, this.content);
  @override
  Widget build(BuildContext context) {
    final double sw = MediaQuery.of(context).size.width;
    final double myPadding = sw * 0.05;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            this.appbar,
            Flexible(
              fit: FlexFit.tight,
              child: SizedBox(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: myPadding,
                    right: myPadding,
                  ),
                  child: Center(
                    child: this.content,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

//normal frame for list
class NormalFrameForScroll extends StatelessWidget {
  final content;
  NormalFrameForScroll(this.content);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: this.content,
      ),
    );
  }
}

//progress indicator
class MyProgressIndicator extends StatelessWidget {
  final String name;
  MyProgressIndicator(this.name);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          backgroundColor: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        DescTxt(this.name, true, false),
      ],
    );
  }
}

//leading txt
class LeadingTxt extends StatelessWidget {
  String txt;
  bool center, myan;
  LeadingTxt(this.txt, this.center, this.myan);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Color(0xff261010),
          fontSize: this.myan ? 21 : 23,
          fontWeight: FontWeight.bold,
          height: this.myan ? 1.7 : 1.2,
        ),
      ),
    );
  }
}

class MinimalLeadingTxt extends StatelessWidget {
  String txt;
  bool center, myan;
  MinimalLeadingTxt(this.txt, this.center, this.myan);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.txt,
      textAlign: this.center ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: Color(0xff365B6D),
        fontSize: this.myan ? 21 : 23,
        fontWeight: FontWeight.bold,
        height: this.myan ? 1.7 : 1.2,
      ),
    );
  }
}

//desc txt
class DescTxt extends StatelessWidget {
  String txt;
  bool center, myan;
  DescTxt(this.txt, this.center, this.myan);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Color(0xff000000),
          fontSize: this.myan ? 16 : 18,
          height: this.myan ? 1.7 : 1.5,
        ),
      ),
    );
  }
}

class SmallerDescTxt extends StatelessWidget {
  String txt;
  bool center, myan;
  SmallerDescTxt(this.txt, this.center, this.myan);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sw * 0.90,
      child: Text(
        this.txt,
        textAlign: this.center ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          color: Color(0xff595858),
          fontSize: this.myan ? 14 : 16,
          height: this.myan ? 1.7 : 1.5,
        ),
      ),
    );
  }
}

class MinimalDescTxt extends StatelessWidget {
  final String txt;
  final bool center, myan;
  MinimalDescTxt(this.txt, this.center, this.myan);
  @override
  Widget build(BuildContext context) {
    return Text(
      this.txt,
      textAlign: this.center ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: Color(0xff365B6D),
        fontSize: this.myan ? 16 : 18,
        height: this.myan ? 1.7 : 1.5,
      ),
    );
  }
}

//message
//
class ErrorMessage extends StatelessWidget {
  IconData messageIcon;
  String leading, desc;
  bool myan;
  ErrorMessage(this.leading, this.desc, this.messageIcon, this.myan);
  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //icon
        Icon(
          this.messageIcon,
          color: Colors.red[700],
          size: 40,
        ),
        SizedBox(
          height: 15,
        ),
        //leading
        SizedBox(
          width: sw * 0.90,
          child: Text(
            this.leading,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red[900],
              fontSize: 21,
              fontWeight: FontWeight.bold,
              height: this.myan ? 1.7 : 1.2,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //desc
        DescTxt(this.desc, true, this.myan),
      ],
    );
  }
}

class MsgIcon extends StatelessWidget {
  IconData messageIcon;
  MsgIcon(this.messageIcon);
  @override
  Widget build(BuildContext context) {
    return Icon(
      this.messageIcon,
      color: Color(0xff009A94),
      size: 40,
    );
  }
}

class Message extends StatelessWidget {
  IconData messageIcon;
  String leading, desc;
  bool myan;
  Message(this.messageIcon, this.leading, this.desc, this.myan);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //icon
        Icon(
          this.messageIcon,
          color: Color(0xff009A94),
          size: 40,
        ),
        SizedBox(
          height: 15,
        ),
        LeadingTxt(this.leading, true, this.myan),
        SizedBox(
          height: 10,
        ),
        DescTxt(this.desc, true, this.myan),
      ],
    );
  }
}

//button
class ActionButton extends StatelessWidget {
  IconData btnIcon;
  String txt;
  ActionButton(this.btnIcon, this.txt);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18, right: 18, top: 9, bottom: 9),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            this.btnIcon,
            color: Colors.white,
            size: 18,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            this.txt,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
