@isTest
public with sharing class ClientOnboardingCalloutTest {
    
    @testSetup
    static void setup(){
        Opportunity o = OpportunityTestData.createOpportunity('Test Name', 10000, 'New');
    }

    @isTest
    static void testCallout() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        Opportunity o = [SELECT Id, OwnerId, Owner.Name, Type, Amount, StageName, Description 
                         FROM Opportunity LIMIT 1];
        List<Opportunity> opplist = new List<Opportunity>();
        opplist.add(o);
        
        Map<String, String> oMap = new Map<String, String>();
        oMap.put(o.Id, '123456789123456789');
        String jsonString = JSON.serialize(oMap);
		
        Test.startTest();
            HttpResponse res = ClientOnboardingCallout.caseCreationCallout(opplist);
       	Test.stopTest();

        String contentType = res.getHeader('Content-Type');
        System.assertEquals(contentType, 'application/json');
        System.assertEquals(res.getBody(), jsonString);

    }
}