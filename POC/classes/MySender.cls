global class MySender {
    public class NoDDPInfoException extends Exception { }
    
    @future(callout=true)
    public static void sendRequests(string encodedObjects, string sessionId) {
        // CHANGE ANY FILTER (WHERE) CRITERIA NECESSARY
       List<Loop__DDP__c> ddps = [SELECT Id, (SELECT Id FROM Loop__Custom_Integration_Options__r WHERE Name='Attachment') FROM Loop__DDP__c WHERE Name='Document102'];
        System.debug('ddPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPppp ');
       // List<Loop__DDP__c> ddps = [SELECT Id, (SELECT Id FROM Loop__Custom_Integration_Options__r WHERE Name='Email') FROM Loop__DDP__c WHERE Name='Document103'];
        // ALTERNATIVELY, DETERMINE WHICH DDP TO RUN FOR EACH RECORD
        
        if (ddps == null || ddps.size() < 1 || ddps[0].Loop__Custom_Integration_Options__r == null || ddps[0].Loop__Custom_Integration_Options__r.size() < 1) {
            // CHANGE THE EXCEPTION MESSAGE IF DESIRED
            System.debug('Exception+++++++++++++++++++++++++++++++++ ');
            throw new NoDDPInfoException('The DDP or Delivery Option specified was not found.');
        }
        
        Map<Id, Document102_DL__c> mySObjects = (Map<Id, Document102_DL__c>)JSON.deserialize(encodedObjects, Map<Id, Document102_DL__c>.class);
        
        Loop.loopMessage lm = new Loop.loopMessage();
        
        // SESSION ID NEEDED IF IT CANNOT BE DETERMINED FROM UserInfo.getSessionId()
        lm.sessionId = sessionId;
        String accountId = '0017F000004itGo';
        String contactId = '0037F00000EG8q6';
        for (Id sObjectId : mySObjects.keySet()) {
         System.debug('inloop+++++++++++++++++++++++++++++++++ ');
            Document102_DL__c  mySObject = mySObjects.get(sObjectId);
            // ADD A DDP RUN REQUEST
            lm.requests.add(new Loop.loopMessage.loopMessageRequest(
                sObjectId, // MAIN RECORD ID - SAME OBJECT AS THE DDP RECORD TYPE SPECIFIES
                ddps[0].Id,
                new Map<string, string>{
                    'deploy' => ddps[0].Loop__Custom_Integration_Options__r[0].Id,
                    'SFAccount' => accountId,
                    'SFContact' => contactId
                    // THESE PARAMETERS ARE THE SAME AS THOSE FOUND IN OUR OUTBOUND MESSAGE DOCUMENTATION
                    // PLEASE REFERENCE THAT DOCUMENTATION FOR ADDITIONAL OPTIONS
                }
            ));
        }
        System.debug('Helllllllllllllllllllllllll ' );
        // SEND ALL DDP RUN REQUESTS IN A SINGLE CALL OUT
        lm.sendAllRequests();
        System.debug('Hi+++++++++++++++++++ ' );
    }
}