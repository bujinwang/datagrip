CREATE TRIGGER [OSTRG_EI__OSSYS_USER]
    ON [dbo].[ossys_User]
    AFTER INSERT, UPDATE AS
BEGIN
    DECLARE @ISUPDATE BIT; SET @ISUPDATE = 1; IF (SELECT COUNT(1) FROM DELETED) = 0 SET @ISUPDATE = 0;
    INSERT INTO OSSYS_BPM_EVENT_QUEUE(ESPACE_ID, TENANT_ID, ACTIVITY_ID, PROCESS_DEF_ID, DATA_ID, ENQUEUE_TIME,
                                      ERROR_COUNT, NEXT_RUN) (SELECT [_ESPACE_ID],
                                                                     COALESCE([_TENANT_ID], INSERTED.[TENANT_ID]),
                                                                     [_ACTIVITY_ID],
                                                                     [_PROCESS_DEF_ID],
                                                                     CONVERT(VARCHAR(11), INSERTED.[ID]),
                                                                     GETDATE(),
                                                                     0,
                                                                     GETDATE()
                                                              FROM [OSEVT_USER] EVT,
                                                                   INSERTED
                                                              WHERE EVT.[_IS_UPDATE] = @ISUPDATE
                                                                AND EVT.[_IS_LIGHT] = 0
                                                                AND (NULLIF(EVT.[TENANT_ID], 0) IS NULL OR
                                                                     EVT.[TENANT_ID] =
                                                                     COALESCE(INSERTED.[TENANT_ID], 0))
                                                                AND (EVT.[ID] IS NULL OR EVT.[ID] = INSERTED.[ID]));
    INSERT INTO OSSYS_BPM_EVENT(ESPACE_ID, TENANT_ID, ACTIVITY_ID, PROCESS_DEF_ID, ENTITY_RECORD_ID, ENQUEUE_TIME,
                                ERROR_COUNT, NEXT_RUN) (SELECT [_ESPACE_ID],
                                                               COALESCE([_TENANT_ID], INSERTED.[TENANT_ID]),
                                                               [_ACTIVITY_ID],
                                                               [_PROCESS_DEF_ID],
                                                               CONVERT(VARCHAR(11), INSERTED.[ID]),
                                                               GETDATE(),
                                                               0,
                                                               GETDATE()
                                                        FROM [OSEVT_USER] EVT,
                                                             INSERTED
                                                        WHERE EVT.[_IS_UPDATE] = @ISUPDATE
                                                          AND EVT.[_IS_LIGHT] = 1
                                                          AND (NULLIF(EVT.[TENANT_ID], 0) IS NULL OR
                                                               EVT.[TENANT_ID] = COALESCE(INSERTED.[TENANT_ID], 0))
                                                          AND (EVT.[ID] IS NULL OR EVT.[ID] = INSERTED.[ID]));;
END
GO

