SELECT *
FROM OSSYS_TENANT
WHERE ID = 20

SELECT *
FROM OSSYS_USER
WHERE id = 64

SELECT *
FROM OSSYS_USER_ROLE_T20
WHERE USER_ID = 4889

SELECT *
FROM OSSYS_ROLE
WHERE ID = 21 --162


SELECT *
FROM OSSYS_USER_ROLE
WHERE TENANT_ID = 20 --and ROLE_ID = 21
  AND ROLE_ID = 52

SELECT *
FROM OSSYS_ROLE
WHERE NAME = 'CustomerPortalMember'


UPDATE OSSYS_USER_ROLE
SET ROLE_ID = 52
WHERE ROLE_ID = 21
  AND TENANT_ID = 20

SELECT *
FROM OSSYS_ESPACE
WHERE ID = 162

SELECT *
FROM OSSYS_ESPACE
WHERE NAME LIKE '%MemberPortal_BLL_CS%'