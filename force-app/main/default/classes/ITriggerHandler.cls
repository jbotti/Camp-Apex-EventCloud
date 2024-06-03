public interface ITriggerHandler{

    void beforeInsert(List<SObject> newList);
    void beforeUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void beforeDelete(List<SObject> oldList, Map<Id, SObject> oldMap);
    void afterInsert(List<SObject> newList, Map<Id, SObject> newMap);
    void afterUpdate(List<SObject> oldList, Map<Id, SObject> oldMap, List<SObject> newList, Map<Id, SObject> newMap);
    void afterDelete(List<SObject> oldList, Map<Id, SObject> oldMap);
    void afterUndelete(List<SObject> oldList, Map<Id, SObject> oldMap);
}