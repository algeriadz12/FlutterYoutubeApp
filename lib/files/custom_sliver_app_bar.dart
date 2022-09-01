import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset("assets/images/youtube_icon.png"),
      ),
      actions: [
        IconButton(onPressed: (){}, icon: const Icon(Icons.cast)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_outlined)),
        IconButton(onPressed: (){}, icon: const Icon(Icons.search)),
        IconButton(onPressed: (){}, icon: const CircleAvatar(
          foregroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/1200px-Pierre-Person.jpg'),
        ))
      ],
    );
  }
}
