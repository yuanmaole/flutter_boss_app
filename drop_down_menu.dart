import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DropdownMenuController extends ChangeNotifier {
  double dropDownHearderHeight;

  bool isShow=false;

  void show() {
    isShow=true;
    notifyListeners();
  }

  void hide(){
    isShow=false;
    notifyListeners();
  }
}

class DropDownMenu extends StatefulWidget {
  final DropdownMenuController controller;
  final double height;
  final Widget child;
  final int animationMilliseconds;

  const DropDownMenu({Key key,
    @required this.controller,
    @required this.child,
    @required this.height,
    this.animationMilliseconds = 200})
      : super(key: key);

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> with SingleTickerProviderStateMixin {
  bool _isShowMask = false;

  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    widget.controller.addListener(_onController);
    _controller = new AnimationController(duration: Duration(milliseconds: widget.animationMilliseconds), vsync: this);
  }

  _onController() {
    _showDropDownItemWidget();
  }

  @override
  Widget build(BuildContext context) {
    _controller.duration=Duration(milliseconds: widget.animationMilliseconds);
    return _buildDropDownWidget();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  _showDropDownItemWidget() {
    if ( widget.child == null) {
      return;
    }
    _isShowMask = !_isShowMask;

    _animation = new Tween(begin: 0.0, end: widget.height).animate(_controller)
      ..addListener(() {
        //这行如果不写，没有动画效果
        setState(() {});
      });

    if (_animation.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  _hideDropDownItemWidget() {
    _isShowMask = !_isShowMask;
    _controller.reverse();
  }

  Widget _mask() {
    if (_isShowMask) {
      return GestureDetector(
        onTap: () {
          _hideDropDownItemWidget();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color.fromRGBO(0, 0, 0, 0.1),
        ),
      );
    } else {
      return Container(
        height: 0,
      );
    }
  }

  Widget _buildDropDownWidget() {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      top: widget.controller.dropDownHearderHeight,
      left: 0,
      child: Column(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[100].withOpacity(0.8),
                    blurRadius: 1.0,
                  ),
                ]
              ),
              height: _animation == null ? 0 : _animation.value,

              child: widget.child,
            ), 
          _mask()
        ],
      )
    );
  }
}
