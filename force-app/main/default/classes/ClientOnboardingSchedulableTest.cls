@isTest
global with sharing class ClientOnboardingSchedulableTest implements Schedulable{

    @isTest
    static void testSchedulable() {

        String sch = '0 0/30 * * * MON-FRI';
        String jobId = System.schedule('Client Onboarding Sch Test', sch, new ClientOnboardingSchedulable());

    }
}