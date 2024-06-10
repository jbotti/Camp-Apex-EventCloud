@IsTest
private class BypassTest {

    @isTest private static void allProcessesCheck_false(){

        BypassUtil.createBypass(false, false, false);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.ALL_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isFalse(isProcessDisabled, 'Expected all processes false but returned true.');
    }
    
    @isTest private static void allProcessesCheck_true(){

        BypassUtil.createBypass(true, false, false);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.ALL_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isTrue(isProcessDisabled, 'Expected all processes true but returned false.');
    }

    @isTest private static void eventProcesseesCheck_false(){

        BypassUtil.createBypass(false, false, false);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.CAMPX_EVENT_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isFalse(isProcessDisabled, 'Expected CampX Event process false but returned true.');
    }
    
    @isTest private static void eventProcessesCheck_true(){

        BypassUtil.createBypass(false, true, false);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.CAMPX_EVENT_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isTrue(isProcessDisabled, 'Expected CampX Event process true but returned false.');
    }

    @isTest private static void sponsorProcesseesCheck_false(){

        BypassUtil.createBypass(false, false, false);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.CAMPX_SPONSOR_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isFalse(isProcessDisabled, 'Expected CampX Sponsor process false but returned true.');
    }
    
    @isTest private static void sponsorProcessesCheck_true(){

        BypassUtil.createBypass(false, false, true);
        Bypass__c b = [SELECT Id FROM Bypass__c LIMIT 1];
        Test.startTest();
            Boolean isProcessDisabled = Bypass.CAMPX_SPONSOR_PROCESSES_DISABLED;
    
        Test.stopTest();

        Assert.isTrue(isProcessDisabled, 'Expected CampX Sponsor process true but returned false.');
    }
}