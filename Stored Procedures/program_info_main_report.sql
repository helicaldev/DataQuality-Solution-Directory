create or replace procedure progInfoMainReport(cur OUT SYS_REFCURSOR,startDate IN varchar2,endDate IN varchar2,a_key IN varchar2,p_key IN VARCHAR2,type_key IN VARCHAR2,coc_key IN varchar2,param_cols IN varchar2,rowId IN varchar2)
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
	queryZip varchar2(2000);
	queryRes varchar2(2000);
	a varchar2(500);
	innerQuery varchar2(30000);
	akey varchar2(500);
	pkey varchar2(500);
	typekey varchar2(500);
	cockey varchar2(500);
BEGIN
	
	akey := a_key;
	pkey := p_key;
	typekey := type_key;
	cockey := coc_key;
	innerQuery := '';
	
	queryRace := 'select dataelements,'||param_cols|| ' from (select ''Race'' as dataelements,
					count(distinct case when CR.RACE_KEY = 15 then CR.RACE_KEY end) as "Dont Know",
					count(distinct case when CR.RACE_KEY = 16 then CR.RACE_KEY end) as "Refused",
					count(distinct case when CR.RACE_KEY = 99 then CR.RACE_KEY end) as "Missing"
					from PATHWAY.PATH_CLIENT C
					LEFT JOIN PATHWAY.PATH_CLIENT_RACE CR ON C.RACE_KEY = CR.RACE_KEY
					INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
					INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
					INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
					INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
					INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
					WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryGender :=	'select dataelements,'||param_cols|| ' from (select ''Gender'' as dataelements,
						count(distinct case when CD.CODE_KEY = 8 then CD.CODE_KEY end) as "Dont Know",
						count(distinct case when CD.CODE_KEY = 9 then CD.CODE_KEY end) as "Refused",
						count(distinct case when CD.CODE_KEY = 99 then CD.CODE_KEY end) as "Missing"
						from PATHWAY.PATH_CLIENT C
						INNER JOIN PATHWAY.PATH_CODE_GENDER CD ON C.GENDER_KEY = CD.CODE_KEY
						INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
						INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
						INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
						INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
						INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
						WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryEthnicity := 'select dataelements,'||param_cols|| ' from (select ''Ethnicity'' as dataelements,
							count(distinct case when CE.CODE_KEY = 8 then CE.CODE_KEY end) as "Dont Know",
							count(distinct case when CE.CODE_KEY = 9 then CE.CODE_KEY end) as "Refused",
							count(distinct case when CE.CODE_KEY = 99 then CE.CODE_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CODE_ETHNICITY CE ON C.ETHNICITY_KEY = CE.CODE_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryVeteran := 'select dataelements,'||param_cols|| ' from (select ''Veteran Status'' as dataelements,
							count(distinct case when CV.CODE_KEY = 8 then CV.CODE_KEY end) as "Dont Know",
							count(distinct case when CV.CODE_KEY = 9 then CV.CODE_KEY end) as "Refused",
							count(distinct case when CV.CODE_KEY = 99 then CV.CODE_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CODE_VETERAN CV ON C.VETERAN = CV.CODE_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryFname := 'select dataelements,'||param_cols|| ' from (select ''First Name'' as dataelements,
							count(distinct case when CN.CODE_KEY = 8 then CN.CODE_KEY end) as "Dont Know",
							count(distinct case when CN.CODE_KEY = 9 then CN.CODE_KEY end) as "Refused",
							count(distinct case when CN.CODE_KEY = 99 then CN.CODE_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryLname :=	'select dataelements,'||param_cols|| ' from (select ''Last Name'' as dataelements,
							count(distinct case when CN.CODE_KEY = 8 then CN.CODE_KEY end) as "Dont Know",
							count(distinct case when CN.CODE_KEY = 9 then CN.CODE_KEY end) as "Refused",
							count(distinct case when CN.CODE_KEY = 99 then CN.CODE_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CODE_NAME_TYPE CN ON C.NAME_TYPE = CN.CODE_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryDob := 'select dataelements,'||param_cols|| ' from (select ''Date Of Birth'' as dataelements,
							count(distinct case when CD.CODE_KEY = 8 then CD.CODE_KEY end) as "Dont Know",
							count(distinct case when CD.CODE_KEY = 9 then CD.CODE_KEY end) as "Refused",
							count(distinct case when CD.CODE_KEY = 99 then CD.CODE_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CODE_DOB_TYPE CD ON C.DOB_TYPE = CD.CODE_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryPhyDis := 'select dataelements,'||param_cols|| ' from (select ''Physical Disability'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
							PD.NEEDS_CODE_KEY = 15 AND 
							(A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryDomVio := 'select dataelements,'||param_cols|| ' from (select ''Domestic Violence'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PD.NEEDS_CODE_KEY = 21 AND 
							PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryMntlHlth :=	'select dataelements,'||param_cols|| ' from (select ''Mental Health'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PD.NEEDS_CODE_KEY = 11 AND
							PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryChronic := 'select dataelements,'||param_cols|| ' from (select ''Chronic Health Condition'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PD.NEEDS_CODE_KEY = 30 AND 
							PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryHIV := 'select dataelements,'||param_cols|| ' from (select ''HIV AIDS'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PD.NEEDS_CODE_KEY = 19 AND
							PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	querySubstnce := 'select dataelements,'||param_cols|| ' from (select ''Substance Abuse'' as dataelements,
							count(distinct case when PD.ANSWER_KEY = 8 then PD.ANSWER_KEY end) as "Dont Know",
							count(distinct case when PD.ANSWER_KEY = 9 then PD.ANSWER_KEY end) as "Refused",
							count(distinct case when PD.ANSWER_KEY = 99 then PD.ANSWER_KEY end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_SPECIAL_NEEDS PD ON C.CLIENT_KEY = PD.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PD.NEEDS_CODE_KEY = 29 AND 
							PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryIncomeEntry :=	'select dataelements,'||param_cols|| ' from (select ''Income At Entry'' as dataelements,
							count(distinct case when CIC.VERIFIED_ANSWER = 8 then CIC.VERIFIED_ANSWER end) as "Dont Know",
							count(distinct case when CIC.VERIFIED_ANSWER = 9 then CIC.VERIFIED_ANSWER end) as "Refused",
							count(distinct case when CIC.VERIFIED_ANSWER = 99 then CIC.VERIFIED_ANSWER end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.ENTRY_CASH_GK = CIC.INCOME_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryIncomeExit := 'select dataelements,'||param_cols|| ' from (select ''Income At Exit'' as dataelements,
							count(distinct case when CIC.VERIFIED_ANSWER = 8 then CIC.VERIFIED_ANSWER end) as "Dont Know",
							count(distinct case when CIC.VERIFIED_ANSWER = 9 then CIC.VERIFIED_ANSWER end) as "Refused",
							count(distinct case when CIC.VERIFIED_ANSWER = 99 then CIC.VERIFIED_ANSWER end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_CASH CIC ON PP.EXIT_CASH_GK = CIC.INCOME_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryHousingSts := 'select dataelements,'||param_cols|| ' from (select ''Housing Status'' as dataelements,
								count(distinct case when CHS.CODE_KEY = 8 then CHS.CODE_KEY end) as "Dont Know",
								count(distinct case when CHS.CODE_KEY = 9 then CHS.CODE_KEY end) as "Refused",
								count(distinct case when CHS.CODE_KEY = 99 then CHS.CODE_KEY end) as "Missing"
								from PATHWAY.PATH_CLIENT C
								INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HOUSING_STATUS CHS ON PP.HOUSING_STATUS_KEY = CHS.CODE_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
								(A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
							  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
							  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
							  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
							   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
							   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
							   
	queryNonCashEntry :=	'select dataelements,'||param_cols|| ' from (select ''Non-cash Benefits At Entry'' as dataelements,
							count(distinct case when CIC.VERIFIED_ANSWER = 8 then CIC.VERIFIED_ANSWER end) as "Dont Know",
							count(distinct case when CIC.VERIFIED_ANSWER = 9 then CIC.VERIFIED_ANSWER end) as "Refused",
							count(distinct case when CIC.VERIFIED_ANSWER = 99 then CIC.VERIFIED_ANSWER end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.ENTRY_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryNonCashExit := 'select dataelements,'||param_cols|| ' from (select ''Non-cash Benefits At Exit'' as dataelements,
							count(distinct case when CIC.VERIFIED_ANSWER = 8 then CIC.VERIFIED_ANSWER end) as "Dont Know",
							count(distinct case when CIC.VERIFIED_ANSWER = 9 then CIC.VERIFIED_ANSWER end) as "Refused",
							count(distinct case when CIC.VERIFIED_ANSWER = 99 then CIC.VERIFIED_ANSWER end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_INCOME_NONCASH CIC ON PP.EXIT_NONCASH_GK = CIC.NON_CASH_GROUP_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
						  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
						  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
						  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
						  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
						   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
						   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   
	queryZip := 'select dataelements,'||param_cols|| ' from (select ''Zip Of Last Perm Address'' as dataelements,
							count(distinct case when CCH.ZIPCODE_LAST_PERM_ADDRESS = 8 then CCH.ZIPCODE_LAST_PERM_ADDRESS end) as "Dont Know",
							count(distinct case when CCH.ZIPCODE_LAST_PERM_ADDRESS = 9 then CCH.ZIPCODE_LAST_PERM_ADDRESS end) as "Refused",
							count(distinct case when CCH.ZIPCODE_LAST_PERM_ADDRESS = 99 then CCH.ZIPCODE_LAST_PERM_ADDRESS end) as "Missing"
							from PATHWAY.PATH_CLIENT C
							INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
							INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
							INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
							INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
							INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
							WHERE PP.REC_ACTIVE = ''A'' AND
													  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
													  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
													  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
													  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
													   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
													   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';

	queryRes := 'select dataelements,'||param_cols|| ' from (select ''Residence Prior To Entry'' as dataelements,
								count(distinct case when CCH.PRIOR_NIGHTS_RESIDENCE_KEY = 8 then CCH.PRIOR_NIGHTS_RESIDENCE_KEY end) as "Dont Know",
								count(distinct case when CCH.PRIOR_NIGHTS_RESIDENCE_KEY = 9 then CCH.PRIOR_NIGHTS_RESIDENCE_KEY end) as "Refused",
								count(distinct case when CCH.PRIOR_NIGHTS_RESIDENCE_KEY = 99 then CCH.PRIOR_NIGHTS_RESIDENCE_KEY end) as "Missing"
								from PATHWAY.PATH_CLIENT C
								INNER JOIN PATHWAY.PATH_CLIENT_PROGRAM PP ON C.CLIENT_KEY = PP.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CLIENT_CHRONIC_HOMELESS CCH ON C.CLIENT_KEY = CCH.CLIENT_KEY
								INNER JOIN PATHWAY.PATH_CODE_HUD_PROGRAM P ON P.PROGRAM_KEY = PP.PROGRAM_NAME_KEY
								INNER JOIN PATHWAY.PATH_AGENCY A ON P.AGENCY_KEY = A.AGENCY_KEY
								INNER JOIN PATHWAY.PATH_CODE_PROGRAM_TYPE PT ON P.PROGRAM_TYPE_KEY = PT.CODE_KEY
								INNER JOIN PATHWAY.PATH_PROGRAM_COC_LOCATION PC ON PC.PROGRAM_KEY = P.PROGRAM_KEY
								WHERE PP.REC_ACTIVE = ''A'' AND
								  (A.AGENCY_KEY IN('||akey||') or -1 in ('||akey||')) AND
								  (P.PROGRAM_KEY IN('||pkey||') or -1 in ('||pkey||')) AND
								  (PT.CODE_KEY IN('||typekey||') or -1 in ('||typekey||')) AND
								  (PC.PROGRAM_KEY IN('||cockey||') or -1 in ('||cockey||')) AND
								   PP.ENTRY_DATE <= TO_DATE('''||endDate||''',''YYYY-MM-DD'') AND
								   PP.EXIT_DATE >= TO_DATE('''||startDate||''',''YYYY-MM-DD''))a';
						   

	IF(INSTR(rowId,'Race') > 0) THEN
        innerQuery := innerQuery || queryRace;
	END IF;
						   
	IF(INSTR(rowId,'Gender') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryGender;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryGender;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Ethnicity') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryEthnicity;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryEthnicity;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Veteran') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryVeteran;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryVeteran;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'First Name') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryFname;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryFname;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Last Name') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryLname;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryLname;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Date Of Birth') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryDob;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryDob;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Physical Disability') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryPhyDis;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryPhyDis;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Domestic Violence') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryDomVio;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryDomVio;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Substance Abuse') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || querySubstnce;
        ELSE
            innerQuery := innerQuery || ' UNION ' || querySubstnce;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Mental Health') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryMntlHlth;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryMntlHlth;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Chronic Health Condition') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryChronic;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryChronic;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Entry') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryIncomeEntry;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryIncomeEntry;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Exit') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryIncomeExit;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryIncomeExit;
        END IF;
	END IF;
	
	IF(INSTR(rowId,'HIV AIDS') > 0) THEN					   
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryHIV;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryHIV;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Non-cash Benefits At Entry') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryNonCashEntry;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryNonCashEntry;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Non-cash Benefits At Exit') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryNonCashExit;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryNonCashExit;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Housing Status') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryHousingSts;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryHousingSts;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Zip Of Last Perm Address') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryZip;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryZip;
        END IF;
	END IF;
	
		IF(INSTR(rowId,'Residence Prior To Entry') > 0) THEN
		IF(innerQuery is null) THEN
            innerQuery := innerQuery || queryRes;
        ELSE
            innerQuery := innerQuery || ' UNION ' || queryRes;
        END IF;
	END IF;

	dbms_output.put_line('query : '||innerQuery);
	
	OPEN cur FOR innerQuery;
	
END;
/					

