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

    public static String buildRequest(List<Order> orders){

        String endpoint = 'callout:BottiDev/services/data/v61.0/composite/tree/Order';
        String requestBody = JSON.serialize(orders);
        HttpResponse response = HttpCallout.callout('POST', endpoint, requestBody);
        return response.getBody();

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