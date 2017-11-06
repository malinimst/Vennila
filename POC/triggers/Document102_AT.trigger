trigger Document102_AT on Document102__c (after insert,after update) {
    
    echosign_dev1__Agreement_Template__c tem= [Select Id from echosign_dev1__Agreement_Template__c Where Name='Document102'];
    
    for (Document102__c currDoc : Trigger.new) {
        SendAgreement_Methods.sendAgreement(tem.Id , currDoc.id );
}
}