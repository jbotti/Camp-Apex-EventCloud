trigger CampX_EventTrigger on CAMPX__Event__c (before insert, before update, before delete, after insert, after update, after delete, after undelete) {
    if(!Bypass.ALL_PROCESSES_DISABLED && !Bypass.CAMPX_EVENT_PROCESSES_DISABLED){
        TriggerHandlerDispatcher.run(new CampX_EventTriggerHandler());
    }
}