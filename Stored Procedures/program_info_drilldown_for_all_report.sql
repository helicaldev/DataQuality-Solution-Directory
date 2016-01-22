create or replace procedure programInfoDrillDownAll(cur OUT sys_refcursor,rowId IN varchar2,resultsOpt IN varchar2,startDate IN varchar2,endDate IN varchar2,param_cols IN varchar2,a_key IN varchar2,p_key IN VARCHAR2,type_key IN VARCHAR2,coc_key IN varchar2)
IS
	queryRace varchar2(2000);
	queryGender varchar2(2000);
	queryEthnicity varchar2(2000);
	queryVeteran varchar2(2000);
	queryFname varchar2(2000);
	queryLname varchar2(2000);
	queryDob varchar2(2000);
	queryPhyDis varchar2(2000);
	queryDomVio varchar2(2000);
	queryMntlHlth varchar2(2000);
	queryHIV varchar2(2000);
	querySubstnce varchar2(2000);
	queryIncomeEntry varchar2(2000);
	queryIncomeExit varchar2(2000);
	queryChronic varchar2(2000);
	queryHousingSts varchar2(2000);
	queryNonCashEntry varchar2(2000);
	queryNonCashExit varchar2(2000);
	queryZip varchar(2000);
	queryRes varchar2(2000);
	a varchar2(500);
	innerQuery varchar2(30000);
	akey varchar2(500);
	pkey varchar2(500);
	typekey varchar2(500);
	cockey varchar2(500);
	code varchar2(100);
	codeD varchar2(100);
	codeR varchar2(100);
	
BEGIN
	code := 0;
	codeD := '8';
	codeR := '9';
	
	akey := a_key;
	pkey := p_key;
	typekey := type_key;
	cockey := coc_key;
	
	IF (INSTR(rowId,'Race') > 0) THEN
       	codeD := codeD || ',' || '15';

      END IF;
       
       IF (INSTR(rowId,'Race') > 0) THEN
				codeR := codeR || ',' || '16';
      END IF;
      
       IF(INSTR(resultsOpt,'Dont Know') > 0) THEN
       		code := code || ',' || codeD;

      END IF;
	  
	  IF(INSTR(resultsOpt, 'Refused') > 0) THEN
	  	 
          IF(code is null) THEN
            code := code || ',' || codeR;
          ELSE
			code := codeD || ',' || codeR;
          END IF;

     END IF;
	
	innerQuery := '';
	
	queryRace := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					LEFT JOIN PATHWAY.PATH_CLIENT_RACE CR ON C.RACE_KEY = CR.RACE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CR.RACE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryGender := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_GENDER CD ON C.GENDER_KEY = CD.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CD.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
	
	queryEthnicity := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_ETHNICITY CE ON C.ETHNICITY_KEY = CE.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CE.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
	
	queryVeteran := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_VETERAN CV ON C.VETERAN = CV.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CV.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND				   
					PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
	
	queryFname := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CN.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
	
	queryLname := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CN.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryDob := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_DOB_TYPE CD ON C.DOB_TYPE = CD.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CD.CODE_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryPhyDis := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 15 AND
					PD.ANSWER_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryMntlHlth := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 11 AND
					PD.ANSWER_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				 (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryDomVio := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 21 AND
					PD.ANSWER_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryChronic := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 30 AND
					PD.ANSWER_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryHIV := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 19 AND
					PD.ANSWER_KEY IN ('||code||') AND					
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	querySubstnce := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 29 AND
					PD.ANSWER_KEY IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryIncomeEntry := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.ENTRY_CASH_GK = CIC.INCOME_GROUP_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CIC.VERIFIED_ANSWER IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryIncomeExit := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.EXIT_CASH_GK = CIC.INCOME_GROUP_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CIC.VERIFIED_ANSWER IN ('||code||') AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND 
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryHousingSts := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HOUSING_STATUS CHS ON PP.HOUSING_STATUS_KEY = CHS.CODE_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
								CHS.CODE_KEY IN ('||code||') AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryNonCashEntry := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.ENTRY_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
								CIC.VERIFIED_ANSWER IN ('||code||') AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryNonCashExit := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.EXIT_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
					CIC.VERIFIED_ANSWER IN ('||code||') AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryZip := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
					CCH.ZIPCODE_LAST_PERM_ADDRESS IN ('||code||') AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	queryRes := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
					CCH.PRIOR_NIGHTS_RESIDENCE_KEY IN ('||code||') AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
		IF(INSTR(rowId,'Race') > 0) THEN
        innerQuery := innerQuery || queryRace;
	END IF;
						   
	IF(INSTR(rowId,'Gender') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryGender;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryGender;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Ethnicity') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryEthnicity;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryEthnicity;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Veteran') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryVeteran;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryVeteran;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Fname') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryFname;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryFname;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Lname') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryLname;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryLname;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Dob') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryDob;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryDob;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Physical') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryPhyDis;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryPhyDis;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Domestic') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryDomVio;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryDomVio;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Substance') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || querySubstnce;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || querySubstnce;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Mental') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryMntlHlth;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryMntlHlth;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Chronic') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryChronic;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryChronic;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Entry') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryIncomeEntry;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryIncomeEntry;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Exit') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryIncomeExit;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryIncomeExit;
        END IF;
	END IF;
	
	IF(INSTR(rowId,'HIV') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryHIV;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryHIV;
        END IF;
	END IF;
	
	IF(INSTR(rowId,'Non-cash Benefits At Entry') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryNonCashEntry;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryNonCashEntry;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Non-cash Benefits At Exit') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryNonCashExit;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryNonCashExit;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Housing Status') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryHousingSts;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryHousingSts;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Zip Of Last Perm Address') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryZip;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryZip;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Residence Prior To Entry') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryRes;
        ELSE
            innerQuery := innerQuery || ' UNION ALL ' || queryRes;
        END IF;
	END IF;

	IF(INSTR(rowId,'ALL') > 0) THEN
	
		innerQuery := queryRace || ' UNION ALL ' || queryGender || ' UNION ALL ' || queryEthnicity  || ' UNION ALL ' ||  queryVeteran || ' UNION ALL ' || queryFname || ' UNION ALL ' || queryLname || ' UNION ALL ' || queryDob || ' UNION ALL ' || queryPhyDis || ' UNION ALL ' || queryDomVio || ' UNION ALL ' || queryChronic || ' UNION ALL ' || queryMntlHlth || ' UNION ALL ' || queryHIV || ' UNION ALL ' || querySubstnce || ' UNION ALL ' || queryIncomeEntry || ' UNION ALL ' || queryIncomeExit;
				   
	END IF;
	OPEN cur FOR innerQuery;
				   
END;
/
