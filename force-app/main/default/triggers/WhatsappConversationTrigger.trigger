trigger WhatsappConversationTrigger on Whatsapp_Conversation__c (before insert) {
    for (Whatsapp_Conversation__c record : Trigger.new) {
        if (!record.From__c.equals('whatsapp:+14155238886')) {
            String fromNumber = record.From__c;
            String text = record.Message_Text__c;
            TwilioSendWhatsappMessage.process(fromNumber, text);
        }
        
    }
}