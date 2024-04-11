@isTest  
public class AccountController2Test {  
    @isTest static void testAccountController2() {  
        // Create a test account  
        Account testAccount = new Account(Name = 'Test Account');  
        insert testAccount;  
          
        // Set the Page context  
        Test.setCurrentPage(Page.AccountDetail); // replace with your VF page  
        ApexPages.currentPage().getParameters().put('id', testAccount.Id);  
          
        // Initialize the controller  
        AccountController2 controller = new AccountController2();  
          
        // Perform your test  
        System.assertEquals(testAccount.Name, controller.account.Name);  
    }  
}  