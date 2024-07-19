@isTest
public with sharing class OpportunityTestData {

    public static Opportunity createOpportunity(String name, Integer amount, String stage) {
        Opportunity o = new Opportunity();
        o.Name = name;
        o.Amount = amount;
        o.StageName = stage;

        try{
            insert o;
        }
        catch(Exception e){
            System.debug('Error inserting Opportunity: ' + e.getMessage());
        }

        return o;
    }
}