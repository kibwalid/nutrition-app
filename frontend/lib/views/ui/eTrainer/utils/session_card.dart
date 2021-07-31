import 'package:flutter/material.dart';

class SeassionCard extends StatelessWidget {
  final String sessionName;
  final bool isDone;
  final Function press;
  final bool locked;
  const SeassionCard({
    Key key,
    this.sessionName,
    this.isDone = false,
    this.press,
    this.locked = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 -
              10, // constraint.maxWidth provide us the available with for this widget
          // padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 23,
                spreadRadius: -13,
                color: Colors.black,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 42,
                      width: 43,
                      decoration: BoxDecoration(
                        color: isDone ? Color(0xFF817DC0) : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Color(0xFF817DC0)),
                      ),
                      child: Icon(
                        locked ? Icons.lock_rounded : Icons.play_arrow,
                        color: isDone ? Colors.white : Color(0xFF817DC0),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$sessionName",
                      style: Theme.of(context).textTheme.subtitle,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
