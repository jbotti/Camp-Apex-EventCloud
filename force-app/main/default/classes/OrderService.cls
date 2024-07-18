@RestResource (urlMapping = '/OrderService/*')
global with sharing class OrderService {

    @HttpPost
    global static List<String> processOrders() {
        String jsonBody = RestContext.request.requestBody.toString();
        System.debug(jsonBody);
        List<Order> orderList = (List<Order>)JSON.deserialize(jsonBody, List<Order>.class);
        System.debug(orderList);
        Boolean processStatus = false;

        try{
            insert orderList;
            processStatus = true;
        }
        catch(Exception e){
            System.debug('Error on Order insert: ' + e.getMessage());
        }

        List<String> orderNumbers = new List<String>();
        if(processStatus == true){
            for(Order o : orderList){
                orderNumbers.add(o.OrderNumber);
            }
        }
        return orderNumbers;
    }
}