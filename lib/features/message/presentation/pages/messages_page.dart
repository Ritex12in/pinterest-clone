import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _Header()),
            const SliverToBoxAdapter(child: _MessagesSection()),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Updates",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return _UpdateTile(
                    title: "Inspired by you",
                    time: "18h",
                    imageUrl: "https://picsum.photos/200",
                    unread: index % 2 == 0,
                  );
                },
                childCount: 6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          const Text(
            "Inbox",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _MessagesSection extends StatelessWidget {
  const _MessagesSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text("Messages", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Spacer(),
              Text("See all", style: TextStyle(color: Colors.white70)),
              SizedBox(width: 4),
              Icon(Icons.chevron_right, size: 18),
            ],
          ),
          const SizedBox(height: 16),

          const _MessageTile(
            title: "Pinterest India",
            subtitle: "Sent a Pin",
            trailing: "5y",
            icon: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.push_pin, color: Colors.white),
            ),
          ),

          const SizedBox(height: 12),

          const _MessageTile(
            title: "Find people to message",
            subtitle: "Connect to start chatting",
            trailing: "",
            icon: CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person_add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailing;
  final Widget icon;

  const _MessageTile({
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ),
        if (trailing.isNotEmpty)
          Text(trailing, style: const TextStyle(color: Colors.white54)),
      ],
    );
  }
}

class _UpdateTile extends StatelessWidget {
  final String title;
  final String time;
  final String imageUrl;
  final bool unread;

  const _UpdateTile({
    required this.title,
    required this.time,
    required this.imageUrl,
    required this.unread,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: unread?Colors.red:Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(imageUrl, width: 56, height: 56, fit: BoxFit.cover),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
          ),

          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

