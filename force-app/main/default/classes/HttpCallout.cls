public with sharing class HttpCallout {

    public static HttpResponse callout(String method, String endpoint, String body) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod(method);
        request.setEndpoint(endpoint);
        request.setBody(body);
        if(method == 'GET'){
            request.setHeader('Content-Type', 'application/json');
        }

        HttpResponse response = Http.send(request);
        return response;
    }
}