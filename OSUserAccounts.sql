SELECT COUNT(*)
FROM OSSYS_USER U
WHERE EMAIL NOT LIKE '%sk.bluecross.ca%'
  AND U.IS_ACTIVE = 1
  AND TENANT_ID = 20
  AND LAST_LOGIN < DATEADD(MONTH, -12, GETDATE())

-- current active internal users
SELECT COUNT(*)
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND U.IS_ACTIVE = 1
  AND TENANT_ID = 20
  AND LAST_LOGIN >= DATEADD(MONTH, -1, GETDATE());



SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND IS_ACTIVE = 1
  AND LAST_LOGIN > '2022'

SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND U.IS_ACTIVE = 1
  AND TENANT_ID <> 20


SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND U.IS_ACTIVE = 1
  AND TENANT_ID = 20
  AND U.ID NOT IN (SELECT USER_ID FROM OSSYS_USER_ROLE UNION SELECT USER_ID FROM OSSYS_GROUP_USER)


SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND U.ID IN (SELECT USER_ID FROM OSSYS_USER_ROLE)

SELECT U.ID, U.USERNAME, R.NAME AS ROLE
FROM OSSYS_USER U
         INNER JOIN OSSYS_USER_ROLE UR ON U.ID = UR.USER_ID
         INNER JOIN OSSYS_ROLE R ON UR.ROLE_ID = R.ID
WHERE UR.USER_ID = 44632


SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND TENANT_ID = 1
  AND U.IS_ACTIVE = 1


SELECT *
FROM OSSYS_USER U
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND IS_ACTIVE = 1
  AND TENANT_ID = 20
  AND U.ID NOT IN (SELECT DISTINCT USER_ID FROM OSSYS_GROUP_USER UNION SELECT DISTINCT USER_ID FROM OSSYS_USER_ROLE)

UPDATE OSSYS_USER
SET IS_ACTIVE = 0
WHERE EMAIL LIKE '%sk.bluecross.ca%'
  AND IS_ACTIVE = 1
  AND TENANT_ID = 20
  AND ID NOT IN (SELECT DISTINCT USER_ID FROM OSSYS_GROUP_USER UNION SELECT DISTINCT USER_ID FROM OSSYS_USER_ROLE)

SELECT *
FROM OSSYS_USER
WHERE TENANT_ID = 1
  AND IS_ACTIVE = 1

SELECT COUNT(*)
FROM OSSYS_USER
WHERE LEN(EXTERNAL_ID) > 10
  AND EMAIL NOT LIKE '%sk.bluecross.ca%'
  AND IS_ACTIVE = 1
