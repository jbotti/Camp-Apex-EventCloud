public with sharing class CampX_EventService {

    public static void calculateNetRevenue(Map<Id, CAMPX__Event__c> oldMap, List<CAMPX__Event__c> newList, Map<Id, CAMPX__Event__c> newMap){
        if(oldMap == null){
            setNetRevenue(newList);
        }
        else {
            List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
            for(CAMPX__Event__c e : newMap.values()){
                if((e.CAMPX__GrossRevenue__c != oldMap.get(e.Id).CAMPX__GrossRevenue__c) || (e.CAMPX__TotalExpenses__c != oldMap.get(e.Id).CAMPX__TotalExpenses__c)){
                    eventsToUpdate.add(e);
                }
            }
            if(eventsToUpdate.size() > 0){
                setNetRevenue(eventsToUpdate);
            }
        }
    }
    
    public static void handleStatusChange(Map<Id, CAMPX__Event__c> oldMap, Map<Id, CAMPX__Event__c> newMap){
        for(CAMPX__Event__c event : newMap.values()){
            if(event.CAMPX__Status__c != oldMap.get(event.Id).CAMPX__Status__c){
                event.CAMPX__StatusChangeDate__c = System.now();
            }
        }
    }

    public static void setNetRevenue(List<CAMPX__Event__c> events){

        for(CAMPX__Event__c e : events){
            if(e.CAMPX__GrossRevenue__c == null || e.CAMPX__TotalExpenses__c == null){
                e.CAMPX__NetRevenue__c = null;
            }
            else {
                e.CAMPX__NetRevenue__c = (e.CAMPX__GrossRevenue__c - e.CAMPX__TotalExpenses__c);
            }
        }
    }

    public static void setStatus(List<CAMPX__Event__c> newRecords){
        for(CAMPX__Event__c newRec : newRecords){
            newRec.CAMPX__Status__c = 'Planning';
            newRec.CAMPX__StatusChangeDate__c = System.now();
        }
    }
}