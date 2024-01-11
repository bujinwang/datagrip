DECLARE @SUMDURATION FLOAT, @SUMAMOUNT FLOAT, @COUNT INT, @NEWRATE FLOAT, @NEWAMOUNT FLOAT;

SELECT @COUNT = COUNT(OSUSR_PIF_INVOICETIMECARD_T2021.[Id]),
       @SUMDURATION = SUM(OSUSR_PIF_INVOICETIMECARD_T2021.[Duration]),
       @SUMAMOUNT = SUM(OSUSR_PIF_INVOICETIMECARD_T2021.[TotalAmount])
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
WHERE DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[InvoiceProjectId] = 16721982
  AND DBO.OSUSR_PIF_TASKCODE_T2021.[isSummarized] = 1
  AND DBO.OSUSR_PIF_TIMECARD_T2021.[TimeCardStatusId] <> 1
GROUP BY DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
         DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
         DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId];

SELECT @COUNT, @SUMDURATION, @SUMAMOUNT;

-- do the update 7 with temp  table etc.

-- Candidate #1
SELECT TC.TIMECARDSTATUSID,
       ITC.ISDELETED,
       itc.rate = IIF(ITC.Duration = 0, 0, @SUMAMOUNT / @SUMDURATION)
                                                                                         AS NEWRATE,
       @SUMDURATION                                                                      AS NEWDURATION,
       IIF(@SUMAMOUNT - FLOOR(@SUMAMOUNT) < 0.5, FLOOR(@SUMAMOUNT), CEILING(@SUMAMOUNT)) AS NEWTOTALAMOUHT

--UPDATE  itc.rated = Starbucks20@@, itc.rate = IIF ... , totalamount = case when ,
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 AS ITC
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 AS TCD
                    ON ITC.[TaskCodeId] = TCD.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 AS TC
                    ON ITC.[TimeCardId] = TC.[Id]
         INNER JOIN
     (SELECT ITC.[TaskCodeId],
             ITC.[SubTaskCodeId],
             ITC.[FirmUserId],
             ITC.[Date],
             TC.[WorkSolvTaskId]
      FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 AS ITC
               INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 AS TCD
                          ON ITC.[TaskCodeId] = TCD.[Id]
               INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 AS TC
                          ON ITC.[TimeCardId] = TC.[Id]
      WHERE ITC.[InvoiceProjectId] = 16721982
        AND TCD.[isSummarized] = 1
        AND TC.[TimeCardStatusId] <> 1
      GROUP BY ITC.[TaskCodeId], ITC.[SubTaskCodeId],
               ITC.[FirmUserId], ITC.[Date], TC.[WorkSolvTaskId]
      HAVING COUNT(ITC.[Id]) > 1) AS S
     ON
                 ITC.[Date] = S.[Date] AND
                 (ITC.[TaskCodeId] = S.[TaskCodeId] OR S.[TaskCodeId] IS NULL) AND
             --(itc.[SubTaskCodeId] = S.[SubTaskCodeId] OR
             --S.[SubTaskCodeId] = NULL) AND
                 ITC.[FirmUserId] = S.[FirmUserId]
ORDER BY ITC.[date], ITC.[Id];


-- Update candidate #2:
SELECT DBO.OSUSR_PIF_INVOICETIMECARD_T2021.*, DBO.OSUSR_PIF_TIMECARD_T2021.TIMECARDSTATUSID
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
         INNER JOIN
     (SELECT DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId],
             DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
             DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId],
             DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
             DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId]
      FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021
               INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021
                          ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
               INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021
                          ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
      WHERE DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[InvoiceProjectId] = 16721982
        AND DBO.OSUSR_PIF_TASKCODE_T2021.[isSummarized] = 1
        AND DBO.OSUSR_PIF_TIMECARD_T2021.[TimeCardStatusId] <> 1
      GROUP BY DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
               DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
               DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId]
      HAVING COUNT(OSUSR_PIF_INVOICETIMECARD_T2021.[Id]) > 1) AS S
     ON
                 DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date] = S.[Date] AND
                 (DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = S.[TaskCodeId] OR S.[TaskCodeId] IS NULL) AND
             --(DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId] = S.[SubTaskCodeId] OR
             --S.[SubTaskCodeId] = NULL) AND
                 DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId] = S.[FirmUserId]
ORDER BY OSUSR_PIF_INVOICETIMECARD_T2021.[date], OSUSR_PIF_INVOICETIMECARD_T2021.[Id]


SELECT DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId],
       DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
       DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId],
       DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
       DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId],
       COUNT(DBO.OSUSR_PIF_INVOICETIMECARD_T2021.ID)
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
WHERE DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[InvoiceProjectId] = 16721982
  AND DBO.OSUSR_PIF_TASKCODE_T2021.[isSummarized] = 1
  AND DBO.OSUSR_PIF_TIMECARD_T2021.[TimeCardStatusId] <> 1
GROUP BY DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
         DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
         DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId]
HAVING COUNT(OSUSR_PIF_INVOICETIMECARD_T2021.[Id]) > 1


DECLARE @SUMDURATION FLOAT, @SUMAMOUNT FLOAT;

SELECT SUM(ITC.[Duration]), SUM(ITC.[TotalAmount])
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 ITC
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 TCD ON ITC.[TaskCodeId] = TCD.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 TC ON ITC.[TimeCardId] = TC.[Id]
WHERE ITC.[InvoiceProjectId] = 16721982
  AND TCD.[isSummarized] = 1
  AND TC.[TimeCardStatusId] <> 1
GROUP BY ITC.[TaskCodeId], ITC.[SubTaskCodeId], ITC.[FirmUserId], ITC.[Date], TC.[WorkSolvTaskId]
HAVING COUNT(ITC.[Id]) > 1


SELECT @SUMDURATION, @SUMAMOUNT;



SELECT ITC.*, TC.TIMECARDSTATUSID
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 ITC
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 TCD ON ITC.[TaskCodeId] = TCD.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 TC ON ITC.[TimeCardId] = TC.[Id]
WHERE ITC.[InvoiceProjectId] = 16721982
  AND TCD.[isSummarized] = 1
  AND TC.[TimeCardStatusId] <> 1
  AND EXISTS (SELECT 1
              FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 ITC2
              WHERE ITC2.[InvoiceProjectId] = ITC.[InvoiceProjectId]
                AND ITC2.[TaskCodeId] = ITC.[TaskCodeId]
                AND ITC2.[SubTaskCodeId] = ITC.[SubTaskCodeId]
                AND ITC2.[FirmUserId] = ITC.[FirmUserId]
                AND ITC2.[Date] = ITC.[Date]
                AND ITC2.[Id] <> ITC.[Id])
ORDER BY ITC.[date], ITC.[Id];


SELECT DBO.OSUSR_PIF_INVOICETIMECARD_T2021.*, DBO.OSUSR_PIF_TIMECARD_T2021.WORKSOLVTASKID
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
WHERE DBO.OSUSR_PIF_INVOICETIMECARD_T2021.TASKCODEID = 321731
  AND DBO.OSUSR_PIF_INVOICETIMECARD_T2021.FIRMUSERID = 51102
  AND DBO.OSUSR_PIF_INVOICETIMECARD_T2021.DURATION != 0
GROUP BY DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId],
         DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[FirmUserId], DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[Date],
         DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId]
HAVING COUNT(OSUSR_PIF_INVOICETIMECARD_T2021.[Id]) > 1


SELECT DBO.OSUSR_PIF_INVOICETIMECARD.*
FROM DBO.OSUSR_PIF_INVOICETIMECARD
         INNER JOIN DBO.OSUSR_PIF_TASKCODE
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TaskCodeId] = DBO.OSUSR_PIF_TASKCODE_T2021.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD
                    ON DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[TimeCardId] = DBO.OSUSR_PIF_TIMECARD_T2021.[Id]
WHERE DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[InvoiceProjectId] = 12343
--   AND DBO.OSUSR_PIF_TaskCode_T2021.[isSummarized] = 1
--   AND DBO.OSUSR_PIF_InvoiceTimeCard_T2021.[TaskCodeId] = @TaskCodeId
--   AND DBO.OSUSR_PIF_InvoiceTimeCard_T2021.[Date] = @Date
--   AND DBO.OSUSR_PIF_InvoiceTimeCard_T2021.[FirmUserId] = @FirmUserId
  AND ((@SUBTASKCODEID = 0
    AND DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId] IS NULL)
    OR @SUBTASKCODEID = DBO.OSUSR_PIF_INVOICETIMECARD_T2021.[SubTaskCodeId])
  AND ((@WORKSOLVTASKID = 0
    AND DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId] IS NULL)
    OR @WORKSOLVTASKID = DBO.OSUSR_PIF_TIMECARD_T2021.[WorkSolvTaskId])
--   AND DBO.OSUSR_PIF_TimeCard_T2021.[TimeCardStatusId] <> @TimeCardStatus_WrittenOff
-- ORDER BY DBO.OSUSR_PIF_InvoiceTimeCard_T2021.[Date], DBO.OSUSR_PIF_InvoiceTimeCard_T2021.[Id] ASC


SELECT DBO.OSUSR_PIF_INVOICETIMECARD SET ISDELETED = FALSE, TOTALAMOUNT = rate*, CASE


SELECT *
FROM DBO.OSUSR_PIF_INVOICETIMECARD
WHERE WORKSOLVTASKID IS NULL

DECLARE @TOTALTIME FLOAT
SELECT @TOTALTIME = SUM()
FROM DBO.OSUSR_PIF_INVOICETIMECARD
WHERE ID < 100


DECLARE @NUMBER FLOAT = 3.5;

SELECT CASE
           WHEN @NUMBER - FLOOR(@NUMBER) < 0.5
               THEN FLOOR(@NUMBER)
           ELSE
               CEILING(@NUMBER)
           END AS ROUNDEDVALUE;


DECLARE @TOTALSUM FLOAT;

SELECT @TOTALSUM = SUM(ID)
FROM OSSYS_USER;

-- Display the result
PRINT @TOTALSUM;

SELECT *
FROM DBO.OSUSR_PIF_TIMECARDSTATUS


SELECT ITC.*, TC.TIMECARDSTATUSID
FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 AS ITC
         INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 AS TCD
                    ON ITC.[TaskCodeId] = TCD.[Id]
         INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 AS TC
                    ON ITC.[TimeCardId] = TC.[Id]
         INNER JOIN
     (SELECT ITC.[TaskCodeId],
             ITC.[SubTaskCodeId],
             ITC.[FirmUserId],
             ITC.[Date],
             TC.[WorkSolvTaskId]
      FROM DBO.OSUSR_PIF_INVOICETIMECARD_T2021 AS ITC
               INNER JOIN DBO.OSUSR_PIF_TASKCODE_T2021 AS TCD
                          ON ITC.[TaskCodeId] = TCD.[Id]
               INNER JOIN DBO.OSUSR_PIF_TIMECARD_T2021 AS TC
                          ON ITC.[TimeCardId] = TC.[Id]
      WHERE ITC.[InvoiceProjectId] = 16721982
        AND TCD.[isSummarized] = 1
        AND TC.[TimeCardStatusId] <> 1
      GROUP BY ITC.[TaskCodeId], ITC.[SubTaskCodeId],
               ITC.[FirmUserId], ITC.[Date], TC.[WorkSolvTaskId]
      HAVING COUNT(ITC.[Id]) > 1) AS S
     ON
                 ITC.[Date] = S.[Date] AND
                 (ITC.[TaskCodeId] = S.[TaskCodeId] OR S.[TaskCodeId] IS NULL) AND
             --(itc.[SubTaskCodeId] = S.[SubTaskCodeId] OR
             --S.[SubTaskCodeId] = NULL) AND
                 ITC.[FirmUserId] = S.[FirmUserId]
ORDER BY ITC.[date], ITC.[Id];