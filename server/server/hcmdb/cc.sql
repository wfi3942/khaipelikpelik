/*
Navicat MySQL Data Transfer

Source Server         : 10.40.204.103
Source Server Version : 50724
Source Host           : 10.40.204.103:3306
Source Database       : test

Target Server Type    : MYSQL
Target Server Version : 50724
File Encoding         : 65001

Date: 2021-10-03 18:52:00
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for alarm
-- ----------------------------
DROP TABLE IF EXISTS `alarm`;
CREATE TABLE `alarm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `level` int(11) NOT NULL,
  `way` varchar(100) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group` (`group`,`level`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm
-- ----------------------------

-- ----------------------------
-- Table structure for alarm_user
-- ----------------------------
DROP TABLE IF EXISTS `alarm_user`;
CREATE TABLE `alarm_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alarm_id` int(11) NOT NULL,
  `myuser_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `alarm_id` (`alarm_id`,`myuser_id`),
  KEY `alarm_user_myuser_id_7dbec46c3dcec87e_fk_myUser_id` (`myuser_id`),
  CONSTRAINT `alarm_user_alarm_id_68d8dc7d4ee2d73b_fk_alarm_id` FOREIGN KEY (`alarm_id`) REFERENCES `alarm` (`id`),
  CONSTRAINT `alarm_user_myuser_id_7dbec46c3dcec87e_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alarm_user
-- ----------------------------

-- ----------------------------
-- Table structure for app
-- ----------------------------
DROP TABLE IF EXISTS `app`;
CREATE TABLE `app` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `another_name` varchar(30) DEFAULT NULL,
  `architecture` varchar(255) DEFAULT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_name_381dd79f05628d9b_uniq` (`name`,`another_name`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app
-- ----------------------------

-- ----------------------------
-- Table structure for approle
-- ----------------------------
DROP TABLE IF EXISTS `approle`;
CREATE TABLE `approle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `appRole_name_3cf460a6e8d67331_uniq` (`name`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of approle
-- ----------------------------

-- ----------------------------
-- Table structure for app_roles
-- ----------------------------
DROP TABLE IF EXISTS `app_roles`;
CREATE TABLE `app_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appid_id` int(11) NOT NULL,
  `roleid_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `app_roles_appid_id_2ef2ba5ad157f193_fk_app_id` (`appid_id`),
  KEY `app_roles_f60990d5` (`roleid_id`),
  CONSTRAINT `app_roles_appid_id_2ef2ba5ad157f193_fk_app_id` FOREIGN KEY (`appid_id`) REFERENCES `app` (`id`),
  CONSTRAINT `app_roles_roleid_id_714a1517f56d6b05_fk_appRole_id` FOREIGN KEY (`roleid_id`) REFERENCES `approle` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_roles
-- ----------------------------

-- ----------------------------
-- Table structure for asset
-- ----------------------------
DROP TABLE IF EXISTS `asset`;
CREATE TABLE `asset` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `server_type` varchar(30) NOT NULL,
  `ip` varchar(32) NOT NULL,
  `other_ip` varchar(255) DEFAULT NULL,
  `port` int(11) NOT NULL,
  `is_monitoring` tinyint(1) NOT NULL,
  `is_backup` tinyint(1) NOT NULL,
  `editor` longtext,
  `availabity` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_ip_59850975c1d2f626_uniq` (`ip`,`availabity`),
  KEY `asset_0e939a4f` (`group_id`),
  CONSTRAINT `asset_group_id_ad53d32c6eae999_fk_dataCenter_id` FOREIGN KEY (`group_id`) REFERENCES `datacenter` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asset
-- ----------------------------

-- ----------------------------
-- Table structure for assets_car
-- ----------------------------
DROP TABLE IF EXISTS `assets_car`;
CREATE TABLE `assets_car` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  `zaoban` varchar(50) NOT NULL,
  `zhongban` varchar(50) NOT NULL,
  `wanban` varchar(50) NOT NULL,
  `zonglicheng` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;



-- ----------------------------
-- Table structure for assets_carlist
-- ----------------------------
DROP TABLE IF EXISTS `assets_carlist`;
CREATE TABLE `assets_carlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` varchar(50) NOT NULL,
  `zaoban` varchar(50) NOT NULL,
  `zhongban` varchar(50) NOT NULL,
  `wanban` varchar(50) NOT NULL,
  `zonglicheng` varchar(50) NOT NULL,
  `number_id` int(11),
  PRIMARY KEY (`id`),
  KEY `assets_carlist_800e24b0` (`number_id`),
  CONSTRAINT `assets_carlist_number_id_535664400dfaaa43_fk_assets_carmodel_id` FOREIGN KEY (`number_id`) REFERENCES `assets_carmodel` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for assets_carmodel
-- ----------------------------
DROP TABLE IF EXISTS `assets_carmodel`;
CREATE TABLE `assets_carmodel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(50) NOT NULL,
  `mileage` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;


-- ----------------------------
-- Table structure for asset_app_name
-- ----------------------------
DROP TABLE IF EXISTS `asset_app_name`;
CREATE TABLE `asset_app_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `app_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`,`app_id`),
  KEY `asset_app_name_app_id_5d6016cd94791acc_fk_app_id` (`app_id`),
  CONSTRAINT `asset_app_name_app_id_5d6016cd94791acc_fk_app_id` FOREIGN KEY (`app_id`) REFERENCES `app` (`id`),
  CONSTRAINT `asset_app_name_asset_id_7fbc87fb34a7efc3_fk_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asset_app_name
-- ----------------------------

-- ----------------------------
-- Table structure for asset_config
-- ----------------------------
DROP TABLE IF EXISTS `asset_config`;
CREATE TABLE `asset_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `config_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`,`config_id`),
  KEY `asset_config_config_id_38c0287e5761ae9b_fk_config_id` (`config_id`),
  CONSTRAINT `asset_config_asset_id_3b5ca89238f5922e_fk_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`),
  CONSTRAINT `asset_config_config_id_38c0287e5761ae9b_fk_config_id` FOREIGN KEY (`config_id`) REFERENCES `config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asset_config
-- ----------------------------

-- ----------------------------
-- Table structure for asset_role_name
-- ----------------------------
DROP TABLE IF EXISTS `asset_role_name`;
CREATE TABLE `asset_role_name` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asset_id` int(11) NOT NULL,
  `app_roles_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `asset_id` (`asset_id`,`app_roles_id`),
  KEY `asset_role_name_app_roles_id_3dc0f56d51750590_fk_app_roles_id` (`app_roles_id`),
  CONSTRAINT `asset_role_name_app_roles_id_3dc0f56d51750590_fk_app_roles_id` FOREIGN KEY (`app_roles_id`) REFERENCES `app_roles` (`id`),
  CONSTRAINT `asset_role_name_asset_id_38ef48093aeffeff_fk_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of asset_role_name
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `auth_group__permission_id_1f49ccbbdc69d2fc_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permission_group_id_689710a9a73b7457_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  CONSTRAINT `auth__content_type_id_508cf46651277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');
INSERT INTO `auth_permission` VALUES ('16', 'Can add department', '6', 'add_department');
INSERT INTO `auth_permission` VALUES ('17', 'Can change department', '6', 'change_department');
INSERT INTO `auth_permission` VALUES ('18', 'Can delete department', '6', 'delete_department');
INSERT INTO `auth_permission` VALUES ('19', 'Can add my user', '7', 'add_myuser');
INSERT INTO `auth_permission` VALUES ('20', 'Can change my user', '7', 'change_myuser');
INSERT INTO `auth_permission` VALUES ('21', 'Can delete my user', '7', 'delete_myuser');
INSERT INTO `auth_permission` VALUES ('22', 'Can add data center', '8', 'add_datacenter');
INSERT INTO `auth_permission` VALUES ('23', 'Can change data center', '8', 'change_datacenter');
INSERT INTO `auth_permission` VALUES ('24', 'Can delete data center', '8', 'delete_datacenter');
INSERT INTO `auth_permission` VALUES ('25', 'Can add asset', '9', 'add_asset');
INSERT INTO `auth_permission` VALUES ('26', 'Can change asset', '9', 'change_asset');
INSERT INTO `auth_permission` VALUES ('27', 'Can delete asset', '9', 'delete_asset');
INSERT INTO `auth_permission` VALUES ('28', 'Can add car model', '10', 'add_carmodel');
INSERT INTO `auth_permission` VALUES ('29', 'Can change car model', '10', 'change_carmodel');
INSERT INTO `auth_permission` VALUES ('30', 'Can delete car model', '10', 'delete_carmodel');
INSERT INTO `auth_permission` VALUES ('31', 'Can add car list', '11', 'add_carlist');
INSERT INTO `auth_permission` VALUES ('32', 'Can change car list', '11', 'change_carlist');
INSERT INTO `auth_permission` VALUES ('33', 'Can delete car list', '11', 'delete_carlist');
INSERT INTO `auth_permission` VALUES ('34', 'Can add car', '12', 'add_car');
INSERT INTO `auth_permission` VALUES ('35', 'Can change car', '12', 'change_car');
INSERT INTO `auth_permission` VALUES ('36', 'Can delete car', '12', 'delete_car');
INSERT INTO `auth_permission` VALUES ('37', 'Can add config', '13', 'add_config');
INSERT INTO `auth_permission` VALUES ('38', 'Can change config', '13', 'change_config');
INSERT INTO `auth_permission` VALUES ('39', 'Can delete config', '13', 'delete_config');
INSERT INTO `auth_permission` VALUES ('40', 'Can add app role', '14', 'add_approle');
INSERT INTO `auth_permission` VALUES ('41', 'Can change app role', '14', 'change_approle');
INSERT INTO `auth_permission` VALUES ('42', 'Can delete app role', '14', 'delete_approle');
INSERT INTO `auth_permission` VALUES ('43', 'Can add app', '15', 'add_app');
INSERT INTO `auth_permission` VALUES ('44', 'Can change app', '15', 'change_app');
INSERT INTO `auth_permission` VALUES ('45', 'Can delete app', '15', 'delete_app');
INSERT INTO `auth_permission` VALUES ('46', 'Can add app_roles', '16', 'add_app_roles');
INSERT INTO `auth_permission` VALUES ('47', 'Can change app_roles', '16', 'change_app_roles');
INSERT INTO `auth_permission` VALUES ('48', 'Can delete app_roles', '16', 'delete_app_roles');
INSERT INTO `auth_permission` VALUES ('49', 'Can add domain name', '17', 'add_domainname');
INSERT INTO `auth_permission` VALUES ('50', 'Can change domain name', '17', 'change_domainname');
INSERT INTO `auth_permission` VALUES ('51', 'Can delete domain name', '17', 'delete_domainname');
INSERT INTO `auth_permission` VALUES ('52', 'Can add alarm', '18', 'add_alarm');
INSERT INTO `auth_permission` VALUES ('53', 'Can change alarm', '18', 'change_alarm');
INSERT INTO `auth_permission` VALUES ('54', 'Can delete alarm', '18', 'delete_alarm');
INSERT INTO `auth_permission` VALUES ('55', 'Can add api access', '19', 'add_apiaccess');
INSERT INTO `auth_permission` VALUES ('56', 'Can change api access', '19', 'change_apiaccess');
INSERT INTO `auth_permission` VALUES ('57', 'Can delete api access', '19', 'delete_apiaccess');
INSERT INTO `auth_permission` VALUES ('58', 'Can add api key', '20', 'add_apikey');
INSERT INTO `auth_permission` VALUES ('59', 'Can change api key', '20', 'change_apikey');
INSERT INTO `auth_permission` VALUES ('60', 'Can delete api key', '20', 'delete_apikey');
INSERT INTO `auth_permission` VALUES ('61', 'Can add menu', '21', 'add_menu');
INSERT INTO `auth_permission` VALUES ('62', 'Can change menu', '21', 'change_menu');
INSERT INTO `auth_permission` VALUES ('63', 'Can delete menu', '21', 'delete_menu');

-- ----------------------------
-- Table structure for config
-- ----------------------------
DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `config_name` varchar(50) NOT NULL,
  `config_type` int(11) NOT NULL,
  `config_dir` varchar(255) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `config_config_name_5615281ad70664bb_uniq` (`config_name`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of config
-- ----------------------------

-- ----------------------------
-- Table structure for datacenter
-- ----------------------------
DROP TABLE IF EXISTS `datacenter`;
CREATE TABLE `datacenter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_number` varchar(32) NOT NULL,
  `name` varchar(100) NOT NULL,
  `area` varchar(100) NOT NULL,
  `editor` longtext,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `dataCenter_name_39b099e1311ba65e_uniq` (`name`,`area`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of datacenter
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8_unicode_ci,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_departmentName_26aae1504634ab6d_uniq` (`departmentName`,`availabity`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '运维部', '', '1');

-- ----------------------------
-- Table structure for department_auth
-- ----------------------------
DROP TABLE IF EXISTS `department_auth`;
CREATE TABLE `department_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `department_id` (`department_id`,`menu_id`),
  KEY `department_auth_menu_id_3170e55751de7135_fk_menu_id` (`menu_id`),
  CONSTRAINT `department_auth_department_id_518dd58fdfd94b0e_fk_department_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `department_auth_menu_id_3170e55751de7135_fk_menu_id` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department_auth
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `djang_content_type_id_697914295151027a_fk_django_content_type_id` (`content_type_id`),
  KEY `django_admin_log_user_id_52fdd58701c5f563_fk_myUser_id` (`user_id`),
  CONSTRAINT `djang_content_type_id_697914295151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_52fdd58701c5f563_fk_myUser_id` FOREIGN KEY (`user_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_45f3b1d93ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('6', 'accounts', 'department');
INSERT INTO `django_content_type` VALUES ('7', 'accounts', 'myuser');
INSERT INTO `django_content_type` VALUES ('1', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('18', 'alarm', 'alarm');
INSERT INTO `django_content_type` VALUES ('9', 'assets', 'asset');
INSERT INTO `django_content_type` VALUES ('12', 'assets', 'car');
INSERT INTO `django_content_type` VALUES ('11', 'assets', 'carlist');
INSERT INTO `django_content_type` VALUES ('10', 'assets', 'carmodel');
INSERT INTO `django_content_type` VALUES ('8', 'assets', 'datacenter');
INSERT INTO `django_content_type` VALUES ('3', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('2', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('13', 'configManager', 'config');
INSERT INTO `django_content_type` VALUES ('4', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('17', 'domainNameManager', 'domainname');
INSERT INTO `django_content_type` VALUES ('21', 'menuAuth', 'menu');
INSERT INTO `django_content_type` VALUES ('15', 'project', 'app');
INSERT INTO `django_content_type` VALUES ('14', 'project', 'approle');
INSERT INTO `django_content_type` VALUES ('16', 'project', 'app_roles');
INSERT INTO `django_content_type` VALUES ('5', 'sessions', 'session');
INSERT INTO `django_content_type` VALUES ('19', 'tastypie', 'apiaccess');
INSERT INTO `django_content_type` VALUES ('20', 'tastypie', 'apikey');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'menuAuth', '0001_initial', '2021-10-03 08:14:16.096452');
INSERT INTO `django_migrations` VALUES ('2', 'contenttypes', '0001_initial', '2021-10-03 08:14:16.107309');
INSERT INTO `django_migrations` VALUES ('3', 'contenttypes', '0002_remove_content_type_name', '2021-10-03 08:14:16.125731');
INSERT INTO `django_migrations` VALUES ('4', 'auth', '0001_initial', '2021-10-03 08:14:16.156831');
INSERT INTO `django_migrations` VALUES ('5', 'auth', '0002_alter_permission_name_max_length', '2021-10-03 08:14:16.179847');
INSERT INTO `django_migrations` VALUES ('6', 'auth', '0003_alter_user_email_max_length', '2021-10-03 08:14:16.187031');
INSERT INTO `django_migrations` VALUES ('7', 'auth', '0004_alter_user_username_opts', '2021-10-03 08:14:16.194328');
INSERT INTO `django_migrations` VALUES ('8', 'auth', '0005_alter_user_last_login_null', '2021-10-03 08:14:16.204082');
INSERT INTO `django_migrations` VALUES ('9', 'auth', '0006_require_contenttypes_0002', '2021-10-03 08:14:16.206823');
INSERT INTO `django_migrations` VALUES ('10', 'accounts', '0001_initial', '2021-10-03 08:14:16.344101');
INSERT INTO `django_migrations` VALUES ('11', 'admin', '0001_initial', '2021-10-03 08:14:16.371504');
INSERT INTO `django_migrations` VALUES ('12', 'project', '0001_initial', '2021-10-03 08:14:16.450517');
INSERT INTO `django_migrations` VALUES ('13', 'configManager', '0001_initial', '2021-10-03 08:14:16.467153');
INSERT INTO `django_migrations` VALUES ('14', 'assets', '0001_initial', '2021-10-03 08:14:16.576839');
INSERT INTO `django_migrations` VALUES ('15', 'assets', '0002_auto_20211003_1612', '2021-10-03 08:14:16.619586');
INSERT INTO `django_migrations` VALUES ('16', 'domainNameManager', '0001_initial', '2021-10-03 08:14:16.639535');
INSERT INTO `django_migrations` VALUES ('17', 'sessions', '0001_initial', '2021-10-03 08:14:16.654004');
INSERT INTO `django_migrations` VALUES ('18', 'tastypie', '0001_initial', '2021-10-03 08:14:16.693602');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('1ie980fkl1c0zm167r5ehrh6k040cf32', 'NzU5NDA0YWU3MjMwM2UxODFiZjE0ZmVjMzkzOTVmZTMxODU4YTIyYjp7Il9hdXRoX3VzZXJfaGFzaCI6IjFlZGNiYzAwNGFmMDI3MmMxMjk1NGJlNTA4NTk0NmI2YmI0ODA4ODgiLCJfYXV0aF91c2VyX2JhY2tlbmQiOiJkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZCIsIl9hdXRoX3VzZXJfaWQiOiIxIiwibWVudUF1dGgiOlt7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZWVhXHU4ODY4XHU3NmQ4IiwiaHRtbElEIjoiZGFzaGJvYXJkIiwidXJsIjoiL2Rhc2hib2FyZC9pbmRleC8iLCJmYXRoZXJJRCI6MCwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGFzaGJvYXJkIiwiaWNvbiI6ImZhLWJhci1jaGFydC1vIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoxfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU4ZDQ0XHU0ZWE3XHU3YmExXHU3NDA2IiwiaHRtbElEIjoiYXNzZXRzIiwidXJsIjoiIyIsImZhdGhlcklEIjowLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhc3NldHMiLCJpY29uIjoiZmEtZGVza3RvcCJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mn0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NzUyOFx1NjIzN1x1N2JhMVx1NzQwNiIsImh0bWxJRCI6ImFjY291bnRzIiwidXJsIjoiIyIsImZhdGhlcklEIjowLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhY2NvdW50cyIsImljb24iOiJmYS11c2VyIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjoyM30seyJmaWVsZHMiOnsibmFtZSI6Ilx1OTBlOFx1OTVlOFx1NTIxN1x1ODg2OCIsImh0bWxJRCI6ImRlcGFydG1lbnRMaXN0IiwidXJsIjoiL2FjY291bnRzL2RlcGFydG1lbnRMaXN0LyIsImZhdGhlcklEIjoyMywiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudExpc3QgZGVwYXJ0bWVudEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI0fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU2ZGZiXHU1MmEwXHU5MGU4XHU5NWU4IiwiaHRtbElEIjoiZGVwYXJ0bWVudEFkZCIsInVybCI6Ii9hY2NvdW50cy9kZXBhcnRtZW50QWRkLyIsImZhdGhlcklEIjoyNCwiYXZhaWxhYml0eSI6MSwiaHRtbENsYXNzIjoiZGVwYXJ0bWVudExpc3QgZGVwYXJ0bWVudEFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjI1fSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU3NTI4XHU2MjM3XHU1MjE3XHU4ODY4IiwiaHRtbElEIjoidXNlckxpc3QiLCJ1cmwiOiIvYWNjb3VudHMvdXNlckxpc3QvIiwiZmF0aGVySUQiOjIzLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJ1c2VyTGlzdCB1c2VyQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6MjZ9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTc1MjhcdTYyMzciLCJodG1sSUQiOiJ1c2VyQWRkIiwidXJsIjoiL2FjY291bnRzL3VzZXJBZGQvIiwiZmF0aGVySUQiOjI2LCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJ1c2VyTGlzdCB1c2VyQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mjd9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTY3NDNcdTk2NTBcdTdiYTFcdTc0MDYiLCJodG1sSUQiOiJhdXRoIiwidXJsIjoiIyIsImZhdGhlcklEIjowLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJhdXRoIiwiaWNvbiI6ImZhLWJhbiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mjh9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTgzZGNcdTUzNTVcdTUyMTdcdTg4NjgiLCJodG1sSUQiOiJtZW51QWRtaW5MaXN0IiwidXJsIjoiL2F1dGgvbWVudUFkbWluTGlzdC8iLCJmYXRoZXJJRCI6MjgsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6Im1lbnVBZG1pbkxpc3QgbWVudUFkbWluQWRkIiwiaWNvbiI6IiJ9LCJtb2RlbCI6Im1lbnVBdXRoLm1lbnUiLCJwayI6Mjl9LHsiZmllbGRzIjp7Im5hbWUiOiJcdTZkZmJcdTUyYTBcdTgzZGNcdTUzNTUiLCJodG1sSUQiOiJtZW51QWRtaW5BZGQiLCJ1cmwiOiIvYXV0aC9tZW51QWRtaW5BZGQvIiwiZmF0aGVySUQiOjI5LCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJtZW51QWRtaW5MaXN0IG1lbnVBZG1pbkFkZCIsImljb24iOiIifSwibW9kZWwiOiJtZW51QXV0aC5tZW51IiwicGsiOjMwfSx7ImZpZWxkcyI6eyJuYW1lIjoiXHU0ZWVhXHU4ODY4XHU3NmQ4IiwiaHRtbElEIjoiaW5kZXgiLCJ1cmwiOiIvZGFzaGJvYXJkL2luZGV4LyIsImZhdGhlcklEIjoxLCJhdmFpbGFiaXR5IjoxLCJodG1sQ2xhc3MiOiJkYXNoYm9hcmQiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozNH0seyJmaWVsZHMiOnsibmFtZSI6Ilx1NmM3ZFx1OGY2Nlx1OTFjY1x1N2EwYiIsImh0bWxJRCI6ImNhckxpc3QiLCJ1cmwiOiIvYXNzZXRzL2Nhckxpc3QvIiwiZmF0aGVySUQiOjIsImF2YWlsYWJpdHkiOjEsImh0bWxDbGFzcyI6ImNhckxpc3QiLCJpY29uIjoiIn0sIm1vZGVsIjoibWVudUF1dGgubWVudSIsInBrIjozNX1dfQ==', '2021-10-17 10:51:30.834726');

-- ----------------------------
-- Table structure for domainname
-- ----------------------------
DROP TABLE IF EXISTS `domainname`;
CREATE TABLE `domainname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `nameDistributor` varchar(50) NOT NULL,
  `exptresDate` varchar(20) NOT NULL,
  `user` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `organization` varchar(50) NOT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `domainName_name_136698b4b4d59d4_uniq` (`name`,`availabity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of domainname
-- ----------------------------

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `htmlID` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `availabity` bigint(20) NOT NULL,
  `icon` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fatherID` int(11) NOT NULL,
  `htmlClass` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `menu_htmlID_66f80517ea65b18b_uniq` (`htmlID`,`availabity`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '仪表盘', 'dashboard', '/dashboard/index/', '1', 'fa-bar-chart-o', '0', 'dashboard');
INSERT INTO `menu` VALUES ('2', '资产管理', 'assets', '#', '1', 'fa-desktop', '0', 'assets');
INSERT INTO `menu` VALUES ('4', '设备列表', 'host_list', '/assets/asset_list/', '1492681412', '', '3', null);
INSERT INTO `menu` VALUES ('5', '添加设备', 'assetAdd', '/assets/assetAdd/', '1', '', '3', 'assetList assetAdd');
INSERT INTO `menu` VALUES ('3', '设备管理', 'assetList', '/assets/assetList/', '1', 'arrow', '2', 'assetList assetAdd');
INSERT INTO `menu` VALUES ('7', '数据中心管理', 'idcList', '/assets/idcList/', '1', '', '2', 'idcList idcAdd');
INSERT INTO `menu` VALUES ('8', '数据中心列表', 'idc_list', '/assets/idc_list/', '1492681594', '', '7', null);
INSERT INTO `menu` VALUES ('9', '添加数据中心', 'idcAdd', '/assets/idcAdd/', '1', '', '7', 'idcList idcAdd');
INSERT INTO `menu` VALUES ('10', '应用管理', 'app', '#', '1', 'fa-money', '0', 'app');
INSERT INTO `menu` VALUES ('11', '应用列表', 'appList', '/app/appList/', '1', '', '10', 'appList appAdd');
INSERT INTO `menu` VALUES ('12', '应用添加', 'appAdd', '/app/appAdd/', '1', '', '11', 'appList appAdd');
INSERT INTO `menu` VALUES ('13', '应用角色', 'roleList', '/app/roleList/', '1', '', '10', 'roleList roleAdd');
INSERT INTO `menu` VALUES ('14', '应用角色添加', 'roleAdd', '/app/roleAdd/', '1', '', '13', 'roleList roleAdd');
INSERT INTO `menu` VALUES ('17', '域名管理', 'domainNameManager', '#', '1', 'fa-font', '0', 'domainNameManager');
INSERT INTO `menu` VALUES ('18', '域名列表', 'domainNameList', '/domainNameManager/domainNameList/', '1', '', '17', 'domainNameList domainNameAdd');
INSERT INTO `menu` VALUES ('19', '添加域名', 'domainNameAdd', '/domainNameManager/domainNameAdd/', '1', '', '18', 'domainNameList domainNameAdd');
INSERT INTO `menu` VALUES ('20', '配置管理', 'configManager', '#', '1', 'fa-wrench', '0', 'configManager');
INSERT INTO `menu` VALUES ('21', '配置列表', 'configList', '/configManager/configList/', '1', '', '20', 'configList configAdd');
INSERT INTO `menu` VALUES ('22', '添加配置', 'configAdd', '/configManager/configAdd/', '1', '', '21', 'configList configAdd');
INSERT INTO `menu` VALUES ('23', '用户管理', 'accounts', '#', '1', 'fa-user', '0', 'accounts');
INSERT INTO `menu` VALUES ('24', '部门列表', 'departmentList', '/accounts/departmentList/', '1', '', '23', 'departmentList departmentAdd');
INSERT INTO `menu` VALUES ('25', '添加部门', 'departmentAdd', '/accounts/departmentAdd/', '1', '', '24', 'departmentList departmentAdd');
INSERT INTO `menu` VALUES ('26', '用户列表', 'userList', '/accounts/userList/', '1', '', '23', 'userList userAdd');
INSERT INTO `menu` VALUES ('27', '添加用户', 'userAdd', '/accounts/userAdd/', '1', '', '26', 'userList userAdd');
INSERT INTO `menu` VALUES ('28', '权限管理', 'auth', '#', '1', 'fa-ban', '0', 'auth');
INSERT INTO `menu` VALUES ('29', '菜单列表', 'menuAdminList', '/auth/menuAdminList/', '1', '', '28', 'menuAdminList menuAdminAdd');
INSERT INTO `menu` VALUES ('30', '添加菜单', 'menuAdminAdd', '/auth/menuAdminAdd/', '1', '', '29', 'menuAdminList menuAdminAdd');
INSERT INTO `menu` VALUES ('31', '告警管理', 'alarm', '#', '1', 'fa-bullhorn', '0', 'alarm');
INSERT INTO `menu` VALUES ('32', '规则列表', 'alarmList', '/alarm/alarmList/', '1', '', '31', 'alarmList alarmAdd');
INSERT INTO `menu` VALUES ('33', '添加规则', 'alarmAdd', '/alarm/alarmAdd/', '1', '', '32', 'alarmList alarmAdd');
INSERT INTO `menu` VALUES ('34', '仪表盘', 'index', '/dashboard/index/', '1', '', '1', 'dashboard');
INSERT INTO `menu` VALUES ('35', '汽车里程', 'carList', '/assets/carList/', '1', '', '2', 'carList');
INSERT INTO `menu` VALUES ('36', '里程添加', 'carAdd', '/assets/carAdd/', '1633249081', '', '2', 'carAdd');

-- ----------------------------
-- Table structure for myuser
-- ----------------------------
DROP TABLE IF EXISTS `myuser`;
CREATE TABLE `myuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `first_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `last_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `wechat` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `qq` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `availabity` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `myUser_username_1843759df7e4cea3_uniq` (`username`,`availabity`),
  KEY `myUser_bf691be4` (`department_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of myuser
-- ----------------------------
INSERT INTO `myuser` VALUES ('1', 'pbkdf2_sha256$20000$DYS1J412ozE5$8jxicCjxDxS7SO+nD0nv5pZAbn4kwIsgHECLtfK2h/0=', '2021-10-03 10:51:31', '1', 'cmdbAdmin', '系统管理员', '', '', '1', '1', '2017-03-28 08:12:21', '', '', '', '1', '1');

-- ----------------------------
-- Table structure for myuser_auth
-- ----------------------------
DROP TABLE IF EXISTS `myuser_auth`;
CREATE TABLE `myuser_auth` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`menu_id`),
  KEY `myUser_auth_8b14fb18` (`myuser_id`),
  KEY `myUser_auth_93e25458` (`menu_id`)
) ENGINE=MyISAM AUTO_INCREMENT=257 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of myuser_auth
-- ----------------------------
INSERT INTO `myuser_auth` VALUES ('256', '1', '30');
INSERT INTO `myuser_auth` VALUES ('255', '1', '29');
INSERT INTO `myuser_auth` VALUES ('254', '1', '28');
INSERT INTO `myuser_auth` VALUES ('253', '1', '27');
INSERT INTO `myuser_auth` VALUES ('252', '1', '26');
INSERT INTO `myuser_auth` VALUES ('251', '1', '25');
INSERT INTO `myuser_auth` VALUES ('250', '1', '24');
INSERT INTO `myuser_auth` VALUES ('249', '1', '23');
INSERT INTO `myuser_auth` VALUES ('248', '1', '35');
INSERT INTO `myuser_auth` VALUES ('247', '1', '2');
INSERT INTO `myuser_auth` VALUES ('246', '1', '34');
INSERT INTO `myuser_auth` VALUES ('245', '1', '1');

-- ----------------------------
-- Table structure for myuser_groups
-- ----------------------------
DROP TABLE IF EXISTS `myuser_groups`;
CREATE TABLE `myuser_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`group_id`),
  KEY `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` (`group_id`),
  CONSTRAINT `myUser_groups_group_id_fa203646c0312e7_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `myUser_groups_myuser_id_346042a381ba62c4_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myuser_groups
-- ----------------------------

-- ----------------------------
-- Table structure for myuser_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `myuser_user_permissions`;
CREATE TABLE `myuser_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myuser_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `myuser_id` (`myuser_id`,`permission_id`),
  KEY `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` (`permission_id`),
  CONSTRAINT `myUser_user_permission_id_7786bf009f18fa28_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `myUser_user_permissions_myuser_id_27f715bec9c2e9d6_fk_myUser_id` FOREIGN KEY (`myuser_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of myuser_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for tastypie_apiaccess
-- ----------------------------
DROP TABLE IF EXISTS `tastypie_apiaccess`;
CREATE TABLE `tastypie_apiaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `request_method` varchar(10) NOT NULL,
  `accessed` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tastypie_apiaccess
-- ----------------------------

-- ----------------------------
-- Table structure for tastypie_apikey
-- ----------------------------
DROP TABLE IF EXISTS `tastypie_apikey`;
CREATE TABLE `tastypie_apikey` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(128) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `tastypie_apikey_3c6e0b8a` (`key`),
  CONSTRAINT `tastypie_apikey_user_id_ffeb4840e0b406b_fk_myUser_id` FOREIGN KEY (`user_id`) REFERENCES `myuser` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tastypie_apikey
-- ----------------------------
