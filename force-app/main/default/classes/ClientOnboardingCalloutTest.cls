@isTest
public with sharing class ClientOnboardingCalloutTest {

    @isTest
    static void testCallout() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        List<Opportunity> opplist = new List<Opportunity>();
        Opportunity o = OpportunityTestData.createOpportunity('Test Name', 10000, 'New');
        opplist.add(o);

        HttpResponse res = ClientOnboardingCallout.caseCreationCallout(opplist);

        String contentType = res.getHeader('Content-Type');
        System.assertEquals(contentType, 'application/json');
        System.assertEquals(res.getBody(), '{ "12345" : "678910" }');

    }
}