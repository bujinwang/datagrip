DECLARE @BATCHSIZE INT = 100; -- Number of rows per batch
DECLARE @ROWSINSERTED INT = 0;

WHILE 1 = 1
    BEGIN
        INSERT INTO OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT WITH (TABLOCKX) (ID, CONTENT)
        SELECT TOP (@BATCHSIZE) C.ID, C.CONTENT
        FROM OSDATA.DBO.OSUSR_GT6_FILECONTENT C
                 INNER JOIN OSDATA.DBO.OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
        WHERE S.CREATEDTIMESTAMP <= DATEADD(YEAR, -1, GETDATE())
          AND S.CREATEDTIMESTAMP >= DATEADD(YEAR, -2, GETDATE())
          AND NOT EXISTS(SELECT 1
                         FROM OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT DT
                         WHERE DT.ID = C.ID)

        SET @ROWSINSERTED = @@ROWCOUNT;
        IF @ROWSINSERTED < @BATCHSIZE
            BREAK;
    END;


SELECT COUNT(*)
FROM OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT

SET IDENTITY_INSERT OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT ON
-- two years old
INSERT INTO OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT WITH (TABLOCKX) (ID, CONTENT)
SELECT C.ID, C.CONTENT
FROM OSUSR_GT6_FILECONTENT C
         INNER JOIN OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
WHERE S.CREATEDTIMESTAMP <= DATEADD(YEAR, -2, GETDATE())

-- one year old
INSERT INTO OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT(ID, CONTENT)
SELECT C.ID, C.CONTENT
FROM OSUSR_GT6_FILECONTENT C
         INNER JOIN OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
WHERE S.CREATEDTIMESTAMP <= DATEADD(YEAR, -1, GETDATE())
  AND S.CREATEDTIMESTAMP >= DATEADD(YEAR, -2, GETDATE())

SET IDENTITY_INSERT OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT OFF


SELECT COUNT(*)
FROM OSUSR_GT6_FILECONTENT C
         INNER JOIN OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
WHERE S.CREATEDTIMESTAMP <= DATEADD(YEAR, -2, GETDATE())

SELECT SUM(DATALENGTH(CONTENT))
FROM OSUSR_GT6_FILECONTENT C
         INNER JOIN OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
WHERE S.CREATEDTIMESTAMP <= DATEADD(YEAR, -1, GETDATE())

SELECT COUNT(c.id), SUM(DATALENGTH(C.CONTENT))/1000/1000/1000
FROM OSDATAARCHIVE.DBO.OSUSR_GT6_FILECONTENT c


SELECT COUNT(*), SUM(DATALENGTH(C.CONTENT))
FROM OSUSR_GT6_FILECONTENT C
         INNER JOIN OSUSR_GT6_FILESTORE S ON S.FILECONTENTID = C.ID
WHERE S.CREATEDTIMESTAMP >= '2023-01-01'