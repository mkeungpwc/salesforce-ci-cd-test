global with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    global static Account getAccountById(Id accountId) {
        return [SELECT Id, Name, Industry FROM Account WHERE Id = :accountId];
    }

    @AuraEnabled
    global static void updateAccountName(Id accountId, String accountName) {
        Account accountToUpdate = new Account(Id=accountId, Name=accountName);
        update accountToUpdate;
    }
}