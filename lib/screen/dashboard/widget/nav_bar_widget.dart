
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  final int pageIndex;
  final Function(int) onTap;

  const NavBar({
    super.key,
    required this.pageIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: Theme.of(context).bottomAppBarTheme.color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 60,
          color: Theme.of(context).bottomAppBarTheme.color,
          child: Row(
            children: [
              navItem(
                FontAwesomeIcons.calendarWeek,
                pageIndex == 0,
                onTap: () => onTap(0),
              ),
              navItem(
                FontAwesomeIcons.heartCircleBolt,
                pageIndex == 1,
                onTap: () => onTap(1),
              ),
              const SizedBox(width: 80),
              navItem(
                FontAwesomeIcons.chartPie,
                pageIndex == 2,
                onTap: () => onTap(2),
              ),
              navItem(
                FontAwesomeIcons.gear,
                pageIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(IconData icon, bool selected, {Function()? onTap}) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : Colors.white.withOpacity(0.4),
            ),
            if(selected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 10,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
              )
          ],
        ),
      ),
    );
  }
}