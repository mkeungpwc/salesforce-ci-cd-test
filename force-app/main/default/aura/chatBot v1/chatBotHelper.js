({
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
