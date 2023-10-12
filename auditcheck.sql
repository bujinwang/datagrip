select * from sys.server_audits

select * from sys.database_audit_specifications;

select name, is_cdc_enabled from sys.databases where IS_CDC_ENABLED = 1;