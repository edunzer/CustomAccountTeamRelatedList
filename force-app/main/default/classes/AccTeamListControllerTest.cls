@isTest
private class AccTeamListControllerTest {

    @isTest
    static void testGetTeamMembers_WithNullId() {
        Boolean exceptionThrown = false;
        try {
            AccTeamListController.getTeamMembers(null);
        } catch (AuraHandledException ex) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Expected AuraHandledException to be thrown');
    }

    @isTest
    static void testAddTeamMember_WithInvalidIds() {
        Boolean exceptionThrown = false;
        try {
            Id fakeAccId = '001000000000001';
            Id fakeUserId = '005000000000001';
            String role = 'TestRole';

            Test.startTest();
            AccTeamListController.addTeamMember(fakeAccId, fakeUserId, role);
            Test.stopTest();
        } catch (AuraHandledException ex) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Expected AuraHandledException to be thrown');
    }

    @isTest
    static void testAddTeamMember_WithMissingParams() {
        Boolean exceptionThrown = false;
        try {
            AccTeamListController.addTeamMember(null, null, '');
        } catch (AuraHandledException ex) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Expected AuraHandledException to be thrown');
    }

    @isTest
    static void testDeleteTeamMember_WithNullId() {
        Boolean exceptionThrown = false;
        try {
            AccTeamListController.deleteTeamMember(null);
        } catch (AuraHandledException ex) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Expected AuraHandledException to be thrown');
    }

    @isTest
    static void testDeleteTeamMember_WithInvalidId() {
        Boolean exceptionThrown = false;
        try {
            Id fakeTeamMemberId = '00k000000000001';
            AccTeamListController.deleteTeamMember(fakeTeamMemberId);
        } catch (AuraHandledException ex) {
            exceptionThrown = true;
        }
        System.assert(exceptionThrown, 'Expected AuraHandledException to be thrown');
    }

    @isTest
    static void testHasCreatePermissionOnAccount() {
        Boolean result = AccTeamListController.hasCreatePermissionOnAccount();
        System.assertEquals(true, result); // Should reflect actual org permission
    }

    @isTest
    static void testHasDeletePermissionOnAccount() {
        Boolean result = AccTeamListController.hasDeletePermissionOnAccount();
        System.assertEquals(true, result); // Should reflect actual org permission
    }
}
