public with sharing class CampX_EventTriggerHandler implements ITriggerHandler {

    public void beforeInsert(List<SObject> newList){
        CampX_EventService.setStatus(newList);
    }
    public void beforeUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap){

    }
    public void beforeDelete(List<SObject> oldList, Map<Id, SObject> oldMap){

    }
    public void afterInsert(List<SObject> newList, Map<Id, SObject> newMap){

    }
    public void afterUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap){

    }
    public void afterDelete(List<SObject> oldList, Map<Id, SObject> oldMap){

    }
    public void afterUndelete(List<SObject> oldList, Map<Id, SObject> oldMap){

    }
}
