import 'package:flutter/material.dart';
import '../bottom_shape_clipper.dart';
import '../model/landing_list_model.dart';
import 'share_text_screen.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {

  bool isShareImage = false;
  bool isShareText = false;
  bool isShareTextWithImage = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //backgroundColor: backgroundColor,
        resizeToAvoidBottomInset: true,
        body:
            Container(
            color: Colors.white,
            child: SafeArea(
              top: true,
              bottom: false,
              child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    ClipPath(
                        clipper: BottomShapeClipper(),
                        child: Container(
                          color: Colors.blueAccent.shade700,
                        )),
                    SingleChildScrollView(
                      child: Container(
                        // margin: EdgeInsets.symmetric(horizontal: size.getWidthPx(20),
                        //     vertical: size.getWidthPx(20)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20,),
                              buildTopHeader(),
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  height: MediaQuery.of(context).size.height * .32,
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/header.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              //_loginGradientText(),
                              SizedBox(height: 10),
                              buildLandingList(),
                              SizedBox(height: 30),
                              //loginFields()
                            ]),
                      ),
                    )
                  ]),
            ),
          ),
        );
  }

  Widget buildTopHeader() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        'Choose Share Types',
        style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontFamily: 'Rubik'
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildLandingList() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: chooseList.length,
        itemBuilder: (context, index) {
          return buildLandingItem(index, chooseList);
        });
  }

  Widget buildLandingItem(int index, List<ChooseListModel> landingList) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(37, 5, 10, 5),
        child: InkWell(
          splashColor: landingList[index].colors!,
          child: Card(
              color: landingList[index].colors!,
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      landingList[index].text!,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Rubik'
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              )),
          onTap: () {
           if(landingList[index].text == "Share Text")
             {
               setState(() {
                 isShareImage = false;
                 isShareText = true;
                 isShareTextWithImage = false;
               });
             }
           if(landingList[index].text == "Share Image")
             {
               setState(() {
                 isShareImage = true;
                 isShareText = false;
                 isShareTextWithImage = false;
               });
             }
           if(landingList[index].text == "Share Image with Text")
           {
             setState(() {
               isShareImage = false;
               isShareText = false;
               isShareTextWithImage = true;
             });
           }
           Navigator.push(context, MaterialPageRoute(builder: (context)=> ShareTextScreen(isShareTextVisible: isShareText,isShareImageVisible : isShareImage, isShareTextWithImage: isShareTextWithImage,)));
          },
        ));
  }

  // RichText _textAccount() {
  //   return RichText(
  //     text: TextSpan(
  //         text: "Don't have an account? ",
  //         children: [
  //           TextSpan(
  //             style: TextStyle(color: Colors.deepOrange),
  //             text: 'Create your account.',
  //             // recognizer: TapGestureRecognizer()
  //             //   ..onTap = () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage())),
  //           )
  //         ],
  //         style: TextStyle(color: Colors.black87, fontSize: 14, fontFamily: 'Exo2')),
  //   );
  // }

  // GradientText _loginGradientText() {
  //   return GradientText('Login',
  //       gradient: LinearGradient(colors: [
  //         Color.fromRGBO(97, 6, 165, 1.0),
  //         Color.fromRGBO(45, 160, 240, 1.0)
  //       ]),
  //       style: TextStyle(fontFamily: 'Exo2',fontSize: 36, fontWeight: FontWeight.bold));
  // }

  // BoxField _emailWidget() {
  //   return BoxField(
  //       controller: _emailController,
  //       focusNode: _emailFocusNode,
  //       hintText: "Enter email",
  //       lableText: "Email",
  //       obscureText: false,
  //       onSaved: (String val) {
  //         _email = val;
  //       },
  //       onFieldSubmitted: (String value) {
  //         FocusScope.of(context).requestFocus(_passFocusNode);
  //       },
  //       icon: Icons.email,
  //       iconColor: colorCurve);
  // }

  // BoxField _passwordWidget() {
  //   return BoxField(
  //       controller: _passwordController,
  //       focusNode: _passFocusNode,
  //       hintText: "Enter Password",
  //       lableText: "Password",
  //       obscureText: true,
  //       icon: Icons.lock_outline,
  //       onSaved: (String val) {
  //         _password = val;
  //       },
  //       iconColor: colorCurve);
  // }

  // Container _loginButtonWidget() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //         vertical: 20, horizontal: 16),
  //     width: 200,
  //     child: RaisedButton(
  //       elevation: 8.0,
  //       shape: RoundedRectangleBorder(
  //           borderRadius: new BorderRadius.circular(30.0)),
  //       padding: EdgeInsets.all(12),
  //       child: Text(
  //         "LOGIN",
  //         style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
  //       ),
  //       //color: colorCurve,
  //       onPressed: () {
  //         // Going to DashBoard
  //         //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  //       },
  //     ),
  //   );
  // }

  Row _socialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        socialCircleAvatar("assets/icons/icnfb.png",(){}),
        SizedBox(width: 18),
        socialCircleAvatar("assets/icons/icn_twitter.png",(){}),
        SizedBox(width: 18),
        socialCircleAvatar("assets/icons/icngmail.png",(){}),
      ],
    );
  }

  GestureDetector socialCircleAvatar(String assetIcon,VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(

        maxRadius: 24,
        backgroundColor: Colors.transparent,
        child: Image.asset(assetIcon),
      ),
    );
  }


  // loginFields() =>
  //     Container(
  //       child: Form(
  //           key: _formKey,
  //           child: Column(
  //
  //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               //_emailWidget(),
  //               SizedBox(height:8),
  //               //_passwordWidget(),
  //               GestureDetector(
  //                   // onTap: () {
  //                   //   //Navigate to Forgot Password Screen...
  //                   //   Navigator.push(context, MaterialPageRoute(builder: (context) => PageForgotPassword()));
  //                   // },
  //                   child: Padding(
  //                     padding: EdgeInsets.only(right: 24),
  //                     child: Align(
  //                         alignment: Alignment.centerRight,
  //                         child: Text("Forgot Password?",
  //                             style: TextStyle(fontFamily: 'Exo2',fontSize: 16.0))),
  //                   )),
  //               SizedBox(height: 8),
  //               _loginButtonWidget(),
  //               SizedBox(height:28),
  //
  //               Text("Or Login with", style: TextStyle(fontFamily: 'Exo2',fontSize: 16.0, color: Colors.grey),
  //               ),
  //               SizedBox(height: 12),
  //               _socialButtons()
  //
  //             ],
  //           )),
  //     );
}