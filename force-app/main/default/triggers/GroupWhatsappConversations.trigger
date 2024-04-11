trigger GroupWhatsappConversations on Whatsapp_Conversation__c (before insert) {
    Map<String, Contact> contactsByPhone = new Map<String, Contact>();
    
    // Loop through the inserted records and group them by customer phone number
    for (Whatsapp_Conversation__c conversation : Trigger.new) {
        String phoneNumber;
        if (conversation.From__c.startsWith('whatsapp:+14155238886')) {
            phoneNumber = conversation.To__c;
        } else if (conversation.To__c.startsWith('whatsapp:+14155238886')) {
            phoneNumber = conversation.From__c;
        } else {
            // Skip conversation records that are not with the business number
            continue;
        }
        
        // Check if there is an existing contact record for the phone number
        Contact contact;
        if (contactsByPhone.containsKey(phoneNumber)) {
            contact = contactsByPhone.get(phoneNumber);
        } else {
            // Query for an existing contact record with the same phone number
            List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Phone = :phoneNumber LIMIT 1];
            
            if (!existingContacts.isEmpty()) {
                // Associate the conversation record with the existing contact record
                contact = existingContacts[0];
            } else {
                // Create a new contact record if one doesn't exist
                contact = new Contact();
                contact.FirstName = 'WhatsApp';
                contact.LastName = 'Customer';
                contact.Phone = phoneNumber;
                insert contact; // Insert the new contact record
            }
            
            // Add the contact record to the map
            contactsByPhone.put(phoneNumber, contact);
        }
        
        // Associate the conversation record with the contact record
        conversation.WA_Contact__c = contact.Id;
    }
}