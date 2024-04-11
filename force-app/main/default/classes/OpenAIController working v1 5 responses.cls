// f379af432a914d87a79c86c41ce3b765
// https://pwcai.openai.azure.com/openai/deployments/GPT35/chat/completions?api-version=2023-03-15-preview

public with sharing class OpenAIController {
    @AuraEnabled(cacheable=true)
    public static String getChatBotResponse(String userInput, String conversationHistoryJson) {
        String response;
        try {
            // Set up the request headers
            Map<String, String> headers = new Map<String, String>();
            headers.put('Content-Type', 'application/json');
            headers.put('api-key', 'f379af432a914d87a79c86c41ce3b765');

            // Set up the request body
            Map<String, Object> requestBody = new Map<String, Object>();
            List<Map<String, String>> messages = new List<Map<String, String>>();

            //Add conversation history first
            if (String.isNotBlank(conversationHistoryJson)) {
                Map<String, String> messageHistory = new Map<String, String>();
                messageHistory.put('role','user');
                messageHistory.put('content', JSON.deserializeUntyped(conversationHistoryJson).toString());
                messages.add(messageHistory);
            }

            if (String.isNotBlank(userInput)) {
                Map<String, String> message = new Map<String, String>();
                message.put('role', 'user');
                message.put('content', userInput);
                messages.add(message);
            }
            requestBody.put('messages', messages);

            // Send the request and store the response in a variable
            HttpRequest request = new HttpRequest();
            request.setEndpoint('https://pwcai.openai.azure.com/openai/deployments/GPT35/chat/completions?api-version=2023-03-15-preview');
            request.setMethod('POST');
            request.setBody(JSON.serialize(requestBody));
            for (String key : headers.keySet()) {
                request.setHeader(key, headers.get(key));
            }
            HttpResponse httpResponse = new Http().send(request);
            response = httpResponse.getBody();
            //only showing the content to the user
            Map<String, Object> parsedResponse = (Map<String, Object>) JSON.deserializeUntyped(response);
            List<Object> choices = (List<Object>) parsedResponse.get('choices');
            Map<String, Object> messageObject = (Map<String, Object>) choices[0];
            Map<String, Object> messageContent = (Map<String, Object>) messageObject.get('message');
            response = (String) messageContent.get('content');

        } catch (Exception ex) {
            System.debug(ex);
        }
        return response;
    }
}
