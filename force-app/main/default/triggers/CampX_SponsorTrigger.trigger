trigger CampX_SponsorTrigger on CAMPX__Sponsor__c (before insert, before update, before delete, after insert, 
                                                   after update, after delete, after undelete) {

    if(!Bypass.ALL_PROCESSES_DISABLED && !Bypass.CAMPX_SPONSOR_PROCESSES_DISABLED){
        TriggerHandlerDispatcher.run(new CampX_SponsorTriggerHandler());
    }

}