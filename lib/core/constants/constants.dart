import 'package:pinterest_clone/features/message/domain/model/update_model.dart';

class Constants {
  static final updateList = {
    UpdateModel(
      title: 'Back to your happy place',
      time: '5h',
      imageUrl: 'assets/images/notify2.jpg',
      unread: true,
    ),
    UpdateModel(
      title: 'Just trust us',
      time: '18h',
      imageUrl: 'assets/images/notify1.jpg',
      unread: true,
    ),
    UpdateModel(
      title: 'Inspired by you',
      time: '1d',
      imageUrl: 'assets/images/notify3.jpg',
      unread: false,
    ),
    UpdateModel(
      title: 'Your taste is next level',
      time: '1d',
      imageUrl: 'assets/images/notify4.jpg',
      unread: false,
    ),
    UpdateModel(
      title: 'Natural collection',
      time: '2d',
      imageUrl: 'assets/images/notify5.jpg',
      unread: false,
    ),
    UpdateModel(
      title: 'Aesthetic for you',
      time: '3d',
      imageUrl: 'assets/images/notify6.jpg',
      unread: false,
    ),
  };
}
