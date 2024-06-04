public with sharing class CampX_SponsorService {

    public static void setDefaults(List<CAMPX__Sponsor__c> newList){

        for(CAMPX__Sponsor__c newRec : newList){
            if(newRec.CAMPX__Status__c == null || newRec.CAMPX__Status__c == ''){
                newRec.CAMPX__Status__c = 'Pending';
            }
        }
    }

    public static void emailValidation(Map<Id, CAMPX__Sponsor__c> newMap){
        for(CAMPX__Sponsor__c newRec : newMap.values()){
            if(newRec.CAMPX__Email__c == null || newRec.CAMPX__Email__c == ''){
                newRec.CAMPX__Email__c.addError('A sponsor can not be created without an email address');
            }
        }
    }

    public static void calculateTier(Map<Id, CAMPX__Sponsor__c> oldMap, List<CAMPX__Sponsor__c> newList, Map<Id, CAMPX__Sponsor__c> newMap){
        if(oldMap == null){
            setTier(newList);
        }
        else{
            List<CAMPX__Sponsor__c> updateList;
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
}