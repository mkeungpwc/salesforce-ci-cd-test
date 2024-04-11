public with sharing class AccountController2 {  
    public Account account {get; set;}  
    public String accountId {get; set;}  
      
    //updated
    public AccountController2() {  
        accountId = ApexPages.currentPage().getParameters().get('id');  
        account = [SELECT Id, Name FROM Account WHERE Id =: accountId];  
    }  
}  