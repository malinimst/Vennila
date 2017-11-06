trigger Document_AT on Document102_DL__c  (after insert, after update) {

     Map<Id, Document102_DL__c> mySObjects = new Map<Id, Document102_DL__c>([
        SELECT Id 
        FROM Document102_DL__c  
        WHERE Id IN :Trigger.newMap.keySet()
    ]);
    
    if (mySObjects.size() > 0) {
        MySender.sendRequests(JSON.serialize(mySObjects), userInfo.getSessionId());
}

}