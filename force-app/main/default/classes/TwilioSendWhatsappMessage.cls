public class TwilioSendWhatsappMessage {
    @future(callout=true)
    public static void process(String fromNumber, String text) {
        String endpoint = 'https://pwcai.openai.azure.com/openai/deployments/GPT35/chat/completions?api-version=2023-03-15-preview';
        String apiKey = 'f379af432a914d87a79c86c41ce3b765';

        Map<String, Object> requestBody = new Map<String, Object>{
            'messages' => new List<Map<String, Object>>{
                new Map<String, Object>{
                    'role' => 'user',
                    'content' => text
                }
            }
        };

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('api-key', apiKey);
        request.setBody(JSON.serialize(requestBody));

        Http http = new Http();
        HttpResponse response = http.send(request);
        String strResponse = response.getBody();

        // Parse the JSON response into a Map<String, Object>
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(strResponse);
		String content;
        // Extract the content from the response map
       List<Object> choices = (List<Object>) responseMap.get('choices');
		if (!choices.isEmpty()) {
    		Map<String, Object> choice = (Map<String, Object>) choices.get(0);
   			content = (String) choice.get('text');
    		// Use the content variable to send a response to the user
		}
        // Make a second HTTP callout to the WhatsApp Logic API
        String Frrom = 'whatsapp:+14155238886';
        String to = fromNumber;
        String body = content;
        String messageSid = 'messageSidPlaceholder'; // Replace with actual value if available

        Map<String, String> data = new Map<String, String> {
            'from' => Frrom,
            'to' => to,
            'body' => body,
            'message_sid' => messageSid
        };

        HttpRequest secondRequest = new HttpRequest();
        secondRequest.setEndpoint('https://whatsapplogic.azurewebsites.net:443/api/whatsapp/triggers/When_a_HTTP_request_is_received/invoke?api-version=2022-05-01&sp=%2Ftriggers%2FWhen_a_HTTP_request_is_received%2Frun&sv=1.0&sig=LT-HSoWcDtUGnAPuoJEEtF8f5077ZwhNDQ9CrdaVyXs');
        secondRequest.setMethod('POST');
        secondRequest.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        secondRequest.setBody(getQueryString(data));

        HttpResponse secondResponse = http.send(secondRequest);
        String secondStrResponse = secondResponse.getBody();

        System.debug(secondStrResponse);
    }

    // Helper method to convert a Map<String, String> to a query string
    private static String getQueryString(Map<String, String> data) {
        List<String> parts = new List<String>();
        for (String key : data.keySet()) {
            String value = EncodingUtil.urlEncode(data.get(key), 'UTF-8');
            parts.add(key + '=' + value);
        }
        return String.join(parts, '&');
    }
}