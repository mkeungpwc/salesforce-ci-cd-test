public with sharing class BarcodeController {  
    public Contact contact {get; set;}  
      
    public BarcodeController() {  
        contact = [SELECT ID, FirstName FROM Contact WHERE Id = :ApexPages.currentPage().getParameters().get('id')];  
    }  
      //Add some test comments
    public String getBarcodeUrl() {  
        String baseUrl = 'https://www.barcodesinc.com/generator/image.php?style=197&type=C128B&width=200&height=50&xres=1&font=3&code=';  
        String barcodeUrl = baseUrl + EncodingUtil.urlEncode(contact.ID + Contact.FirstName, 'UTF-8');  
        return barcodeUrl;  
    }  
}