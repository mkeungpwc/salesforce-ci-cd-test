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

            // Convert conversation history JSON to list
            List<Map<String, String>> messages = new List<Map<String, String>>();
            
            // Add conversation history messages to messages list
            if (String.isNotBlank(conversationHistoryJson)) {
                List<Object> messageList = (List<Object>) JSON.deserializeUntyped(conversationHistoryJson);
                for (Object obj : messageList) {
                    Map<String, String> message = new Map<String, String>();
                    Map<String, Object> messageMap = (Map<String, Object>) obj;
                    message.put('role', (String) messageMap.get('role'));
                    message.put('content', (String) messageMap.get('content'));
                    messages.add(message);
                }
            }

            // Add user input message to messages list
            if (String.isNotBlank(userInput)) {
                Map<String, String> message = new Map<String, String>();
                message.put('role', 'user');
                message.put('content', userInput);
                messages.add(message);
            }

            // Count the number of messages sent by the user
            Integer userMessageCount = 0;
            for (Map<String, String> message : messages) {
                if (message.get('role').equals('user')) {
                    userMessageCount++;
                }
            }

            // Limit conversation history to a maximum of 5 messages
      //      if (userMessageCount > 10) {
     //           Integer messagesToRemove = userMessageCount - 1;
    //            Integer removedCount = 0;
                for (Integer i = messages.size(); i >= 10; i--) {
                    //if (messages.get(0).get('role').equals('user')) {
                     //   messages.remove(0);
     //                   removedCount++;
                    //}
                    //if (messages.get(0).get('role').equals('assistant')) {
                    //    messages.remove(0);
               // }
                    messages.remove(0);
            }
           // }
/*
            // Limit conversation history to a maximum of 5 messages
            if (userMessageCount > 10) {
                Integer messagesToRemove = userMessageCount - 1;
                Integer removedCount = 0;
                for (Integer i = messages.size()-1; i >= 0 && removedCount < messagesToRemove; i--) {
                    if (messages.get(i).get('role').equals('user')) {
                        messages.remove(i);
                        removedCount++;
                    }
                }
            }*/

            // Set up the request body
            Map<String, Object> requestBody = new Map<String, Object>();
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