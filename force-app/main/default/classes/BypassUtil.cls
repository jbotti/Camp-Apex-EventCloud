@IsTest
public class BypassUtil {
    
    public static void createBypass(Boolean allP, Boolean eventP, Boolean sponsorP){

        User u = new User();

        Bypass__c b = new Bypass__c();
        b.SetupOwnerId = u.Id;
        b.Bypass_All_Record_Triggered_Automation__c = allP;
        b.Bypass_CampX_Event_Automation__c = eventP;
        b.Bypass_CampX_Sponsor_Automation__c = sponsorP;
        insert b;
    }
    
}