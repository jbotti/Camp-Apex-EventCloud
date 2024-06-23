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

        response.orderNumbers = 'mock response';
        //response.orderNumbers = orderCallout(orderList);
        List<Result> resultsWrapper = new List<Result>();
        resultsWrapper.add(response);
        return resultsWrapper;

    }

    public static String orderCallout(List<Order> orders){

        HttpResponse response = HttpCallout.callout('Post', 'endpoint', 'body');
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