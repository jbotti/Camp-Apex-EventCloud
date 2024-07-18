public with sharing class ClientOnboardingCallout {

    public static void caseCreationCallout(List<Opportunity> oppList) {

        String endpoint = 'callout:BottiDev/services/apexrest/CaseService';
        List<OpportunityDetails> oppDetailList = new List<OpportunityDetails>();

        for(Opportunity opp : oppList){
            OpportunityDetails oppDetails = new OpportunityDetails();
            oppDetails.ownerName = opp.Owner.Name;
            oppDetails.description = opp.Description;
            oppDetails.amount = opp.Amount;
            oppDetails.oppType = opp.Type;
            oppDetailList.add(oppDetails);
        }

        Map<String, List<OpportunityDetails>> oppMap = new Map<String, List<OpportunityDetails>>();
        oppMap.put('records', oppDetailList);
        String requestBody = JSON.serialize(oppDetailList);
        System.debug(requestBody);

        HttpResponse response = HttpCallout.callout('POST',endpoint, requestBody);

    }

    class OpportunityDetails {

        public String ownerName;
        public String description;
        public Decimal amount;
        public String oppType;

    }

}