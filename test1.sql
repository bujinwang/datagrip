SELECT sum({TimeCard}.[TotalAmount]), sum({TimeCard}.[Duration])
FROM {TimeCard}
    INNER JOIN {Project} ON {TimeCard}.[ProjectId] = {Project}.[Id]
    INNER JOIN {Client} ON {Project}.[ClientId] = {Client}.[Id]
    INNER JOIN {FirmUser} ON {TimeCard}.[FirmUserId] = {FirmUser}.[Id]
    INNER JOIN {Firm} ON {FirmUser}.[FirmId] = {Firm}.[Id]
    INNER JOIN {User} ON {FirmUser}.[UserId] = {User}.[Id]
    INNER JOIN {TimeCardApproval} ON {TimeCard}.[Id] = {TimeCardApproval}.[TimeCardId] AND {TimeCardApproval}.[Approver] = @ApproverUserId AND {TimeCardApproval}.[ApprovalStatus] = @ApprovalStatusRejected
    INNER JOIN (
        SELECT TC1.[Id] TimeCardId, Max(TCA1.[Id]) TimeCardApprovalId
        FROM {TimeCard} TC1 INNER JOIN {TimeCardApproval} TCA1 ON TC1.[Id] = TCA1.[TimeCardId] AND TC1.[TimeCardStatusId] = @TimeCardStatusRejected
        GROUP BY TC1.[Id]
    ) RejectedTimeCards ON {TimeCard}.[Id] = RejectedTimeCards.TimeCardId AND {TimeCardApproval}.[Id] = RejectedTimeCards.TimeCardApprovalId
    LEFT JOIN {WorkSolvTask} ON {TimeCard}.[WorkSolvTaskId] = {WorkSolvTask}.[Id]
    LEFT JOIN {WorkSolvPhase} ON {WorkSolvTask}.[WorkSolvPhaseId] = {WorkSolvPhase}.[Id]
    LEFT JOIN {TaskCode} ON {TimeCard}.[TaskCodeId] = {TaskCode}.[Id]
    LEFT JOIN {SubTaskCode} ON {TimeCard}.[SubTaskCodeId] = {SubTaskCode}.[Id]
WHERE {TimeCard}.[TimeCardStatusId] = @TimeCardStatusRejected
    @AND_CLAUSE
