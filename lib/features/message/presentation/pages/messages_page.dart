import 'package:flutter/material.dart';
import 'package:pinterest_clone/core/constants/constants.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final updateList = Constants.updateList;
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
              delegate: SliverChildBuilderDelegate((context, index) {
                final update = updateList.elementAt(index);
                return _UpdateTile(
                  title: update.title,
                  time: update.time,
                  imageUrl: update.imageUrl,
                  unread: update.unread,
                );
              }, childCount: 6),
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
          IconButton(icon: const Icon(Icons.edit_outlined), onPressed: () {}),
        ],
      ),
    );
  }
}

class _MessagesSection extends StatelessWidget {
  const _MessagesSection();

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                "Messages",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "See all",
                style: TextStyle(color: textColor?.withValues(alpha: 0.6)),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.chevron_right, size: 18),
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

          _MessageTile(
            title: "Find people to message",
            subtitle: "Connect to start chatting",
            trailing: "",
            icon: CircleAvatar(
              backgroundColor: textColor?.withValues(alpha: 0.2),
              child: Icon(Icons.person_add),
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
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Row(
      children: [
        icon,
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                subtitle,
                style: TextStyle(color: textColor?.withValues(alpha: 0.6)),
              ),
            ],
          ),
        ),
        if (trailing.isNotEmpty)
          Text(
            trailing,
            style: TextStyle(color: textColor?.withValues(alpha: 0.6)),
          ),
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
    final textColor = Theme.of(context).textTheme.bodyLarge!.color;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: unread ? Colors.red : Colors.transparent,
              shape: BoxShape.circle,
            ),
          ),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    color: textColor?.withValues(alpha: 0.6),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          IconButton(icon: const Icon(Icons.more_horiz), onPressed: () {}),
        ],
      ),
    );
  }
}
