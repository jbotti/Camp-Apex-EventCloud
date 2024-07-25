public with sharing class ClientOnboardingQueueable implements Queueable, Database.AllowsCallouts{

    public List<Opportunity> oppList = new List<Opportunity>();

    public ClientOnboardingQueueable(List<Opportunity> opps) {
        oppList = opps;
    }

    public void execute(QueueableContext QC){
        ClientOnboardingCallout.buildRequest(oppList);
    }
}