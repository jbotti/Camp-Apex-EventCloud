public with sharing class EventContributionCalculator {
    
    public static void buildEventContributionMap(Set<Id> eventSet){
        Map<Id, List<CAMPX__Sponsor__c>> eventMap = new Map<Id, List<CAMPX__Sponsor__c>>();
        List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
        List<CAMPX__Sponsor__c> sponsorList = [SELECT Id, CAMPX__ContributionAmount__c, CAMPX__Event__c
                                               FROM CAMPX__Sponsor__c WHERE CAMPX__Status__c = 'Accepted' AND CAMPX__Event__c IN: eventSet];
        if(sponsorList.size() > 0){
            for(CAMPX__Sponsor__c s : sponsorList){
                if(eventMap.get(s.CAMPX__Event__c) != null){
                    eventMap.get(s.CAMPX__Event__c).add(s);
                }
                else {
                    List<CAMPX__Sponsor__c> addSponsors = new List<CAMPX__Sponsor__c>{s};
                    eventMap.put(s.CAMPX__Event__c, addSponsors);
                }
            }
        }
        for(Id eId : eventSet){
            if(!eventMap.containsKey(eId)){
                List<CAMPX__Sponsor__c> addSponsors = new List<CAMPX__Sponsor__c>();
                eventMap.put(eId, addSponsors);
            }
        }
        setTotalEventContribution(eventMap);
    }

    public static void setTotalEventContribution(Map<Id, List<CAMPX__Sponsor__c>> eventMap){

        List<CAMPX__Event__c> eventsToUpdate = [SELECT Id, CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id IN: eventMap.keySet()];

        for(CAMPX__Event__c e : eventsToUpdate){
            Decimal totalContribution = 0.0;
            if(eventMap.get(e.Id).size() > 0){
                for(CAMPX__Sponsor__c s : eventMap.get(e.Id)){
                    totalContribution += s.CAMPX__ContributionAmount__c;
                }
                e.CAMPX__GrossRevenue__c = totalContribution;
            }
            else{
                e.CAMPX__GrossRevenue__c = 0;
            }
        }
        try {
            update eventsToUpdate;
        }
        catch(DmlException e){
            System.debug('DML Error Message: ' + e.getMessage());
        }
    }
}