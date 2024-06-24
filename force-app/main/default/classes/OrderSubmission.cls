public with sharing class OrderSubmission {

    @InvocableMethod (label = 'OrderSubmission')
    public static List<Result> submitOrder(List<Request> requests) {
        
        List<Order> orderList = new List<Order>();
        Result response = new Result();

        for(Opportunity opp : requests[0].oppList){
            Order ord = new Order();
            ord.AccountId = opp.AccountId;
            ord.OpportunityId = opp.Id;
            ord.Description = opp.Description;
            ord.EffectiveDate = System.today();
            ord.Type = opp.Type;
            ord.Status = 'Draft';
            orderList.add(ord);
        }

        //response.orderNumbers = 'mock response';
        response.orderNumbers = buildRequest(orderList);
        List<Result> resultsWrapper = new List<Result>();
        resultsWrapper.add(response);
        return resultsWrapper;

    }

    public static String buildRequest(List<Order> orderList){

        String endpoint = 'callout:BottiDev/services/data/v61.0/composite/tree/Order';
        String requestBody = buildJSON(orderList);
        HttpResponse response = HttpCallout.callout('POST', endpoint, requestBody);
        return response.getBody();

    }

    public static String buildJSON(List<Order> orderList){
        String jsonData = '';
        if(!orderList.isEmpty()){
            Integer i = 0;
            JSONGenerator jsonGen = JSON.createGenerator(true);
            jsonGen.writeStartObject();
            //jsonGen.writeBooleanField('allOrNone',false);
            jsonGen.writeFieldName('records');
            jsonGen.writeStartArray();
            for(Order o : orderList){
                jsonGen.writeStartObject();
                jsonGen.writeFieldName('attributes');
                jsonGen.writeStartObject();
                jsonGen.writeStringField('type','Order');
                jsonGen.writeStringField('referenceId','ref'+(i++));
                jsonGen.writeEndObject();
                jsonGen.writeStringField('Description',o.Description);
                jsonGen.writeStringField('Status', o.Status);
                jsonGen.writeDateField('EffectiveDate', o.EffectiveDate);
                jsonGen.writeIdField('AccountId','0015x00002OMXAdAAP');
                jsonGen.writeEndObject();
            }
            jsonGen.writeEndArray();
            jsonGen.writeEndObject();
            jsonData = jsonGen.getAsString();
        }
        return jsonData;

    }

    public class Request {
        @InvocableVariable (label = 'Opportunities')
        public list<Opportunity> oppList;
    }

    public class Result {
        @InvocableVariable (label = 'Order')
        public String orderNumbers;
    }
}