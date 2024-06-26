public class code39 {  
    public Contact contact { get; set; }  
    public String sourceCodeValue { get; set; }  
      
    static String keys = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-. $/+%*';  
    static String[] values = new String[] {  
        '1010001110111010', '1110100010101110', '1011100010101110', '1110111000101010',  
        '1010001110101110', '1110100011101010', '1011100011101010', '1010001011101110',  
        '1110100010111010', '1011100010111010', '1110101000101110', '1011101000101110',  
        '1110111010001010', '1010111000101110', '1110101110001010', '1011101110001010',  
        '1010100011101110', '1110101000111010', '1011101000111010', '1010111000111010',  
        '1110101010001110', '1011101010001110', '1110111010100010', '1010111010001110',  
        '1110101110100010', '1011101110100010', '1010101110001110', '1110101011100010',  
        '1011101011100010', '1010111011100010', '1110001010101110', '1000111010101110',  
        '1110001110101010', '1000101110101110', '1110001011101010', '1000111011101010',  
        '1000101011101110', '1110001010111010', '1000111010111010', '1000100010001010',  
        '1000100010100010', '1000101000100010', '1010001000100010', '1000101110111010' };  
      
    public String[] getBarCodeString() {  
        return generateCode39(sourceCodeValue, false).split('');  
    }  
      
    public String getBarCodeSource() {  
        return generateCode39(sourceCodeValue, false);  
    }  
      
    String generateCode39(String source, Boolean checkDigit) {  
        String[] result = new String[0];  
        Integer index, total = 0;  
        Integer[] keyValues = new Integer[0];  
        source = source == null? '': source;  
        result.add(values[keys.indexOf('*')]);  
        for(String sourceChar: source.toUpperCase().split('')) {  
            if((index = keys.indexOf(sourceChar)) > -1) {  
                result.add(values[index]);  
                total += index;  
            }  
        }  
        if(checkDigit) {  
            result.add(values[Math.mod(total, 43)]);  
        }  
        result.add(values[keys.indexOf('*')]);  
        return String.join(result,'');  
    }  
  
    public code39() {  
        String contactId = ApexPages.currentPage().getParameters().get('id');  
        this.contact = [SELECT Id, FirstName FROM Contact WHERE Id = :contactId];  
        this.sourceCodeValue = contact.Id + contact.FirstName;  
    }  
}