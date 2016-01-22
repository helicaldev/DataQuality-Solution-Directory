create or replace procedure progInfodrillDown(cur OUT sys_refcursor,startDate IN varchar2,endDate IN varchar2,result_option IN varchar2,param_cols IN varchar2,dataelem IN varchar2,a_key IN varchar2,p_key IN varchar2,type_key IN varchar2,coc_key IN varchar2)
IS
	a varchar2(500);
	innerQuery varchar2(6000);
	akey varchar2(500);
	pkey varchar2(500);
	typekey varchar2(500);
	cockey varchar2(500);
	dataelement varchar2(500);
	
BEGIN
	innerQuery := '';
	akey := a_key;
	pkey := p_key;
	typekey := type_key;
	cockey := coc_key;
	dataelement := dataelem;
	
	IF(dataelement = 'Race') THEN
	innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					LEFT JOIN PATHWAY.PATH_CLIENT_RACE CR ON C.RACE_KEY = CR.RACE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CR.RACE_KEY = (case when '''||result_option||''' = ''Dont Know'' then 15
											 when '''||result_option||''' = ''Refused'' then 16
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF(dataelement = 'Gender') THEN
	innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_GENDER CD ON C.GENDER_KEY = CD.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CD.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';

	ELSIF (dataelement = 'Ethnicity') THEN
	innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_ETHNICITY CE ON C.ETHNICITY_KEY = CE.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CE.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
																 when '''||result_option||''' = ''Refused'' then 9
																 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Veteran Status') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_VETERAN CV ON C.VETERAN = CV.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CV.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'First Name') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CN.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Last Name') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CN.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Date Of Birth') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
				INNER JOIN PATHWAY.PATH_CODE_DOB_TYPE CD ON C.DOB_TYPE = CD.CODE_KEY
				INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
				INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
				INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
				INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
				INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY					
				WHERE CD.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Physical Disability') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 15 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Domestic Violence') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 21 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Mental Health') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 11 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Chronic Health Condition') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 30 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Entry') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.ENTRY_CASH_GK = CIC.INCOME_GROUP_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CIC.VERIFIED_ANSWER =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Exit') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.EXIT_CASH_GK = CIC.INCOME_GROUP_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE CIC.VERIFIED_ANSWER =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'HIV') THEN
		innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 19 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Substance Abuse') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PD.NEEDS_CODE_KEY = 29 AND
					PD.ANSWER_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Housing Status') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HOUSING_STATUS CHS ON PP.HOUSING_STATUS_KEY = CHS.CODE_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
								CHS.CODE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Non-cash Benefits At Entry') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.ENTRY_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
								CIC.VERIFIED_ANSWER =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Non-cash Benefits At Exit') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.EXIT_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
					CIC.VERIFIED_ANSWER =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Zip Of Last Perm Address') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
					CCH.ZIPCODE_LAST_PERM_ADDRESS =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSIF (dataelement = 'Residence Prior To Entry') THEN
			innerQuery := 'select '||param_cols||' from (select distinct C.CLIENT_KEY as "Client Key",C.FIRST_NAME as "First Name",C.LAST_NAME as "Last Name",C.DATE_OF_BIRTH as "Date Of Birth",(select CR.DESCRIPTION from PATHWAY.PATH_CODE_RACE CR where CR.CODE_KEY = C.RACE_KEY) as "Race",(select CG.GENDER from PATHWAY.PATH_CODE_GENDER CG WHERE CG.CODE_KEY = C.GENDER_KEY) as "Gender",(select CE.DESCRIPTION from PATHWAY.PATH_CODE_ETHNICITY CE where CE.CODE_KEY = C.ETHNICITY_KEY) as "Ethnicity",(select CV.DESCRIPTION from PATHWAY.PATH_CODE_VETERAN CV where CV.CODE_KEY = C.VETERAN) as "Veteran Status",PP.ENTRY_DATE as "Project Entry Date",PP.EXIT_DATE as "Project Exit Date",PP.CREATE_USER_KEY as "Entering User Key"
					from PATHWAY.PATH_CLIENT C
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
					CCH.PRIOR_NIGHTS_RESIDENCE_KEY =(case when '''||result_option||''' = ''Dont Know'' then 8
											 when '''||result_option||''' = ''Refused'' then 9
											 when '''||result_option||''' = ''Missing'' then 99 end) AND
					PP.REC_ACTIVE = ''A'' AND
				  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
				  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
				  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
				  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
				   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
				   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD'')) a';
				   
	ELSE
			innerQuery := 'select ''one'' from dual';
	
	END IF;
	
	OPEN cur FOR innerQuery;
				   
END;
/
