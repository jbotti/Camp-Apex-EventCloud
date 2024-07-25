global with sharing class ClientOnboardingSchedulable implements Schedulable, Database.AllowsCallouts {

    global void execute(SchedulableContext SC) {
        DateTime timeVar = DateTime.now().addMinutes(-30);
        List<Opportunity> oppList = [SELECT Id, Name, StageName, Amount, OwnerId, Owner.Name, Description, Type, Won_Date_Time__c
                                    FROM Opportunity WHERE StageName = 'Closed Won'
                                    AND Won_Date_Time__c > :timeVar AND Onboarding_Case_Number__c = ''];

        if(oppList.size() > 0){
            Id jobId = System.enqueueJob(new ClientOnboardingQueueable(oppList));
        }
    }
}