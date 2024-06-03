public with sharing class CampX_EventService {
    
    public static void setStatus(List<CAMPX__Event__c> newRecords){
        for(CAMPX__Event__c newRec : newRecords){
            newRec.CAMPX__Status__c = 'Planning';
            newRec.CAMPX__StatusChangeDate__c = System.now();
        }
    }

    public static void handleStatusChange(Map<Id, CAMPX__Event__c> oldMap, Map<Id, CAMPX__Event__c> newMap){
        for(CAMPX__Event__c event : newMap.values()){
            if(event.CAMPX__Status__c != oldMap.get(event.Id).CAMPX__Status__c){
                event.CAMPX__StatusChangeDate__c = System.now();
            }
        }
    }
}