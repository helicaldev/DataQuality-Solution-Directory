-- --------------------------------------------------------
-- Host:                         173.194.107.15
-- Server version:               5.5.44 - (Google)
-- Server OS:                    Linux
-- HeidiSQL Version:             8.3.0.4694
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping database structure for OPENHMIS2
CREATE DATABASE IF NOT EXISTS `OPENHMIS2` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `OPENHMIS2`;


-- Dumping structure for procedure OPENHMIS2.programInfoDrillDownAll
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `programInfoDrillDownAll`(IN `dataelemId` VARCHAR(500), IN `a_key` VARCHAR(50), IN `p_key` VARCHAR(50), IN `resultsOpt` VARCHAR(500), IN `param_cols` VARCHAR(600), IN `startDate` VARCHAR(50), IN `endDate` VARCHAR(50), IN `project_type_code` VARCHAR(100), IN `cockey` VARCHAR(50))
BEGIN
       DECLARE a varchar(65535);
       DECLARE akey varchar(65535);
       DECLARE pkey varchar(65535);
	   DECLARE type_code varchar(65535);
	   DECLARE coc_key varchar(65535);
       DECLARE rowId varchar(65535);
       DECLARE queryRace varchar(65535);
	   DECLARE queryGender varchar(65535);
       DECLARE queryEthnicity varchar(65535);
	   DECLARE queryVetSts varchar(65535);
	   DECLARE queryPhyDis varchar(65535);
       DECLARE queryChronicHltCond varchar(65535);
       DECLARE queryHivAids varchar(65535);
	   DECLARE queryMentlHlth varchar(65535);
       DECLARE querySubstncAbs varchar(65535);
       DECLARE queryDomstcViolnc varchar(65535);
       DECLARE queryHousngSts varchar(65535);
       DECLARE queryDateOfBirth varchar(65535);
       DECLARE queryFirstName varchar(65535);
       DECLARE queryLastName varchar(65535);
       DECLARE queryZip varchar(65535);
       DECLARE queryRes varchar(65535);
       DECLARE queryIncomeEntry varchar(65535);
       DECLARE queryIncomeExit varchar(65535);
       DECLARE queryBenefitsEntry varchar(65535);
       DECLARE queryBenefitsExit varchar(65535);
       DECLARE innerQuery varchar(65535);
       DECLARE code varchar(65535);
       DECLARE codeD varchar(65535);
       DECLARE codeR varchar(65535);
	    set a = REPLACE(param_cols,'\'','');
       set akey = REPLACE(a_key,'\'','');
       set pkey = REPLACE(p_key,'\'','');
	   set type_code = REPLACE(project_type_code,'\'','');
	   set coc_key = REPLACE(cockey,'\'','');
       set rowId = REPLACE(dataelemId,'\'','');
       
       set innerQuery = '';
       set code = '';
       set codeD = '8';
       set codeR = '9';
       IF (INSTR(rowId,'Race')) THEN
       	set codeD = CONCAT(codeD,',','15');

      END IF;
       
       IF (INSTR(rowId,'Race')) THEN
				set codeR = CONCAT(codeR,',','16');
      END IF;
      
       IF(INSTR(resultsOpt,'Dont Know')) THEN
       		set code = CONCAT(code,codeD);

      END IF;
	  
	  IF(INSTR(resultsOpt, 'Refused')) THEN
	  	 
          IF(LENGTH(code)=0) THEN
            set code = CONCAT(code,codeR);
          ELSE
          set code = CONCAT(code,',',codeR);
          END IF;

     END IF;
	   
	   set queryRace = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      FROM CLIENT C,CLIENT_RACE CR,CODE_RACE COR,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CR.CLIENT_KEY AND
      CR.RACE_CODE = COR.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CR.RACE_CODE in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryGender = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENDER CG,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.GENDER_CODE = CG.CODE_KEY AND
      C.CLIENT_KEY = PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      C.GENDER_CODE in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryEthnicity = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_ETHNICITY CE,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CE.CODE_KEY = C.ETHNICITY_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      C.ETHNICITY_CODE in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryVetSts = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CGe.CODE_KEY = C.VETERAN_STATUS_GCT AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      C.VETERAN_STATUS_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryPhyDis = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY = PP.CLIENT_KEY AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      CGe.CODE_KEY = CDs.PHYSICAL_GCT AND
      CDs.PHYSICAL_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryChronicHltCond = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      CGe.CODE_KEY = CDs.CHRONIC_HEALTH_COND_GCT AND
      CDs.CHRONIC_HEALTH_COND_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryHivAids = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.HIVAIDS_GCT AND
      CDs.HIVAIDS_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
     (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryMentlHlth = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.MENTAL_HEALTH_GCT AND
      CDs.MENTAL_HEALTH_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set querySubstncAbs = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.SUBSTANCE_ABUSE_CODE AND
      CDs.SUBSTANCE_ABUSE_CODE in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryDomstcViolnc = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.DOMES_VIOLENCE_GCT AND
      CDs.DOMES_VIOLENCE_GCT in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryHousngSts = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,CLIENT_HOUSEHOLD CH,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CH.CLIENT_KEY AND
      CH.HOUSEHOLD_KEY = CGe.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CH.HOUSEHOLD_KEY in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
	  
	  set queryDateOfBirth = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',DATE_FORMAT(C.ENTRY_DATE_TIME,\'%m-%d-%Y\') as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',DATE_FORMAT(C.LOG_DATE_TIME,\'%m-%d-%Y\') as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else DATE_FORMAT(C.DATE_OF_BIRTH,\'%m-%d-%Y\') end) as \'Date Of Birth\'
      from CLIENT C,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A,CODE_DOB_TYPE CDOB
      WHERE
      CDOB.CODE_KEY=C.DOB_TYPE_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      C.DOB_TYPE_CODE in (',code,') AND
      PP.REC_ACTIVE_GCT = 1 AND
      (A.AGENCY_KEY IN(',akey,') OR \'-1\' IN(',akey,')) AND
      (P.PROJECT_KEY IN(',pkey,') OR \'-1\' IN(',pkey,')) AND
	  (P.PROJECT_TYPE_CODE IN(',type_code,') OR \'-1\' IN(',type_code,')) AND
	  (P.COC_GROUP_KEY IN(',coc_key,') OR \'-1\' IN(',coc_key,')) AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      
      set queryFirstName = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');

		set queryLastName = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryRes = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryZip = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryIncomeEntry = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryIncomeExit = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryBenefitsEntry = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
		
		set queryBenefitsExit = CONCAT('select ',a,' from (select \'\' as \'Client Key\',\'\' as \'First Name\',\'\' as \'Last Name\',\'\' as \'Project Entry Date\',\'\' as \'Entering User Key\',\'\' as \'Project Exit Date\',\'\' as Gender,\'\' as Ethnicity,\'\' as \'Veteran Status\',\'\' as Race,\'\' as \'Date Of Birth\') b');
	  
	  IF(INSTR(rowId,'Race')) THEN
          set innerQuery = CONCAT(innerQuery,queryRace);

      END IF;
	  
	  IF(INSTR(rowId, 'Gender')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryGender);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryGender);
          END IF;

     END IF;
	  
	  IF(INSTR(rowId, 'Ethnicity')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerQuery,queryEthnicity);
          ELSE
          set innerQuery = CONCAT(innerQuery,' UNION ALL ',queryEthnicity);
          END IF;

     END IF;
	 
	 IF(INSTR(rowId, 'Veteran Status')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryVetSts);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryVetSts);
          END IF;

     END IF;
	 
	 IF(INSTR(rowId, 'Physical Disability')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryPhyDis);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ALL ',queryPhyDis);
          END IF;

     END IF;

     IF(INSTR(rowId, 'Chronic Health Condition')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryChronicHltCond);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ALL ',queryChronicHltCond);
          END IF;

     END IF;

    IF(INSTR(rowId, 'HIV/AIDS')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryHivAids);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ALL ',queryHivAids);
          END IF;

     END IF;
	 
	 IF(INSTR(rowId, 'Mental Health')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryMentlHlth);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryMentlHlth);
          END IF;

     END IF;

    IF(INSTR(rowId, 'Substance Abuse')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,querySubstncAbs);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',querySubstncAbs);
          END IF;

     END IF;

    IF(INSTR(rowId, 'Domestic Violence')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryDomstcViolnc);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryDomstcViolnc);
          END IF;

     END IF;

    IF(INSTR(rowId, 'Housing Status')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryHousngSts);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryHousngSts);
          END IF;

     END IF;

    IF(INSTR(rowId, 'Date Of Birth')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryDateOfBirth);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryDateOfBirth);
          END IF;

     END IF;
     
     	   IF(INSTR(rowId,'First Name')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryFirstName);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryFirstName);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Last Name')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryLastName);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryLastName);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Residence Prior To Entry')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryRes);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryRes);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Zip Of Last Perm Residence')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryZip);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryZip);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Income(At Entry)')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryIncomeEntry);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryIncomeEntry);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Income(At Exit)')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryIncomeExit);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryIncomeExit);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Non-cash Benefits(At Entry)')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryBenefitsEntry);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryBenefitsEntry);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'Non-cash Benefits(At Exit)')) THEN
     		IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryBenefitsExit);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryBenefitsExit);
          END IF;

     END IF;
     
     IF(INSTR(rowId,'ALL')) THEN
     			set innerQuery = CONCAT(innerQuery,queryRace,' UNION ',queryGender,' UNION ',queryEthnicity,' UNION ',queryVetSts,' UNION ',queryPhyDis,' UNION ',queryChronicHltCond,' UNION ',queryHivAids,' UNION ',queryMentlHlth,' UNION ',querySubstncAbs,' UNION ',queryDomstcViolnc,' UNION ',queryHousngSts,' UNION ',queryDateOfBirth,' UNION ',queryFirstName,' UNION ',queryLastName,' UNION ',queryZip,' UNION ',queryRes,' UNION ',queryIncomeEntry,' UNION ',queryIncomeExit,' UNION ',queryBenefitsEntry,' UNION ',queryBenefitsExit);
     	END IF;

	 set @Query = CONCAT('select * from (',innerQuery,') a');
      --  select innerQuery;
       prepare b from @Query;
       execute b;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
