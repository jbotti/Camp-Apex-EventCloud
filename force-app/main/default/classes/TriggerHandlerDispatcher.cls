public with sharing class TriggerHandlerDispatcher {
    
    public static void run(ITriggerHandler handlerClass){

        switch on Trigger.operationType{
            when BEFORE_INSERT{
                handlerClass.beforeInsert(Trigger.new);
            }
            when BEFORE_UPDATE{
                handlerClass.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
            }
            when BEFORE_DELETE{
                handlerClass.beforeDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_INSERT{
                handlerClass.afterInsert(Trigger.new, Trigger.newMap);
            }
            when AFTER_UPDATE{
                handlerClass.afterUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
            }
            when AFTER_DELETE{
                handlerClass.afterDelete(Trigger.old, Trigger.oldMap);
            }
            when AFTER_UNDELETE{
                handlerClass.afterUndelete(Trigger.old, Trigger.oldMap);
            }
        }
    }
}