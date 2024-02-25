import 'package:flutter/material.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(builder: (context, constraint) {
          bool useVerticalLayout = constraint.maxWidth < 700;

          return Flex(
            direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
            children: const [
              Text('Hello.........'),
              Text('World......'),
              Text('Hello.......'),
              Text('Po Po......'),
            ],
          );
        }),
        Expanded(
          child: AspectRatio(
            aspectRatio: 3 / 2,
            child: Container(
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 150),
          child: const Text(
            'Delicious Candy, Sweet Potato',
            style: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}
