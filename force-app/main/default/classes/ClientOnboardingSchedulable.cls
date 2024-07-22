global with sharing class ClientOnboardingSchedulable implements Schedulable {

    global void execute(SchedulableContext SC) {
        DateTime timeVar = DateTime.now().addMinutes(-30);
        List<Opportunity> oppList = [SELECT Id, Name, StageName, Amount, OwnerId, Owner.Name, Type, Won_Date_Time__c
                                    FROM Opportunity WHERE StageName = 'Closed Won'
                                    AND Won_Date_Time__c > :timeVar AND Onboarding_Case_Number__c = ''];

        if(oppList.size() > 0){
            ClientOnboardingCallout.buildCallout(oppList);
        }
    }
}