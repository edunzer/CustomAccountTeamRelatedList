public without sharing class AccTeamListController {

    @AuraEnabled(cacheable=true)
    public static List<AccountTeamMember> getTeamMembers(Id accountId) {
        try {
            if (accountId == null) {
                throw new AuraHandledException('Account Id must not be null.');
            }
            return [
                SELECT Id, UserId, User.Name, TeamMemberRole
                FROM AccountTeamMember
                WHERE AccountId = :accountId
                ORDER BY User.Name ASC
            ];
        } catch (Exception ex) {
            throw new AuraHandledException('Error fetching team members: ' + ex.getMessage());
        }
    }

    @AuraEnabled
    public static void addTeamMember(Id accountId, Id userId, String teamMemberRole) {
        try {
            if (accountId == null || userId == null || String.isBlank(teamMemberRole)) {
                throw new AuraHandledException('All parameters (accountId, userId, teamMemberRole) are required.');
            }

            AccountTeamMember newMember = new AccountTeamMember(
                AccountId = accountId,
                UserId = userId,
                TeamMemberRole = teamMemberRole,
                AccountAccessLevel = 'Read',
                ContactAccessLevel = 'Read',
                CaseAccessLevel = 'None',
                OpportunityAccessLevel = 'None'
            );
            insert newMember;
        } catch (DmlException dmlEx) {
            throw new AuraHandledException('Failed to add team member: ' + dmlEx.getMessage());
        } catch (Exception ex) {
            throw new AuraHandledException('Unexpected error while adding team member: ' + ex.getMessage());
        }
    }

    @AuraEnabled
    public static void deleteTeamMember(Id teamMemberId) {
        try {
            if (teamMemberId == null) {
                throw new AuraHandledException('Team Member Id must not be null.');
            }

            AccountTeamMember memberToDelete = [
                SELECT Id FROM AccountTeamMember WHERE Id = :teamMemberId
                LIMIT 1
            ];
            delete memberToDelete;
        } catch (QueryException qEx) {
            throw new AuraHandledException('Team member not found: ' + qEx.getMessage());
        } catch (DmlException dmlEx) {
            throw new AuraHandledException('Failed to delete team member: ' + dmlEx.getMessage());
        } catch (Exception ex) {
            throw new AuraHandledException('Unexpected error while deleting team member: ' + ex.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Boolean hasCreatePermissionOnAccount() {
        try {
            return Schema.sObjectType.Account.isCreateable();
        } catch (Exception ex) {
            throw new AuraHandledException('Error checking Create permissions: ' + ex.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static Boolean hasDeletePermissionOnAccount() {
        try {
            return Schema.sObjectType.Account.isDeletable();
        } catch (Exception ex) {
            throw new AuraHandledException('Error checking Delete permissions: ' + ex.getMessage());
        }
    }

}
