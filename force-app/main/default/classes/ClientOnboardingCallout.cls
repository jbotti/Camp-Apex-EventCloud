public with sharing class ClientOnboardingCallout {

    public static HttpResponse buildRequest(List<Opportunity> oppList) {

        String endpoint = 'callout:BottiDev/services/apexrest/CaseService';
        List<OpportunityDetails> oppDetailList = new List<OpportunityDetails>();

        for(Opportunity opp : oppList){
            OpportunityDetails oppDetails = new OpportunityDetails();
            oppDetails.ownerName = opp.Owner.Name;
            oppDetails.description = opp.Description;
            oppDetails.amount = opp.Amount;
            oppDetails.oppType = opp.Type;
            oppDetails.sourceRecordId = opp.Id;
            oppDetailList.add(oppDetails);
        }

        Map<String, List<OpportunityDetails>> oppMap = new Map<String, List<OpportunityDetails>>();
        oppMap.put('records', oppDetailList);
        String requestBody = JSON.serialize(oppDetailList);
        HttpResponse response = HttpCallout.callout('POST',endpoint, requestBody);

        if(response.getStatusCode() == 201){
            handleResponse(response);
        }
        else{
            System.debug('Error: ' + response.getStatusCode());
        }

        return response;
    }

    public static void handleResponse(HttpResponse response){

        Map<String, String> resmap = (Map<String, String>) JSON.deserialize(response.getBody(), Map<String,String>.class);
        List<Opportunity> resUpdates = new List<Opportunity>();

        for(String k : resmap.keySet()){
            Opportunity opp = new Opportunity();
            System.debug(k);
            opp.Id = k;
            opp.Onboarding_Case_Number__c = resmap.get(k);
            resUpdates.add(opp);
        }
        try{
            update resUpdates;
        }
        catch(Exception e){
            System.debug('Error when updating Opportunities: ' + e.getMessage());
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