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


-- Dumping structure for procedure OPENHMIS2.dataQualityMainReport
DELIMITER //
CREATE DEFINER=`root`@`%` PROCEDURE `dataQualityMainReport`(IN `a_key` VARCHAR(50), IN `p_Key` VARCHAR(50), IN `data_element` VARCHAR(600), IN `param_cols` VARCHAR(500), IN `startDate` VARCHAR(50), IN `endDate` VARCHAR(50))
BEGIN
       DECLARE a varchar(65535);
       DECLARE akey varchar(65535);
       DECLARE pkey varchar(65535);
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
       DECLARE innerQuery varchar(65535);
       set a = REPLACE(param_cols,'\'','`');
       set akey = REPLACE(a_key,'\'','');
       set pkey = REPLACE(p_Key,'\'','');
       set rowId = REPLACE(data_element,'\'','');
       set innerQuery = '';

       set queryRace = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Race\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CR.RACE_CODE = 15 then CR.RACE_CODE end) as dk,
      count(case when CR.RACE_CODE = 16 then CR.RACE_CODE end) as Refused,
      count(case when (CR.RACE_CODE = \'\' or CR.RACE_CODE is null) then CR.RACE_CODE end) as Missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CLIENT_RACE CR,CODE_RACE COR,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CR.CLIENT_KEY AND
      CR.RACE_CODE = COR.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryGender = CONCAT('select distinct dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Gender\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when C.GENDER_CODE = 8 then C.GENDER_CODE end) as dk,
      count(case when C.GENDER_CODE = 9 then C.GENDER_CODE end) as Refused,
      count(case when (C.GENDER_CODE = \'\' or C.GENDER_CODE is null) then C.GENDER_CODE end) as Missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENDER CG,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CG.CODE_KEY = C.GENDER_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryEthnicity = CONCAT('select distinct dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Ethnicity\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when C.ETHNICITY_CODE = 8 then C.ETHNICITY_CODE end) as dk,
      count(case when C.ETHNICITY_CODE = 9 then C.ETHNICITY_CODE end) as refused,
      count(case when (C.ETHNICITY_CODE = \'\' or C.ETHNICITY_CODE is null) then C.ETHNICITY_CODE end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_ETHNICITY CE,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CE.CODE_KEY = C.ETHNICITY_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryVetSts = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Veteran Status\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when C.VETERAN_STATUS_GCT = 8 then C.VETERAN_STATUS_GCT end) as dk,
      count(case when C.VETERAN_STATUS_GCT = 9 then C.VETERAN_STATUS_GCT end) as refused,
      count(case when C.VETERAN_STATUS_GCT = 99 then C.VETERAN_STATUS_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      CGe.CODE_KEY = C.VETERAN_STATUS_GCT AND
      C.CLIENT_KEY = PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryPhyDis = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Physical Disability\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.PHYSICAL_GCT = 8 then CDs.PHYSICAL_GCT end) as dk,
      count(case when CDs.PHYSICAL_GCT = 9 then CDs.PHYSICAL_GCT end) as refused,
      count(case when CDs.PHYSICAL_GCT = 99 then CDs.PHYSICAL_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.PHYSICAL_GCT AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryChronicHltCond = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk  as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Chronic Health Condition\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.CHRONIC_HEALTH_COND_GCT = 8 then CDs.CHRONIC_HEALTH_COND_GCT end) as dk,
      count(case when CDs.CHRONIC_HEALTH_COND_GCT = 9 then CDs.CHRONIC_HEALTH_COND_GCT end) as refused,
      count(case when CDs.CHRONIC_HEALTH_COND_GCT = 99 then CDs.CHRONIC_HEALTH_COND_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.CHRONIC_HEALTH_COND_GCT AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryHivAids = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'HIV/AIDS\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.HIVAIDS_GCT = 8 then CDs.HIVAIDS_GCT end) as dk,
      count(case when CDs.HIVAIDS_GCT = 9 then CDs.HIVAIDS_GCT end) as refused,
      count(case when CDs.HIVAIDS_GCT = 99 then CDs.HIVAIDS_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.HIVAIDS_GCT AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryMentlHlth = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Mental Health\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.MENTAL_HEALTH_GCT = 8 then CDs.MENTAL_HEALTH_GCT end) as dk,
      count(case when CDs.MENTAL_HEALTH_GCT = 9 then CDs.MENTAL_HEALTH_GCT end) as refused,
      count(case when CDs.MENTAL_HEALTH_GCT = 99 then CDs.MENTAL_HEALTH_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.MENTAL_HEALTH_GCT AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set querySubstncAbs = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Substance Abuse\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.SUBSTANCE_ABUSE_CODE = 8 then CDs.SUBSTANCE_ABUSE_CODE end) as dk,
      count(case when CDs.SUBSTANCE_ABUSE_CODE = 9 then CDs.SUBSTANCE_ABUSE_CODE end) as refused,
      count(case when CDs.SUBSTANCE_ABUSE_CODE = 99 then CDs.SUBSTANCE_ABUSE_CODE end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.SUBSTANCE_ABUSE_CODE AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryDomstcViolnc = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Domestic Violence\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CDs.DOMES_VIOLENCE_GCT = 8 then CDs.DOMES_VIOLENCE_GCT end) as dk,
      count(case when CDs.DOMES_VIOLENCE_GCT = 9 then CDs.DOMES_VIOLENCE_GCT end) as refused,
      count(case when CDs.DOMES_VIOLENCE_GCT = 99 then CDs.DOMES_VIOLENCE_GCT end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CODE_GENERAL CGe,CLIENT_DISABILITIES CDs,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY = CDs.CLIENT_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      CGe.CODE_KEY = CDs.DOMES_VIOLENCE_GCT AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryHousngSts = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from(select \'Housing Status\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when CH.HOUSEHOLD_KEY = 8 then CH.HOUSEHOLD_KEY end) as dk,
      count(case when CH.HOUSEHOLD_KEY = 9 then CH.HOUSEHOLD_KEY end) as refused,
      count(case when (CH.HOUSEHOLD_KEY = \'\' or CH.HOUSEHOLD_KEY is null) then CH.HOUSEHOLD_KEY end) as missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,CLIENT_HOUSEHOLD CH,CODE_GENERAL CGe,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A
      WHERE
      C.CLIENT_KEY=CH.CLIENT_KEY AND
      CH.HOUSEHOLD_KEY = CGe.CODE_KEY AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      set queryDateOfBirth = CONCAT('select dataelements,',a,' from (select z.dataelements,z.dk as \'Dont Know\',z.Refused,z.Missing,z.Totalapplicableclients,((z.dk+z.Refused+z.Missing)/z.Totalapplicableclients) as total from
      (select \'Date Of Birth\' as dataelements,PP.ENTRY_DATE,PP.EXIT_DATE,
      count(case when C.DOB_TYPE_CODE = 8 then C.DOB_TYPE_CODE end) as dk,
      count(case when C.DOB_TYPE_CODE = 4 then C.DOB_TYPE_CODE end) as Refused,
      count(case when (C.DOB_TYPE_CODE = \'\' or C.DOB_TYPE_CODE is null) then C.DOB_TYPE_CODE end) as Missing,
      count(case when \'Clients in Programs Only\' = \'Clients in Programs Only\' and PP.REC_ACTIVE_GCT = 1 then
      PP.CLIENT_KEY end) as Totalapplicableclients
      from CLIENT C,PROJECT_PARTICIPATION PP,PROJECT P, AGENCY A,CODE_DOB_TYPE CDOB
      WHERE
      CDOB.CODE_KEY=C.DOB_tYPE_CODE AND
      C.CLIENT_KEY=PP.CLIENT_KEY AND
      P.PROJECT_KEY = PP.PROJECT_KEY AND
      A.AGENCY_KEY = P.AGENCY_KEY AND
      PP.REC_ACTIVE_GCT = 1 AND
      A.AGENCY_KEY IN(',akey,') AND
      P.PROJECT_KEY IN(',pkey,') AND
      PP.ENTRY_DATE <= \'',endDate,'\' AND
      PP.EXIT_DATE >= \'',startDate,'\')z)b');

      IF(INSTR(rowId,'Race')) THEN
          set innerQuery = CONCAT(innerquery,queryRace);

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
            set innerQuery = CONCAT(innerquery,queryEthnicity);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryEthnicity);
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
          set innerQuery = CONCAT(innerquery,' UNION ',queryPhyDis);
          END IF;

     END IF;

     IF(INSTR(rowId, 'Chronic Health Condition')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryChronicHltCond);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryChronicHltCond);
          END IF;

     END IF;

    IF(INSTR(rowId, 'HIV/AIDS')) THEN
          IF(LENGTH(innerQuery)=0) THEN
            set innerQuery = CONCAT(innerquery,queryHivAids);
          ELSE
          set innerQuery = CONCAT(innerquery,' UNION ',queryHivAids);
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

       set @Query = CONCAT('select * from (',innerQuery,') a');
      --  select innerQuery;
       prepare b from @Query;
       execute b;
END//
DELIMITER ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
