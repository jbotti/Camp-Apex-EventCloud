@RestResource (urlMapping = '/CaseService/*')
global with sharing class CaseService {

    @HttpPost
    global static void processWonOpps() {
        String jsonBody = RestContext.request.requestBody.toString();
        System.debug(jsonBody);
        List<OpportunityDetails> oppDetailList = (List<OpportunityDetails>) JSON.deserialize(jsonBody, List<OpportunityDetails>.class);

        List<Case> newCases = new List<Case>();
        for(OpportunityDetails detail : oppDetailList){
            Case c = new Case();
            c.Description = detail.description;
            c.Status = 'New';
            newCases.add(c);
        }
        try {
            insert newCases;
        }
        catch (Exception e){
            System.debug('Could not insert Case Records: ' + e.getMessage());
        }
    }

    class OpportunityDetails {

        public String ownerName;
        public String description;
        public Decimal amount;
        public String oppType;

    }
}