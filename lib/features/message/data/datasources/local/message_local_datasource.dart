import 'package:injectable/injectable.dart';
import '../../../../../core/enums/message_icon_type.dart';
import '../../models/chat_message_model.dart';
import '../../models/message_model.dart';

abstract class MessageLocalDatasource {
  Future<List<MessageModel>> getMessages();

  Future<List<ChatMessageModel>> getThreadMessages();

  Future<ChatMessageModel> sendThreadMessage(String text);
}

@LazySingleton(as: MessageLocalDatasource)
class MessageLocalDatasourceImpl implements MessageLocalDatasource {
  @override
  Future<List<MessageModel>> getMessages() async {
    return const [
      MessageModel(
        id: '1',
        title: 'Bank of America',
        preview: 'Bank of America : 256486 is the au...',
        timeLabel: 'Today',
        iconType: MessageIconType.bankOfAmerica,
        hasThread: true,
      ),
      MessageModel(
        id: '2',
        title: 'Account',
        preview: 'Your account is limited. Please foll...',
        timeLabel: '12/10',
        iconType: MessageIconType.account,
        hasThread: false,
      ),
      MessageModel(
        id: '3',
        title: 'Alert',
        preview: 'Your statement is ready for you to...',
        timeLabel: '11/10',
        iconType: MessageIconType.alert,
        hasThread: false,
      ),
      MessageModel(
        id: '4',
        title: 'Paypal',
        preview: 'Your account has been locked. Ple...',
        timeLabel: '10/11',
        iconType: MessageIconType.paypal,
        hasThread: false,
      ),
      MessageModel(
        id: '5',
        title: 'Withdraw',
        preview: 'Dear customer, 2987456 is your co...',
        timeLabel: '10/12',
        iconType: MessageIconType.withdraw,
        hasThread: false,
      ),
    ];
  }

  @override
  Future<List<ChatMessageModel>> getThreadMessages() async {
    return const [
      ChatMessageModel(
        text:
            'Did you attempt transaction on debit card ending in 0000 at '
            'Mechan1 in NJ for \$1,200? Reply YES or NO',
        isSent: false,
        dateLabel: '8/10/2018',
      ),
      ChatMessageModel(text: 'Yes', isSent: true),
      ChatMessageModel(
        text:
            'Bank of America : 256486 is your authorization code which '
            'expires in 10 minutes. If you didn\'t request the code. '
            'Call : 18009898 for assistance',
        isSent: false,
        dateLabel: '8/10/2018',
      ),
      ChatMessageModel(text: 'Thanks!', isSent: true),
    ];
  }

  @override
  Future<ChatMessageModel> sendThreadMessage(String text) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return ChatMessageModel(text: text, isSent: true);
  }
}
