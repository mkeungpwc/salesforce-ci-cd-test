@isTest  
public class AccountController2Test {  
    @isTest static void testAccountController2() {  
        // Create a test account  
        Account testAccount = new Account(Name = 'Test Account');  
        insert testAccount;  
          
        // Initialize the controller  
        AccountController2 controller = new AccountController2();  
          
        // Perform your test  
        System.assertEquals(testAccount.Name, controller.account.Name);  
    }  
}  