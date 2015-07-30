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


-- Dumping structure for procedure OPENHMIS2.dataqualityDrillDown
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `dataqualityDrillDown`(IN `dataelement` VARCHAR(50), IN `a_key` VARCHAR(100), IN `p_key` VARCHAR(500), IN `resultsOpt` VARCHAR(100), IN `param_cols` VARCHAR(600), IN `startDate` VARCHAR(50), IN `endDate` VARCHAR(50))
BEGIN
    DECLARE a varchar(65535);
    DECLARE akey varchar(65535);
    DECLARE pkey varchar(65535);
    set a = REPLACE(param_cols,'\'','`');
    set akey = REPLACE(a_key,'\'','');
    set pkey = REPLACE(p_key,'\'','');
    IF dataelement = 'Race' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      FROM CLIENT C,CLIENT_RACE CR,CODE_RACE COR,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CR.CLIENT_KEY AND
      CR.RACE_CODE = COR.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (CR.RACE_CODE = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 15
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 16
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CR.RACE_CODE is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CR.RACE_CODE END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Gender' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENDER CG,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.GENDER_CODE = CG.CODE_KEY AND
      C.CLIENT_KEY = PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (C.GENDER_CODE = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR C.GENDER_CODE is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN C.GENDER_CODE END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Ethnicity' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_ETHNICITY CE,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CE.CODE_KEY = C.ETHNICITY_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (C.ETHNICITY_CODE = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR C.ETHNICITY_CODE is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN C.ETHNICITY_CODE END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Veteran Status' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CGe.CODE_KEY = C.VETERAN_STATUS_GCT AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (C.VETERAN_STATUS_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR C.VETERAN_STATUS_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN C.VETERAN_STATUS_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Physical Disability' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY = PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.PHYSICAL_GCT AND
      (CDs.PHYSICAL_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.PHYSICAL_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.PHYSICAL_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Chronic Health Condition' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.CHRONIC_HEALTH_COND_GCT AND
      (CDs.CHRONIC_HEALTH_COND_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.CHRONIC_HEALTH_COND_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.CHRONIC_HEALTH_COND_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'HIV/AIDS' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.HIVAIDS_GCT AND
      (CDs.HIVAIDS_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.HIVAIDS_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.HIVAIDS_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Mental Health' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.MENTAL_HEALTH_GCT AND
      (CDs.MENTAL_HEALTH_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.MENTAL_HEALTH_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.MENTAL_HEALTH_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Substance Abuse' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.SUBSTANCE_ABUSE_CODE AND
      (CDs.SUBSTANCE_ABUSE_CODE = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.SUBSTANCE_ABUSE_CODE is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.SUBSTANCE_ABUSE_CODE END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Domestic Violence' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.DOMES_VIOLENCE_GCT AND
      (CDs.DOMES_VIOLENCE_GCT = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDs.DOMES_VIOLENCE_GCT is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CDs.DOMES_VIOLENCE_GCT END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSEIF dataelement = 'Housing Status' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,CLIENT_HOUSEHOLD CH,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CH.CLIENT_KEY AND
      CH.HOUSEHOLD_KEY = CGe.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (CH.HOUSEHOLD_KEY = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 9
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CH.HOUSEHOLD_KEY is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN CH.HOUSEHOLD_KEY END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');

      ELSEIF dataelement = 'Date Of Birth' THEN
      set @query = CONCAT('select ',a,' from (select C.CLIENT_KEY as \'Client Key\',C.NAME_FIRST as \'First Name\',C.NAME_LAST as \'Last Name\',C.ENTRY_DATE_TIME as \'Project Entry Date\',C.ENTRY_USER_KEY as \'Entering User Key\',C.LOG_DATE_TIME as \'Project Exit Date\',(select CG.DESCRIPTION FROM CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_CODE) as Gender,(select CE.DESCRIPTION FROM CODE_ETHNICITY CE WHERE CE.CODE_KEY = C.ETHNICITY_CODE) as Ethnicity,(select CGe.DESCRIPTION FROM CODE_GENERAL CGe WHERE CGe.CODE_KEY = C.VETERAN_STATUS_GCT) as \'Veteran Status\',(select COR.DESCRIPTION FROM CODE_RACE COR,CLIENT_RACE CR WHERE C.CLIENT_KEY = CR.CLIENT_KEY AND COR.CODE_KEY = CR.RACE_CODE)as Race,(case when C.DATE_OF_BIRTH is null then \'\' else C.DATE_OF_BIRTH end) as \'Date Of Birth\'
      from CLIENT C,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A,CODE_DOB_TYPE CDOB
      WHERE
      CDOB.CODE_KEY=C.DOB_TYPE_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      (C.DOB_TYPE_CODE = CASE WHEN \'',resultsOpt,'\' = \'dk\' THEN 8
                     WHEN \'',resultsOpt,'\' = \'refused\' THEN 4
                     WHEN \'',resultsOpt,'\' = \'missing\' THEN \'\' OR CDOB.CODE_KEY is null
                     WHEN \'',resultsOpt,'\' = \'Totalapplicableclients\' THEN C.DOB_TYPE_CODE END) AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\') b');
      ELSE
        select 1 as one;
    END IF;
    prepare a from @query;
       execute a;
	END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
