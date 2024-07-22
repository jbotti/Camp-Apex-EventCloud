@isTest
global with sharing class MockHttpResponseGenerator implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {
        
        List<Object> details = (List<Object>) JSON.deserializeUntyped(req.getBody());
        HttpResponse res = new HttpResponse();
        Map<String, String> responseMap = new Map<String, String>();
        Opportunity o = [SELECT Id FROM Opportunity LIMIT 1];

        for(Object obj : details){
            responseMap.put(o.Id, '123456789123456789');
        }

        res.setHeader('Content-Type','application/json');
        res.setBody(JSON.serialize(responseMap));
        res.setStatusCode(201);
        return res;
    }
}