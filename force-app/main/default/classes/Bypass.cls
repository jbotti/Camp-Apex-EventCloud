public class Bypass {
    
    public static Boolean ALL_PROCESSES_DISABLED {
        get {
            if(ALL_PROCESSES_DISABLED == null){
                ALL_PROCESSES_DISABLED = (Bypass__c.getInstance()?.Bypass_All_Record_Triggered_Automation__c == true);
            }
            return ALL_PROCESSES_DISABLED;
        }
        private set;
    }
    public static Boolean CAMPX_EVENT_PROCESSES_DISABLED {
        get {
            if(CAMPX_EVENT_PROCESSES_DISABLED == null){
                CAMPX_EVENT_PROCESSES_DISABLED = (Bypass__c.getInstance()?.Bypass_CampX_Event_Automation__c == true);
            }
            return CAMPX_EVENT_PROCESSES_DISABLED;
        }
        private set;
    }
}