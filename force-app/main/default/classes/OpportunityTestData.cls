@isTest
public with sharing class OpportunityTestData {

    public static Opportunity createOpportunity(String name, Integer amount, String stage, Boolean setWonDateTime){
        Opportunity o = new Opportunity();
        o.Name = name;
        o.Amount = amount;
        o.StageName = stage;
        o.CloseDate = Date.today();
        o.Onboarding_Case_Number__c = '';
        o.Description = '';
        if(setWonDateTime){
            o.Won_Date_Time__c = DateTime.now().addMinutes(-60);
        }

        try{
            insert o;
        }
        catch(Exception e){
            System.debug('Error inserting Opportunity: ' + e.getMessage());
        }

        return o;
    }
}