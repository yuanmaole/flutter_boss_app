import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boss_app/providers/index.dart';
import 'package:flutter_boss_app/service/service.dart';
import 'package:flutter_boss_app/utils/utils.dart';
import 'package:provider/provider.dart';
class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState()=>_LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  PageController _pageController;
  final _phoneInputController = new TextEditingController();
  int stag= 0;
  bool _showClearBtn = false;
  bool _showPassword =false;
  bool _disabledSend= false;
  String phone='';
  String password='';
  String code='';
  String buttonText = '发送验证码'; //初始文本
  int count = 60;      //初始倒计时时间
  Timer timer; 
  @override
  void initState() {
    _pageController = new PageController(initialPage: stag, keepPage: true);
    _phoneInputController.addListener((){
      if((_phoneInputController.text.length > 0) & !_showClearBtn){
        setState(() { _showClearBtn=true; });
      }else if((_phoneInputController.text.length == 0) & _showClearBtn){
        setState(() { _showClearBtn=false; });
      }
    });
    super.initState();
  }
  sendOtp() async{
    try {
      LoadingUtil.showLoading(context);
      var res = await UserService.sendRequest(context);
      if(res.statusCode==200){
        LogUtil.showToast('验证码已发送');
        _initTimer();
        setState(() { 
          stag = 2;
          _disabledSend = true;
          buttonText = '$count S';
        });
      }else{
        _initTimer();
        LogUtil.showToast('验证码发送失败,请重新发送！');
        setState(() { buttonText = '重新发送验证码'; });
      }
    } catch (e) {
      LogUtil.showToast('验证码发送失败,请重新发送！');
      setState(() { buttonText = '重新发送验证码'; });
    } finally {
      LoadingUtil.hideLoading(context);
    }
  }
  void _initTimer(){
    timer = new Timer.periodic(Duration(seconds: 1), (Timer timer) {
      count--;
      setState(() {
        if(count==0){
          timer.cancel();    //倒计时结束取消定时器
          _disabledSend = false;  //按钮可点击
          count = 60;  
          buttonText = '重新发送';
        }else{
          buttonText = '$count S';
        }

      });
    });
  }
  login() async{
    var res =stag==1 
    ? await Provider.of<UserStore>(context).loginWithPassword(context, phone, password)
    : await Provider.of<UserStore>(context).loginWithPhone(context, phone, code);
    if(res) NavigatorUtil.goHomePage(context);
  }
  _loginHandle(){
    if(stag == 0){
      if(!RulesUtil.isPhone(phone)) return LogUtil.showToast('请输入正确的手机号');
      sendOtp();
    }else if (stag == 1){
      if(!RulesUtil.isPhone(phone)) return LogUtil.showToast('请输入正确的手机号');
      if(!RulesUtil.isCorrectPwd(password)) return LogUtil.showToast('请输入合格的密码(6-32位字母或者.!@_-)');
      login();
    }else if(stag == 2){
      if(!RulesUtil.isPhone(phone)) return LogUtil.showToast('请输入正确的手机号');
      if(!RulesUtil.isCode(code)) return LogUtil.showToast('请输入正确的验证码');
      login();
    }
  }
  int last = 0;
  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 800) {
      LogUtil.showToast("再按一次退出应用");
      last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      LogUtil.cancelToast();
      return Future.value(true);
    }
  }
  @override
  Widget build(BuildContext context) {
    var abled = ((stag==0)&(phone.length>0))
    ||((stag==1)&(phone.length>0)&(password.length>0))
    ||((stag==2)&(phone.length>0));
    return WillPopScope(
      onWillPop: doubleBackExit,
      child: Scaffold(
        backgroundColor:Colors.white ,
        body: SafeArea(
          child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: setHeight(40)),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset(
                        'assets/images/icon_logo.png',
                        height: setHeight(80),
                        width: setHeight(80),
                      )
                  ),
                ),
                
                Stack(
                  children: <Widget>[
                    Container(
                      height: setHeight(230),
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        children: <Widget>[
                          firstPage(),
                          secendPage()
                        ],
                    )),
                    Positioned(
                      top: setHeight(110),
                      height: setHeight(44),
                      width: Screen.width,
                      child: Container(
                        // width: setWidth(80),
                        padding: EdgeInsets.symmetric(horizontal: setWidth(15)),
                        height: setHeight(44),
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          onPressed: abled ? ()=>_loginHandle() : null,
                          color: Theme.of(context).primaryColor,
                          disabledColor: Colors.grey,
                          // disabledTextColor: Colors.white, 
                          child: Text(stag==0 ? buttonText : '登录',style: TextStyle(color: Colors.white),),
                        ),
                      )
                  )
                ],)
              ]
            )
        ),
      )
    );
  }
  Widget firstPage()=>Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: setWidth(15)),
        height: setHeight(110),
        child: loginWithPhoneView(),
      ),
      SizedBox(height: setHeight(54),),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: setHeight(10),horizontal: setWidth(15)),
        child: GestureDetector(
          onTap: ()=>setState(() { 
            stag = 1;
            _pageController.animateToPage(1, duration: Duration(milliseconds: 300),curve: Curves.fastOutSlowIn,);
          }),
          child: Text('密码登录'),
        )
      )
    ],
  );
  Widget secendPage() =>Column(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(horizontal: setWidth(15)),
        height: setHeight(110),
        child: loginWithPwdView(),
      ),
      SizedBox(height: setHeight(54)),
      Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(vertical: setHeight(10),horizontal: setWidth(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: ()=>setState(() { 
                stag = 0;
                _pageController.animateToPage(0, duration: Duration(milliseconds: 300),curve: Curves.fastOutSlowIn,);
              }),
              child: Text('短信登录'),
            ),
            GestureDetector(
              onTap: (){},
              child: Text('忘记密码?',style: TextStyle(color: Theme.of(context).primaryColor,)),
            )
        ]),
      )  
    ],
  );
  Widget loginWithPhoneView() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      phoneInput(),
      Divider(height: 0.6,color: Color(0xffeaeaea),),
      stag==2?Container(
        height: setHeight(44),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color:Color(0xffeaeaea),width: 0.6)
          )
        ),
        child:Row(
        children: [
          Expanded(
            child: TextField(
              inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
              cursorColor: Theme.of(context).primaryColor,
              cursorWidth:1,
              maxLength: 6,
              onChanged: (text)=>setState((){code=text;}),
              obscureText: !_showPassword,
              decoration: InputDecoration(
                counterText:'',
                hintText: "请输入验证码",
                hintStyle: TextStyle(fontSize: setSp(14),color: Colors.grey),
                border: InputBorder.none,
              )
            )
          ,),
          SizedBox(width: setWidth(8)),
          Container(
            width: setWidth(80),
            height: setHeight(30),
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed:_disabledSend ? null : ()=> sendOtp(),
              color: Theme.of(context).primaryColor,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.white, 
              child: Text(buttonText,style: TextStyle(color: Colors.white),),
            ),
          ),
          SizedBox(width: setWidth(8)),
        ],
      )):Container()
     
    ],
  );
  Widget loginWithPwdView() => Column(
    children: <Widget>[
      phoneInput(),
      Divider(height: 1,color: Color(0xffeaeaea),),
      Container(
        height: setHeight(44),
        child:Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              inputFormatters:[WhitelistingTextInputFormatter(RegExp("[a-z0-9A-Z.!@_-]"))],
              cursorWidth:1,
              onChanged: (text)=>setState((){password=text;}),
              obscureText: !_showPassword,
              maxLength: 32,
              decoration: InputDecoration(
                counterText:'',
                hintText: "请输入密码",
                hintStyle: TextStyle(fontSize: setSp(14),color: Colors.grey),
                border: InputBorder.none,
              )
            )
          ,),
          SizedBox(width: setWidth(8)),
          GestureDetector(
            onTap: (){
              _showPassword =!_showPassword;
              setState((){});
            },
            child: Icon( _showPassword 
            ? Icons.panorama_fish_eye : Icons.remove_red_eye,
            color: Colors.grey,size: 18,),
          ),
          SizedBox(width: setWidth(8)),
        ],
      )),
      Divider(height: 1,color: Color(0xffeaeaea),),
    ]
  );
  Widget phoneInput()=> Container(
    height: setHeight(44),
    child: Row(
      children: <Widget>[
        GestureDetector(
          onTap: (){},
          child: Row(
            children: <Widget>[
              Text('+86',style: TextStyle(fontSize: 15)),
              Icon(Icons.keyboard_arrow_down,size: 18,)
            ],
          )
        ),
        SizedBox(width: setWidth(8)),
        Expanded(
          child: TextFormField(
            // autofocus: true,
            inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
            cursorColor: Theme.of(context).primaryColor,
            cursorWidth: 1,
            style: TextStyle(fontSize: setSp(14)),
            maxLength: 11,
            onChanged: (text)=>setState((){phone=text;}),
            controller: _phoneInputController,
            decoration: InputDecoration(
              counterText:'',
              hintText: "请输入您的手机号码",
              hintStyle: TextStyle(fontSize: setSp(14),color: Colors.grey),
              border: InputBorder.none,
            )
          )
        ),
        SizedBox(width: setWidth(8)),
        _showClearBtn
        ? GestureDetector(
          onTap: ()=>_phoneInputController.clear(),
          child: Icon( Icons.cancel,color: Colors.grey,size: 18),
        ): Container() ,
        SizedBox(width: setWidth(8)),
      ],
  ));
  Widget header() => Row(
    children: <Widget>[
       GestureDetector(
        onTap: ()=>setState(() { 
          stag = 0;
          _pageController.animateToPage(0, duration: Duration(milliseconds: 300),curve: Curves.fastOutSlowIn,);
        }),
        child: Text('手机号登录',style: TextStyle(fontSize:(stag != 1) ? setSp(22) : setSp(16))),
      ),
      SizedBox(width: 10,),
      GestureDetector(
         onTap: ()=>setState(() { 
          stag = 1;
          _pageController.animateToPage(1, duration: Duration(milliseconds: 300),curve: Curves.fastOutSlowIn,);
        }),
        child: Text('验证码登录',style: TextStyle(fontSize: stag ==1 ? setSp(22)  : setSp(16))),
      )
    ],
  );
}