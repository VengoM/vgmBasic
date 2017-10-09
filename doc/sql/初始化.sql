prompt PL/SQL Developer import file
prompt Created on 2017年10月9日 by Administrator
set feedback off
set define off
prompt Creating SYS_ORGANIZATION...
create table SYS_ORGANIZATION
(
  id         NUMBER(20) not null,
  name       VARCHAR2(100),
  parent_id  NUMBER(20),
  parent_ids VARCHAR2(100),
  available  NUMBER(1)
)
;
alter table SYS_ORGANIZATION
  add constraint PK_SYS_ORGANIZATION primary key (ID);

prompt Creating SYS_RESOURCE...
create table SYS_RESOURCE
(
  id         NUMBER(20) not null,
  name       VARCHAR2(100),
  type       VARCHAR2(50),
  url        VARCHAR2(200),
  parent_id  NUMBER(20),
  parent_ids VARCHAR2(100),
  permission VARCHAR2(100),
  available  NUMBER(1),
  icon       VARCHAR2(50)
)
;
alter table SYS_RESOURCE
  add constraint PK_SYS_RESOURCE primary key (ID);

prompt Creating SYS_ROLE...
create table SYS_ROLE
(
  id           NUMBER(20) not null,
  role         VARCHAR2(100),
  description  VARCHAR2(100),
  resource_ids VARCHAR2(100),
  available    NUMBER(1)
)
;
alter table SYS_ROLE
  add constraint PK_SYS_ROLE primary key (ID);

prompt Creating SYS_USER...
create table SYS_USER
(
  id               NUMBER(20) not null,
  organization_ids VARCHAR2(100),
  username         VARCHAR2(100),
  password         VARCHAR2(100),
  salt             VARCHAR2(100),
  role_ids         VARCHAR2(100),
  locked           NUMBER(1)
)
;
alter table SYS_USER
  add constraint PK_SYS_USER primary key (ID);
alter table SYS_USER
  add constraint UK_SYS_USER unique (USERNAME);

prompt Loading SYS_ORGANIZATION...
insert into SYS_ORGANIZATION (id, name, parent_id, parent_ids, available)
values (1, '组织机构', 0, '0/', 1);
insert into SYS_ORGANIZATION (id, name, parent_id, parent_ids, available)
values (2, '分公司1', 1, '0/1/', 1);
insert into SYS_ORGANIZATION (id, name, parent_id, parent_ids, available)
values (3, '分公司2', 1, '0/1/', 1);
insert into SYS_ORGANIZATION (id, name, parent_id, parent_ids, available)
values (4, '分公司11', 2, '0/1/2/', 1);
insert into SYS_ORGANIZATION (id, name, parent_id, parent_ids, available)
values (5, '公司3', 1, '0/1/', 1);
commit;
prompt 5 records loaded
prompt Loading SYS_RESOURCE...
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (2, '系统管理', 'menu', null, 1, '0/1', 'system', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (3, '数据中心', 'menu', null, 1, '0/1', 'etl', 1, 'fa fa-exchange');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (4, '任务管理', 'menu', '/dc/task/list', 3, '0/13/', 'task:*', 1, 'fa fa-tasks');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (5, '测试菜单', 'menu', null, 1, '0/1/', 'test', 0, 'fa fa-check');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (6, '日志管理', 'menu', '/dc/taskLog/list', 3, '0/13/', 'taskLog:*', 1, 'fa fa-history');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (11, '组织机构管理', 'menu', '/organization/list', 2, '0/1/2/', 'organization:*', 1, 'fa fa-group');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (12, '组织机构新增', 'button', null, 11, '0/1/2/11/', 'organization:create', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (13, '组织机构修改', 'button', null, 11, '0/1/2/11/', 'organization:update', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (14, '组织机构删除', 'button', null, 11, '0/1/2/11/', 'organization:delete', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (15, '组织机构查看', 'button', null, 11, '0/1/2/11/', 'organization:view', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (21, '用户管理', 'menu', '/user/list', 2, '0/1/2/', 'user:*', 1, 'fa fa-user');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (22, '用户新增', 'button', null, 21, '0/1/2/21/', 'user:create', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (23, '用户修改', 'button', null, 21, '0/1/2/21/', 'user:update', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (24, '用户删除', 'button', null, 21, '0/1/2/21/', 'user:delete', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (25, '用户查看', 'button', null, 21, '0/1/2/21/', 'user:view', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (31, '资源管理', 'menu', '/resources/list', 2, '0/1/2/', 'resource:*', 1, 'fa fa-sitemap');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (32, '资源新增', 'button', null, 31, '0/1/2/31/', 'resource:create', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (33, '资源修改', 'button', null, 31, '0/1/2/31/', 'resource:update', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (34, '资源删除', 'button', null, 31, '0/1/2/31/', 'resource:delete', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (35, '资源查看', 'button', null, 31, '0/1/2/31/', 'resource:view', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (41, '角色管理', 'menu', '/role/list', 2, '0/1/2/', 'role:*', 1, 'fa fa-male');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (42, '角色新增', 'button', null, 41, '0/1/2/41/', 'role:create', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (43, '角色修改', 'button', null, 41, '0/1/2/41/', 'role:update', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (44, '角色删除', 'button', null, 41, '0/1/2/41/', 'role:delete', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (45, '角色查看', 'button', null, 41, '0/1/2/41/', 'role:view', 1, 'fa fa-desktop');
insert into SYS_RESOURCE (id, name, type, url, parent_id, parent_ids, permission, available, icon)
values (1, '资源', 'menu', null, 0, '0/', null, 1, 'fa fa-bars');
commit;
prompt 26 records loaded
prompt Loading SYS_ROLE...
insert into SYS_ROLE (id, role, description, resource_ids, available)
values (1, 'admin', '超级管理员', '102,10201', 1);
insert into SYS_ROLE (id, role, description, resource_ids, available)
values (2, 'test', '菜单测试员', '0,1', 1);
insert into SYS_ROLE (id, role, description, resource_ids, available)
values (3, 'etl', '数据管理员', '1,3,4,6,5', 0);
commit;
prompt 3 records loaded
prompt Loading SYS_USER...
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (41, null, 'newuser', '3959af567c37d55fbc3fa2576f6341e5', '6baa64fdf4d2cb7a60d84669fcb2a1e9', null, 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (1, null, 'admin', 'd3c59d25033dbf980d29554025c23a75', '8d78869f470951332959580424d4bf4f', '1', 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (23, null, 'admin1', '3f27554845031c8037274b4bed9446ec', 'bf3a712abdd3dba0ecb5306cb55e8f07', '1', 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (8, null, 'vengo', 'f76d3e91f558865be9e54017f883c31b123', 'c37245ae5e1d3a60a54a1b59b015b1eb', '1,2,3', 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (9, null, 'test', 'fb364540bed8c9fe860d52b7fb12b93a', '90b4a75294394cd5a9eff585a406ca45', '1', 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (10, null, 'test2', '28255dd1d8a1390b45d242a9d0f043c9', 'a19631ce88d199d3e641a8b035f4ef1b', '1', 0);
insert into SYS_USER (id, organization_ids, username, password, salt, role_ids, locked)
values (24, null, 'vengo1', '32f452e85826139a5d45411289fb6b77', 'b3a688e368de1b13815ff743cd9d456b', null, 0);
commit;
prompt 7 records loaded
set feedback on
set define on
prompt Done.
