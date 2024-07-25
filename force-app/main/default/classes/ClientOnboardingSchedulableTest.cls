@isTest
global with sharing class ClientOnboardingSchedulableTest {
    
    @testSetup
    static void setup(){
        Opportunity o = OpportunityTestData.createOpportunity('Test Name', 10000, 'Closed Won', true);
    }

    @isTest
    static void testSchedulable() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity o = [SELECT Id, OwnerId, Owner.Name, Type, Amount, StageName, Description, 
                         Won_Date_Time__c, Onboarding_Case_Number__c
                         FROM Opportunity LIMIT 1];
       
        String sch = '0 30 * ? * MON-FRI';
        String jobId = System.schedule('Client Onboarding Sch Test', sch, new ClientOnboardingSchedulable());
        Assert.isNotNull(jobId, 'No jobId was created.');

    }
}