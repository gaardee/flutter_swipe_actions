import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Swipe extends StatefulWidget {
  final Widget child;
  final List<SwipeAction> menuItems;
  final List<Function> menuFunctions;

  Swipe({
    this.child, this.menuItems, this.menuFunctions
  });

  @override
  SwipeState createState() {
    return new SwipeState();
  }
}

class SwipeState extends State<Swipe> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int _selected = 0;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int size = widget.menuItems.length * 60;
    double screenWidth = MediaQuery.of(context).size.width;
    double offset = size/screenWidth;
    int i = widget.menuItems.length;
    double _dragged = 0;

    final animation = new Tween(
        begin: const Offset(0.0, 0.0),
        end: Offset(-offset, 0.0)
    ).animate(new CurveTween(curve: Curves.linear).animate(_controller));

    return new GestureDetector(
      onHorizontalDragUpdate: (data) {
        // we can access context.size here
        double newValue = _controller.value - (data.primaryDelta / context.size.width);
        setState(() {
          _controller.value = newValue;
          _selected = ((newValue-(1.0/widget.menuItems.length)*0.6)/(1.0/widget.menuItems.length)).ceil();
        });
      },
      onHorizontalDragEnd: (data) {
        if(_selected > 0) {
          _controller.animateTo(_selected * (1.0 / widget.menuItems.length));
          widget.menuItems.elementAt(_selected - 1).onSelect();
          setState(() {
            _selected = 0;
          });
        }
        _controller.animateTo(0);
      },
      child: new Stack(
        children: <Widget>[
          Container(
            color: Colors.black12,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: widget.menuItems.reversed.map((action) {
                  if(_selected == i){
                    i--;
                    return Container(color: action.highlighColor, child: action);
                  }
                  i--;
                  return action;
                }).toList(),
              ),
            ),
          ),
          Text(_selected.toString()),
          new SlideTransition(position: animation, child: Container(color: Colors.white, child: widget.child)),
        ],
      ),
    );
  }
}

class SwipeAction extends StatefulWidget {
  bool highligthed;
  final IconData icon;
  final Function onSelect;
  final Color highlighColor;
  final String text;

  SwipeAction({
    this.icon, this.text = null, this.onSelect, this.highlighColor = Colors.red, this.highligthed = false
  });

  @override
  SwipeActionState createState() {
    return new SwipeActionState();
  }
}

class SwipeActionState extends State<SwipeAction> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Icon(widget.icon, color: (widget.highligthed ? widget.highlighColor : Colors.black54),
      ),
    );
  }
}