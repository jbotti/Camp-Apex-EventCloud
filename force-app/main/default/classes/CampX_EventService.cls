public with sharing class CampX_EventService {
    
    public static void setStatus(List<SObject> newRecords){
        List<CAMPX__Event__c> NewEvents = newRecords;
        for(CAMPX__Event__c newRec : newEvents){
            newRec.CAMPX__Status__c = 'Planning';
        }
    }
}