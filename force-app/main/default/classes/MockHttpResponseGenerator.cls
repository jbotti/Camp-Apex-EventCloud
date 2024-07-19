@isTest
global with sharing class MockHttpResponseGenerator implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {
        
        List<Object> details = (List<Object>) JSON.deserializeUntyped(req.getBody());
        HttpResponse res = new HttpResponse();
        Map<String, String> responseMap = new Map<String, String>();

        for(Object obj : details){
            responseMap.put('12345', '678910');
        }

        res.setHeader('Content-Type','application/json');
        res.setBody(JSON.serialize(responseMap));
        res.setStatusCode(201);
        return res;
    }
}