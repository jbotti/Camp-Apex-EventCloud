@RestResource (urlMapping = '/CaseService/*')
global with sharing class CaseService {

    @HttpPost
    global static void processWonOpps() {
        String jsonBody = RestContext.request.requestBody.toString();
        System.debug(jsonBody);
        Map<String, String> responseMap = new Map<String, String>();
        RestResponse res = RestContext.response;
        List<OpportunityDetails> oppDetailList = (List<OpportunityDetails>) JSON.deserialize(jsonBody, List<OpportunityDetails>.class);

        List<Case> newCases = new List<Case>();
        for(OpportunityDetails detail : oppDetailList){
            Case c = new Case();
            c.Description = detail.description;
            c.Status = 'New';
            c.SourceOppId__c = detail.sourceRecordId;
            newCases.add(c);
        }
        try {
            insert newCases;
            for(Case c : newCases){
                responseMap.put(c.SourceOppId__c, c.Id);
            }
            res.addHeader('Content-Type','application/json');
            res.responseBody = Blob.valueOf(JSON.serialize(responseMap));
            res.statusCode = 201;
        }
        catch (Exception e){
            System.debug('Could not insert Case Records: ' + e.getMessage());
        }
    }

    class OpportunityDetails {

        public String sourceRecordId;
        public String ownerName;
        public String description;
        public Decimal amount;
        public String oppType;

    }
}