import 'package:madarj/Feature/leave/send_leave/apis/send_leave_service.dart';
import 'package:madarj/Feature/tasks/send_tasks/apis/send_tasks_service.dart';

class SendTaskRepo {
  SendTasksService _sendTasksService;
  SendTaskRepo(this._sendTasksService);
}
