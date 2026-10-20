class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isRead;
  final String type; 

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
    this.type = 'booking',
  });
}

final List<NotificationModel> mockNotifications = [
  const NotificationModel(
    id: 'n1',
    title: 'Booking Confirmed!',
    message: 'Your Tesla Model S rental has been confirmed for 19 Jan - 22 Jan.',
    time: '2 hours ago',
    isRead: false,
    type: 'booking',
  ),
  const NotificationModel(
    id: 'n2',
    title: 'Car Ready For Pickup',
    message: 'Host Hela Quintin has parked the car at Shore Dr, Chicago.',
    time: '4 hours ago',
    isRead: false,
    type: 'reminder',
  ),
  const NotificationModel(
    id: 'n3',
    title: 'Special 20% Discount',
    message: 'Get 20% off your next weekend trip with any luxury Ferrari.',
    time: 'Yesterday',
    isRead: true,
    type: 'promo',
  ),
  const NotificationModel(
    id: 'n4',
    title: 'Payment Successful',
    message: 'Received \$1,400 receipt for booking #QENT-8892.',
    time: '2 days ago',
    isRead: true,
    type: 'booking',
  ),
];
