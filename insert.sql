------------------------------------------------------------------------------
-- Clear and load SymmetricDS Configuration
------------------------------------------------------------------------------

DELETE FROM sym_file_trigger_router;
DELETE FROM sym_file_trigger;
DELETE FROM sym_trigger_router;
DELETE FROM sym_trigger;
DELETE FROM sym_channel;
DELETE FROM sym_router;
DELETE FROM sym_node_group_link;
DELETE FROM sym_node_group;
DELETE FROM sym_node_host;
DELETE FROM sym_node_identity;
DELETE FROM sym_node_security;
DELETE FROM sym_node;

------------------------------------------------------------------------------
-- Node Groups
------------------------------------------------------------------------------

INSERT INTO sym_node_group (node_group_id) VALUES ('corp');
INSERT INTO sym_node_group (node_group_id) VALUES ('store');

------------------------------------------------------------------------------
-- Node Group Links
------------------------------------------------------------------------------

-- Corp sends changes to Store when Store pulls from Corp
INSERT INTO sym_node_group_link (source_node_group_id,target_node_group_id,data_event_action) VALUES ('corp','store','W');

-- Store sends changes to Corp when Store pushes to Corp
INSERT INTO sym_node_group_link (source_node_group_id,target_node_group_id,data_event_action) VALUES ('store','corp','P');

------------------------------------------------------------------------------
-- Routers
------------------------------------------------------------------------------

-- Default router sends all data from corp to store 
INSERT INTO sym_router (router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time) VALUES
('corp_2_store','corp','store','default',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

-- Default router sends all data from store to corp
INSERT INTO sym_router (router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time) VALUES
('store_2_corp','store','corp','default',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

------------------------------------------------------------------------------
-- Channels
------------------------------------------------------------------------------

INSERT INTO sym_channel (channel_id,file_sync_flag,create_time,last_update_time) VALUES
('all_tables',0,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('all_files',1,CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);


------------------------------------------------------------------------------
-- Triggers
------------------------------------------------------------------------------

INSERT INTO sym_trigger (trigger_id,channel_id,reload_channel_id,source_table_name,create_time,last_update_time) VALUES
('all_tables','all_tables','all_tables','*',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

------------------------------------------------------------------------------
-- Trigger Routers
------------------------------------------------------------------------------

INSERT INTO sym_trigger_router (trigger_id,router_id,create_time,last_update_time) VALUES
('all_tables','corp_2_store',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('all_tables','store_2_corp',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);


------------------------------------------------------------------------------
-- File Triggers
------------------------------------------------------------------------------

INSERT INTO sym_file_trigger (trigger_id,channel_id,reload_channel_id,base_dir,create_time,last_update_time) VALUES
('all_files','all_files','all_files','/opt/symmetric-app',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);

------------------------------------------------------------------------------
-- File Trigger Routers
------------------------------------------------------------------------------

INSERT INTO sym_file_trigger_router (trigger_id,router_id,create_time,last_update_time) VALUES
('all_files','corp_2_store',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP),
('all_files','store_2_corp',CURRENT_TIMESTAMP,CURRENT_TIMESTAMP);
