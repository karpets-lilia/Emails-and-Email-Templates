global class ScheduleEmailManager implements Schedulable {
   global void execute(SchedulableContext SC) {
      EmailManager mail = new EmailManager(); 
   }
}