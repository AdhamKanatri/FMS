import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_fms/sizeConfig.dart';
import '../constants.dart';
import 'dart:ui' as ui;

class CustomTextFiled extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onclick;
  final  TextEditingController password;
  final TextInputType type;
  String errorText(String str) {
    switch (hint) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
      case 'Product name':
        return 'Product name is empty !';
      case 'Product price':
        return 'Product price is empty !';
      case 'Product description':
        return 'Product description is empty !';
      case 'Product category':
        return 'Product category is empty !';
      case 'Product Location':
        return 'Product Location is empty !';
      case 'Enter your first name':
        return 'first name is empty !';
      case 'Enter your last name':
        return 'last name is empty !';
      case 'Enter your phone number':
        return 'phone number is empty !';
      case 'Enter your address':
        return 'address is empty !';
    }
  }

  CustomTextFiled(
      {@required Function this.onclick,
      @required String this.hint,
      @required IconData this.icon,
        @required TextEditingController this.password,
        @required TextInputType this.type,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return errorText(hint);
        }
        if(hint == 'Enter your email'){
          if(isEmail(value) == false){
            return 'Fix your email';
          }
        }
        if(hint == 'Enter your password' && value.length < 8){
          int diget=value.length;
          return 'Password should be more than 8 character\nyou inputed $diget diget';
        }
        if(hint == 'Enter your phone number' && value.length != 10){
          int diget=value.length;
          return 'Phone number should be 10 diget\nyou inputed $diget diget';
        }

      },
      controller: password,
      onSaved: onclick,
      obscureText: hint == "Enter your password" ? true : false,
      cursorColor: kMainColor,
      keyboardType: type,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.red)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(40),
              borderSide: BorderSide(color: Colors.red)),
          errorStyle:
              TextStyle(color: Colors.redAccent[100], fontWeight: FontWeight.w700,)),
    );
  }
  bool isEmail(String em) {

    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }
}

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double high = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height * .30,
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image(
          image: AssetImage('Images/icons/icon3.jpg'),
          width: 300,
          height: 300,
        ),
      ]),
    );
  }
}
class CustomText extends StatelessWidget {
  final String text;
  final double size;
  CustomText(
      {@required String this.text,
        @required double this.size,});
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect){
        return kLinearGradient.createShader(rect);
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: getProportionateScreenWidth(size),
            color: Colors.white,
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.white30,
                blurRadius: 3.0,
                offset: Offset(5,1))]
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;

  final Function onPress;

  CustomButton({
    @required this.onPress,
    this.text = 'Write text ',
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10),
      onPressed: onPress,
      color: color,
      child: CustomTextPro(
        alignment: Alignment.center,
        text: text,
        color: Colors.white,
        fontSize: getProportionateScreenWidth(20),
      ),
    );
  }
}
class CustomTextPro extends StatelessWidget {
  final String text;

  final double fontSize;

  final Color color;

  final Alignment alignment;

  final int maxLine;
  final double height;

  CustomTextPro({
    this.text = '',
    this.fontSize = 16,
    this.color = Colors.black,
    this.alignment = Alignment.topLeft,
    this.maxLine,
    this.height = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        '   $text',
        style: TextStyle(
          color: color,
          height: height,
          fontSize: fontSize,
        ),
        maxLines: maxLine,
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  MyStatelessWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end:
              Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xff6a6a68),
            const Color(0xff989b9c)
          ], // red to yellow
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
      ),
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPress;

  CustomButtonSocial({
    @required this.text,
    @required this.imageName,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.grey.shade50,
      ),
      child: FlatButton(
        onPressed: onPress,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Image.asset(imageName),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                height: 1,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff666666).withOpacity(1.0);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(0, size.height * 0.8700000);
    path_1.lineTo(0, 0);
    path_1.lineTo(size.width * 0.8700000, 0);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.4400000, size.height * 0.4400000),
        Offset(0, 0),
        [Color(0xff064e77).withOpacity(1), Color(0xff757575).withOpacity(1)],
        [0, 1]);
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.6090000, size.height * 0.8700000);
    path_2.cubicTo(size.width * 0.2960000, size.height * 0.7655000, 0,
        size.height * 0.8700000, 0, size.height * 0.8700000);
    path_2.cubicTo(
        0,
        size.height * 0.8700000,
        size.width * 0.3175000,
        size.height * 0.5010000,
        size.width * 0.4350000,
        size.height * 0.4000000);
    path_2.cubicTo(size.width * 0.5570000, size.height * 0.2955000,
        size.width * 0.8700000, 0, size.width * 0.8700000, 0);
    path_2.cubicTo(
        size.width * 0.8700000,
        0,
        size.width * 0.5395000,
        size.height * 0.5220000,
        size.width * 0.6090000,
        size.height * 0.8700000);
    path_2.close();

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = Color(0xff515151).withOpacity(.5);
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.7135000, size.height * 0.7135000);
    path_3.cubicTo(size.width * 0.2960000, size.height * 0.7135000, 0,
        size.height * 0.8700000, 0, size.height * 0.8700000);
    path_3.cubicTo(
        0,
        size.height * 0.8700000,
        size.width * 0.2100000,
        size.height * 0.5385000,
        size.width * 0.3745000,
        size.height * 0.3735000);
    path_3.cubicTo(size.width * 0.5390000, size.height * 0.2085000,
        size.width * 0.8700000, 0, size.width * 0.8700000, 0);
    path_3.cubicTo(
        size.width * 0.8700000,
        0,
        size.width * 0.7135000,
        size.height * 0.3130000,
        size.width * 0.7135000,
        size.height * 0.7135000);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.3750000, size.height * 0.3800000),
        Offset(size.width * 0.8400000, size.height * 0.8000000), [
      Color(0xff2d2d2d).withOpacity(1),
      Color(0xff393939).withOpacity(1),
      Color(0xff404040).withOpacity(1),
      Color(0xff464646).withOpacity(1),
      Color(0xff4a4a4a).withOpacity(1),
      Color(0xff4d4d4d).withOpacity(1),
      Color(0xff4f4f4f).withOpacity(1),
      Color(0xff515151).withOpacity(1)
    ], [
      0,
      0.09,
      0.18,
      0.31,
      0.44,
      0.59,
      0.75,
      1
    ]);
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
