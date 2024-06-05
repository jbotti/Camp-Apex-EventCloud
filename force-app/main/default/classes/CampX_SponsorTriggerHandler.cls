public with sharing class CampX_SponsorTriggerHandler implements ITriggerHandler {
    
    public void beforeInsert(List<SObject> newList){
        CampX_SponsorService.setDefaults((List<CAMPX__Sponsor__c>) newList);
        CampX_SponsorService.calculateTier(null, (List<CAMPX__Sponsor__c>) newList, null);
    }
    public void beforeUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap){
        CampX_SponsorService.calculateTier((Map<Id, CAMPX__Sponsor__c>) oldMap, (List<CAMPX__Sponsor__c>) newList, 
                                           (Map<Id, CAMPX__Sponsor__c>) newMap);
    }
    public void beforeDelete(List<SObject> oldList, Map<Id, SObject> oldMap){}
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap){
        CampX_SponsorService.calculateTotalEventContribution(null, (List<CAMPX__Sponsor__c>) newList, (Map<Id, CAMPX__Sponsor__c>) newMap);
        CampX_SponsorService.validateEmail((Map<Id, CAMPX__Sponsor__c>) newMap);
        CampX_SponsorService.validateEvent((List<CAMPX__Sponsor__c>) newList);
    }
    public void afterUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap){
        CampX_SponsorService.calculateTotalEventContribution((Map<Id, CAMPX__Sponsor__c>) oldMap, (List<CAMPX__Sponsor__c>) newList, 
        (Map<Id, CAMPX__Sponsor__c>) newMap);
        CampX_SponsorService.validateEvent((List<CAMPX__Sponsor__c>) newList);
    }
    public void afterDelete(List<SObject> oldList, Map<Id, SObject> oldMap){}
    public void afterUndelete(List<SObject> oldList, Map<Id, SObject> oldMap){}
}