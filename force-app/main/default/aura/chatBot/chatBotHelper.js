/*({
    addMessageToChat: function(component, role, content) {
        var chatMessages = component.get("v.chatMessages");
        var message = {
            id: Date.now(),
            role: role,
           // content: content
            content: role === 'user' ? 'User: ' + content : 'AI: ' + content
        };
        chatMessages.push(message);
        component.set("v.chatMessages", chatMessages);
    }
})
*/
({
    addMessageToChat: function(component, role, content) {
        var chatMessages = component.get("v.chatMessages");
        var message = {
        id: Date.now(),
        role: role,
        content: role === 'user' ? 'User: ' + content : (chatMessages.length > 0 && chatMessages[chatMessages.length - 1].role === 'assistant' ? 'AI: ' + content : content)
        };

        chatMessages.push(message);
        component.set("v.chatMessages", chatMessages);
    }   
})