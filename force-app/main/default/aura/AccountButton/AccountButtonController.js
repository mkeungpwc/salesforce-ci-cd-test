({
    handleSave : function(component, event, helper) {
        var account = component.get("v.account");
        var action = component.get("c.updateAccountName");
        action.setParams({ accountId : account.Id, accountName : account.Name });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.find("overlayLib").notifyClose();
                $A.get("e.force:refreshView").fire();
            }
            else {
                console.log("Failed to update account name.");
            }
        });
        $A.enqueueAction(action);
    },
    init : function(component, event, helper) {
        var accountId = component.get("v.recordId");
        var action = component.get("c.getAccountById");
        action.setParams({ accountId : accountId });
        action.setCallback(this, function(response) {
            if (response.getState() === "SUCCESS") {
                component.set("v.account", response.getReturnValue());
                var industry = response.getReturnValue().Industry;
                if(industry !== 'Apparel') {
                    component.set("v.showComponent", false);
                } else {
                    component.set("v.showComponent", true);
                }
            }
            else {
                console.log("Failed to retrieve account.");
            }
        });
        $A.enqueueAction(action);
    },
    handleCancel : function(component, event, helper) {
        component.find("overlayLib").notifyClose();
    }
})