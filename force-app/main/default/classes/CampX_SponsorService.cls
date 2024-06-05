public with sharing class CampX_SponsorService {

    public static void calculateTotalEventContribution(Map<Id, CAMPX__Sponsor__c> oldMap, List<CAMPX__Sponsor__c> newList, Map<Id, CAMPX__Sponsor__c> newMap){
        Set<Id> events = new Set<Id>();
        if(oldMap == null){
            for(CAMPX__Sponsor__c s : newList){
                if(s.CAMPX__ContributionAmount__c != null && s.CAMPX__ContributionAmount__c > 0){
                    events.add(s.CAMPX__Event__c);
                }
            }
        }
        else{
            for(CAMPX__Sponsor__c s : newMap.values()){
                if(s.CAMPX__Status__c == 'Accepted' && s.CAMPX__Status__c != oldMap.get(s.Id).CAMPX__Status__c && s.CAMPX__ContributionAmount__c != null){
                    events.add(s.CAMPX__Event__c);
                }
                else if(s.CAMPX__Status__c == 'Accepted' && s.CAMPX__ContributionAmount__c != oldMap.get(s.Id).CAMPX__ContributionAmount__c && s.CAMPX__ContributionAmount__c != null){
                    events.add(s.CAMPX__Event__c);
                }
            }
        }
        if(events.size() > 0){
            setTotalEventContribution(events);
        }
    }

    public static void calculateTier(Map<Id, CAMPX__Sponsor__c> oldMap, List<CAMPX__Sponsor__c> newList, Map<Id, CAMPX__Sponsor__c> newMap){
        if(oldMap == null){
            setTier(newList);
        }
        else{
            List<CAMPX__Sponsor__c> updateList = new List<CAMPX__Sponsor__c>();
            for(CAMPX__Sponsor__c sponsor : newMap.values()){
                if(sponsor.CAMPX__ContributionAmount__c != oldMap.get(sponsor.Id).CAMPX__ContributionAmount__c){
                    updateList.add(sponsor);
                }
            }
            if(updateList.size() > 0){
                setTier(updateList);
            }
        }
    }

    public static void setDefaults(List<CAMPX__Sponsor__c> newList){

        for(CAMPX__Sponsor__c newRec : newList){
            if(newRec.CAMPX__Status__c == null || newRec.CAMPX__Status__c == ''){
                newRec.CAMPX__Status__c = 'Pending';
            }
        }
    }

    public static void setTier(List<CAMPX__Sponsor__c> sponsorList){
        for(CAMPX__Sponsor__c sponsor : sponsorList){
            if(sponsor.CAMPX__ContributionAmount__c > 0 && sponsor.CAMPX__ContributionAmount__c < 1000){
                sponsor.CAMPX__Tier__c = 'Bronze';
            }
            else if(sponsor.CAMPX__ContributionAmount__c >= 1000 && sponsor.CAMPX__ContributionAmount__c < 5000){
                sponsor.CAMPX__Tier__c = 'Silver';
            }
            else if(sponsor.CAMPX__ContributionAmount__c >= 5000){
                sponsor.CAMPX__Tier__c = 'Gold';
            }
            else{
                sponsor.CAMPX__Tier__c = null;
            }
        }
    }

    public static void setTotalEventContribution(Set<Id> eventSet){
        Map<Id, List<CAMPX__Sponsor__c>> eventMap = new Map<Id, List<CAMPX__Sponsor__c>>();
        List<CAMPX__Event__c> eventsToUpdate = new List<CAMPX__Event__c>();
        List<CAMPX__Sponsor__c> sponsorList = [SELECT Id, CAMPX__ContributionAmount__c, CAMPX__Event__c
                                               FROM CAMPX__Sponsor__c WHERE CAMPX__Status__c = 'Accepted' AND CAMPX__Event__c IN: eventSet];

        for(CAMPX__Sponsor__c s : sponsorList){
            if(eventMap.get(s.CAMPX__Event__c) != null){
                eventMap.get(s.CAMPX__Event__c).add(s);
            }
            else {
                List<CAMPX__Sponsor__c> addSponsors = new List<CAMPX__Sponsor__c>{s};
                eventMap.put(s.CAMPX__Event__c, addSponsors);
            }
        }
        eventsToUpdate = [SELECT Id, CAMPX__GrossRevenue__c FROM CAMPX__Event__c WHERE Id IN: eventMap.keySet()];

        for(CAMPX__Event__c e : eventsToUpdate){
            Decimal totalContribution = 0.0;
            for(CAMPX__Sponsor__c s : eventMap.get(e.Id)){
                totalContribution += s.CAMPX__ContributionAmount__c;
            }
            e.CAMPX__GrossRevenue__c = totalContribution;
        }
        try {
            update eventsToUpdate;
        }
        catch(DmlException e){
            System.debug('DML Error Message: ' + e.getMessage());
        }
    }

    public static void validateEmail(Map<Id, CAMPX__Sponsor__c> newMap){
        for(CAMPX__Sponsor__c newRec : newMap.values()){
            if(newRec.CAMPX__Email__c == null || newRec.CAMPX__Email__c == ''){
                newRec.CAMPX__Email__c.addError('A sponsor can not be created without an email address');
            }
        }
    }

    public static void validateEvent(List<CAMPX__Sponsor__c> newList){
        for(CAMPX__Sponsor__c sponsor : newList){
            if(sponsor.CAMPX__Event__c == null && sponsor.CAMPX__Status__c == 'Accepted'){
                sponsor.CAMPX__Event__c.addError('A Sponsor must be associated with an event before being Accepted.');
            }
        }

    }
}