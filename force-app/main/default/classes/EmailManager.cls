public class EmailManager {
    
    public static void sendEmail() {
        
		List<Contact> contacts = [SELECT Id, Name FROM Contact WHERE CreatedDate = TODAY];
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE CreatedDate = TODAY];
        List<Case> cases = [SELECT Id FROM Case WHERE CreatedDate = TODAY];
        
        List<Profile> profiles = [SELECT Id, Name FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        List<User> userSysAdmin = [SELECT Id, Email FROM User WHERE ProfileId =: profiles[0].Id LIMIT 1];

        Messaging.reserveSingleEmailCapacity(2);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {userSysAdmin[0].Email}; 
            mail.setToAddresses(toAddresses);
        mail.setSenderDisplayName('Salesforce Support');
        mail.setSubject('New Records Contacts, Accounts, Cases');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('mail.setPlainTextBody');

        
        String htmlBody = '';
        
        htmlBody = 'Contacts: ';
        for (Contact contact : contacts) {
            htmlBody = htmlBody + contact.Name + ', ';
        }
        
        htmlBody = htmlBody + '</br> Accounts: ';
        for (Account account : accounts) {
            htmlBody += account.Name + ', ';
        }
        
        htmlBody = htmlBody + '</br> Cases: ';
        for (Case c : cases) {
            htmlBody += c.Id + ', ';
        }
        
        
        mail.setHtmlBody(htmlBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
      
    }
    
}