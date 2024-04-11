({
    handleInputChange: function(component, event, helper) {
        component.set("v.userInput", event.getSource().get("v.value"));
    },

    sendMessage: function(component, event, helper) {
        var userInput = component.get("v.userInput");
        var chatHistory = component.get("v.chatMessages");

        // Add user message to chat
        helper.addMessageToChat(component, 'user', userInput);

        // Send user message to chatbot and get response
        var action = component.get("c.getChatBotResponse");
        action.setParams({
            userInput: userInput,
            conversationHistoryJson: JSON.stringify(component.get("v.chatMessages"))
        });        
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                // Add chatbot response to chat
                helper.addMessageToChat(component, 'assistant', response.getReturnValue());
            } else {
                console.log("Error: ", response.getError());
            }
        });
        $A.enqueueAction(action);

        // Clear input field
        component.set("v.userInput", "");
    }
})