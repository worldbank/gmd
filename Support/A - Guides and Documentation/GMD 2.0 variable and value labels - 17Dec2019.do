*******************************************************************************
* Program: GMD 2.0 variable and value labels - 17Dec2019.do
* This program defines variable and value labels for all variables in GMD 2.0.
* Optional code in Section 2 also checks if any of the required variables are 
* not present in your your GMD file.
* Date: December 17, 2019
*******************************************************************************

*******************************************************************************
* Section 1: List of all variables in GMD 2.0
*******************************************************************************

    loc IDN countrycode year int_year int_month hhid hhid_orig pid pid_orig
   
	loc COR spdef weight cpi weighttype cpiperiod ppp survey vermast ///
         veralt harmonization converfactor welfare welfarenom welfaredef ///
         welfaretype welfshprosperity welfshprtype welfareother ///
         welfareothertype hsize school literacy educy educat4 educat5 ///
         educat7 primarycomp
    
	loc GEO subnatid1 subnatid2 subnatid3 subnatid4 subnatidsurvey ///
        strata psu subnatid1_prev subnatid2_prev subnatid3_prev ///
        subnatid4_prev gaul_adm1_code gaul_adm2_code urban
    
	loc DEM language age agecat male relationharm relationcs marital ///
		eye_dsablty hear_dsablty walk_dsablty conc_dsord slfcre_dsablty ///
		comm_dsablty
	
	loc LBR minlaborage lstatus nlfreason unempldur_l unempldur_u empstat ///
		ocusec industry_orig industrycat10 industrycat4 occup_orig occup ///
		wage_nc unitwage whours wmonths wage_total contract healthins ///
		socialsec union firmsize_l firmsize_u empstat_2 ocusec_2 ///
		industry_orig_2 industrycat10_2 industrycat4_2 occup_orig_2 ///
		occup_2 wage_nc_2 unitwage_2 whours_2 wmonths_2 wage_total_2 ///
		firmsize_l_2 firmsize_u_2 t_hours_others t_wage_nc_others ///
		t_wage_others t_hours_total t_wage_nc_total t_wage_total ///
		minlaborage_year lstatus_year nlfreason_year unempldur_l_year ///
		unempldur_u_year empstat_year ocusec_year industry_orig_year ///
		industrycat10_year industrycat4_year occup_orig_year occup_year ///
		wage_nc_year unitwage_year whours_year wmonths_year wage_total_year ///
		contract_year healthins_year socialsec_year union_year ///
		firmsize_l_year firmsize_u_year empstat_2_year ocusec_2_year ///
		industry_orig_2_year industrycat10_2_year industrycat4_2_year ///
		occup_orig_2_year occup_2_year wage_nc_2_year unitwage_2_year ///
		whours_2_year wmonths_2_year wage_total_2_year firmsize_l_2_year ///
		firmsize_u_2_year t_hours_others_year t_wage_nc_others_year ///
		t_wage_others_year t_hours_total_year t_wage_nc_total_year ///
		t_wage_total_year njobs t_hours_annual linc_nc laborincome
	
	loc UTL water_source imp_wat_rec water_original watertype_quest piped ///
		piped_to_prem w_30m w_avail sanitation_source sanitation_original ///
		toilet_acc sewer open_def imp_san_rec waste central_acc heatsource ///
		gas cooksource lightsource elec_acc electricity elechr_acc electyp ///
		pwater_exp hwater_exp water_exp garbage_exp sewage_exp waste_exp  ///
		dwelothsvc_exp elec_exp ngas_exp  LPG_exp  gas_exp gasoline_exp ///
		diesel_exp kerosene_exp othliq_exp  liquid_exp wood_exp coal_exp ///
		peat_exp othsol_exp solid_exp  othfuel_exp central_exp heating_exp ///
		utl_exp dwelmat_exp dwelsvc_exp othhousing_exp transfuel_exp ///
		landphone_exp cellphone_exp tel_exp internet_exp telefax_exp ///
		comm_exp tv_exp tvintph_exp
	
	loc DWL landphone cellphone phone computer etablet internet radio ///
		tv tv_cable video fridge sewmach washmach stove ricecook fan ///
		ac ewpump bcycle mcycle oxcart boat car canoe roof wall floor ///
		kitchen bath rooms areaspace ybuilt ownhouse acqui_house dwelownlti ///
		fem_dwelownlti dwelownti selldwel transdwel ownland acqui_land ///
		doculand fem_doculand landownti sellland transland agriland ///
		area_agriland ownagriland area_ownagriland purch_agriland ///
		areapurch_agriland inher_agriland areainher_agriland ///
		rentout_agriland arearentout_agriland rentin_agriland ///
		arearentin_agriland docuagriland area_docuagriland fem_agrilandownti ///
		agrilandownti sellagriland transagriland dweltyp typlivqrt

	loc gmd_2_0_vars `IDN' `COR' `GEO' `DEM' `LBR' `UTL' `DWL'

    loc gmd_1_5_vars countrycode year weight cpi weighttype cpiperiod ppp ///
        survey vermast veralt harmonization converfactor strata psu ///
        urban hhid spdef subnatid1 subnatid2 subnatid3 gaul_adm1_code ///
        gaul_adm2_code gaul_adm3_code welfare welfarenom welfaredef ///
        welfaretype welfshprosperity welfshprtype welfareother ///
        welfareothertype hsize school literacy educy educat4 ///
        educat5 educat7 primarycomp pid age agecat male relationharm ///
        relationcs marital lstatus minlaborage empstat industrycat10 ///
        industrycat4 landphone cellphone computer electricity ///
        imp_wat_rec water_source water_original watertype_quest ///
        pipedwater_acc imp_san_rec sanitation_source sanitation_original toilet_acc
    
*******************************************************************************
* Section 2: This (optional) section checks if all GMD 2.0 variables are 
* present in your GMD upload file
*******************************************************************************
	local n_variables : word count `gmd_2_0_vars'
	local miss_var=""
	local j=0 
  
    * Identify variables missing from the dataset
    forval i=1/`n_variables' {
        capture confirm var  `:word `i' of `gmd_2_0_vars'', exact
        if c(rc) == 111 { // If a variable not found
            local this_name = "`:word `i' of `gmd_2_0_vars''"
            local miss_var="`miss_var'  `this_name'"
            local ++j
		}
		else if c(rc) != 0 { // Exit if some other error is found
            display in red "Unexpected error confirming "
		exit(111)
		}
    } //end of forval loop
    
    if `j'!=0{
            display in red "The following `j' variables are missing: `miss_var'" 
            exit 
    }		
    
*******************************************************************************
* Section 3: Variables labels 
*******************************************************************************
    lab var acqui_house "Acquisition of house"
    lab var acqui_land "Acquisition of residential land"
    lab var agriland "Agriculture Land"
    lab var agrilandownti "Type of ownership document for agricultural land"
    lab var ac "Ownership of a central or wall air conditioner"
    lab var area_agriland "Area of agriculture land used"
    lab var area_docuagriland "Area of documented agri land"
    lab var area_ownagriland "Area of agriculture land owned"
    lab var areainher_agriland "Area of inherited agriculture land"
    lab var areapurch_agriland "Area of purchased agriculture land"
    lab var arearentin_agriland "Area of rent in agri land"
    lab var arearentout_agriland "Area of rent out agri land"
    lab var areaspace "Area dwelling in square meters"
    lab var bath "Bathing facility in the dwelling"
    lab var bcycle "Ownership of a bicycle"
    lab var boat "Ownership of a boat"
    lab var canoe "Ownership of a canoe"
    lab var car "Ownership of a car"
    lab var cellphone "Ownership of a cell phone"
    lab var cellphone_exp "Total annual consumption of cell phone services"
    lab var central_acc "Access to central heating "
    lab var central_exp "Total annual consumption of central heating"
    lab var coal_exp "Total annual consumption of coal"
    lab var comm_exp "Total consumption of all telecommunication services "
    lab var computer "Ownership of a computer"
    lab var diesel_exp  "Total annual consumption of diesel"
    lab var docuagriland "Documented Agri Land"
    lab var doculand "Legal document for residential land"
    lab var dwelmat_exp "Total annual consumption of materials for the maintenance and repair of the dwelling"
    lab var dwelothsvc_exp "Total annual consumption of other services relating to the dwelling"
    lab var dwelownlti "Legal title for Ownership"
    lab var dwelownti "Type of Legal document"
    lab var dwelsvc_exp "Total annual consumption of services for the maintenance and repair of the dwelling"
    lab var dweltyp "Types of Dwelling"
    lab var elec_acc "Connection to electricity in dwelling"
    lab var elec_exp "Total annual consumption expenditures on electricity and other associated expenditures"
    lab var elechr_acc "Electricity availability (hr/day)"
    lab var electricity "Access to electricity in dwelling"
    lab var electyp "Type of lighting and/or electricity"
    lab var etablet "Ownership of a electronic tablet"
    lab var ewpump "Ownership of a electric water pump"
    lab var fan "Ownership of an electric fan"
    lab var fem_agrilandownti "Ownership Agri Land - Female"
    lab var fem_doculand "Legal document for residential land - female"
    lab var fem_dwelownlti "Legal title for Ownership - Female"
    lab var floor "Main material used for floor"
    lab var fridge "Ownership of a refrigerator"
    lab var cooksource "Main cooking fuel"
    lab var lightsource "Main source of lighting "
    lab var garbage_exp "Total annual consumption of garbage collection"
    lab var waste "Main types of solid waste disposal"
    lab var gas "Connection to gas/Usage of gas"
    lab var gas_exp "Total annual consumption of network/natural and liquefied gas"
    lab var gasoline_exp  "Total annual consumption of gasoline"
    lab var heating_exp "Total annual consumption of heating"
    lab var heatsource "Main source of heating "
    lab var hwater_exp "Total annual consumption of hot water supply"
    lab var imp_san_rec "Improved sanitation facility"
    lab var imp_wat_rec "Improved water"
    lab var inher_agriland "Inherit agriculture land"
    lab var internet "Access to internet"
    lab var internet_exp "Total consumption of internet services "
    lab var kerosene_exp "Total annual consumption of kerosene"
    lab var kitchen "Separate kitchen in the dwelling"
    lab var landownti "Type of land ownership title"
    lab var landphone "Ownership of a land phone"
    lab var landphone_exp "Total annual consumption of landline phone services"
    lab var liquid_exp "Total annual consumption of all liquid fuels"
    lab var LPG_exp  "Total annual consumption of liquefied gas"
    lab var mcycle "Ownership of a motorcycle"
    lab var ngas_exp  "Total annual consumption of network/natural gas"
    lab var open_def "Open defecation"
    lab var othfuel_exp "Total annual consumption of all other fuels"
    lab var othhousing_exp "Total annual consumption of other dwelling repair/maintenance"
    lab var othliq_exp  "Total annual consumption of other liquid fuels"
    lab var othsol_exp  "Total annual consumption of other solid fuels"
    lab var ownagriland "Ownership of agriculture land"
    lab var ownhouse "Ownership of house"
    lab var ownland "Ownership of land"
    lab var oxcart "Ownership of oxcart"
    lab var peat_exp  "Total annual consumption of peat"
    lab var phone "Ownership of a telephone"
    lab var piped  "Access to piped water"
    lab var piped_to_prem "Access to piped water on premises"
    lab var purch_agriland "Purchased agri land"
    lab var pwater_exp "Total annual consumption of water supply/piped water "
    lab var radio "Ownership of a radio"
    lab var rentin_agriland "Rent in Land"
    lab var rentout_agriland "Rent Out Land"
    lab var ricecook "Ownership of a rice cooker"
    lab var roof "Main material used for roof"
    lab var rooms "Number of habitable rooms"
    lab var sellagriland "Right to sell agri land"
    lab var selldwel "Right to sell dwelling"
    lab var sellland "Right to sell land"
    lab var sewage_exp "Total annual consumption of sewage collection"
    lab var sewer "Sewer"
    lab var sewmach "Ownership of a sewing machine"
    lab var solid_exp  "Total annual consumption of all solid fuels"
    lab var stove "Ownership of a stove"
    lab var tel_exp "Total consumption of all telephone services"
    lab var telefax_exp "Total consumption of telefax services "
    lab var tv "Ownership of a television"
    lab var tv_cable "Ownership of a cable television"
    lab var sanitation_source "Main sanitation facility "
    lab var sanitation_original "Original survey response for sanitation_source variable"
    lab var toilet_acc "Access to flushed toilet "
    lab var transagriland "Right to transfer agri land"
    lab var transdwel "Right to transfer dwelling"
    lab var transfuel_exp "Total annual consumption of fuels for personal transportation"
    lab var transland "Right to transfer land"
    lab var tv_exp "Total consumption of TV broadcasting services "
    lab var tvintph_exp "Total consumption of TV, internet and telephone "
    lab var typlivqrt "Types of living quarters"
    lab var utl_exp "Total annual consumption of all utilities excluding telecom and other housing"
    lab var video "Ownership of a video"
    lab var w_30m "Household has access to improved water within 30 minutes"
    lab var w_avail "Improved water is available when needed"
    lab var wall "Main material used for external walls"
    lab var washmach "Ownership of a washing machine"
    lab var waste_exp  "Total annual consumption of garbage and sewage collection"
    lab var water_exp "Total annual consumption of water supply and hot water"
    lab var water_source "Sources of drinking water (14 categories)"
    lab var water_original "Original survey response in string for water_source variable"
    lab var watertype_quest "Type of water questions used in the survey"
    lab var wood_exp "Total annual consumption of firewood"
    lab var ybuilt "Year the dwelling built"
    lab var agecat "Age of individual (categorical)"
    lab var age "Age of individual (continuous)"
    lab var school "Currently enrolled in or attending school"
    lab var comm_dsablty "Difficulty communicating"
    lab var conc_dsord "Difficulty remembering or concentrating"
    lab var educat4 "Highest level of education completed (4 categories)"
    lab var educat5 "Highest level of education completed (5 categories)"
    lab var educat7 "Highest level of education completed (7 categories)"
    lab var educy "Years of completed education"
    lab var eye_dsablty "Difficulty seeing"
    lab var hear_dsablty "Difficulty hearing"
    lab var language "Language"
    lab var literacy "Individual can read and write"
    lab var marital "Marital status"
    lab var pid "Personal identifier "
    lab var primarycomp "Primary school completion"
    lab var relationharm "Relationship to household head (6 categories)"
    lab var relationcs "Relationship to head of household country/region specific"
    lab var male "Sex of household member (male=1)"
    lab var slfcre_dsablty "Difficulty with self-care"
    lab var walk_dsablty "Difficulty walking or climbing steps"
    lab var contract "Contract (7-day ref period)"
    lab var contract_year "Contract (12-mon ref period)"
    lab var empstat "Employment status, primary job (7-day ref period)"
    lab var empstat_2 "Employment status, secondary job (7-day ref period)"
    lab var empstat_2_year "Employment status, secondary job (12-mon ref period)"
    lab var empstat_year "Employment status, primary job (12-mon ref period)"
    lab var firmsize_l "Firm size (lower bracket), primary job (7-day ref period)"
    lab var firmsize_l_2 "Firm size (lower bracket), secondary job (7-day ref period)"
    lab var firmsize_l_2_year "Firm size (lower bracket), secondary job (12-mon ref period)"
    lab var firmsize_l_year "Firm size (lower bracket), primary job (12-mon ref period)"
    lab var firmsize_u "Firm size (upper bracket), primary job (7-day ref period)"
    lab var firmsize_u_2 "Firm size (upper bracket), secondary job (7-day ref period)"
    lab var firmsize_u_2_year "Firm size (upper bracket), secondary job (12-mon ref period)"
    lab var firmsize_u_year "Firm size (upper bracket), primary job (12-mon ref period)"
    lab var healthins "Health insurance (7-day ref period)"
    lab var healthins_year "Health insurance (12-mon ref period)"
    lab var industry_orig "Original industry code, primary job (7-day ref period)"
    lab var industry_orig_2 "Original industry code, secondary job (7-day ref period)"
    lab var industry_orig_2_year "Original industry code, secondary job (12-mon ref period)"
    lab var industry_orig_year "Original industry code, primary job (12-mon ref period)"
    lab var industrycat10 "1 digit industry classification, primary job (7-day ref period)"
    lab var industrycat10_2 "1 digit industry classification, secondary job (7-day ref period)"
    lab var industrycat10_2_year "1 digit industry classification, secondary job (12-mon ref period)"
    lab var industrycat10_year "1 digit industry classification, primary job (12-mon ref period)"
    lab var industrycat4 "4-category industry classification, primary job (7-day ref period)"
    lab var industrycat4_2 "4-category industry classification, secondary job (7-day ref period)"
    lab var industrycat4_2_year "4-category industry classification, secondary job (12-mon ref period)"
    lab var industrycat4_year "4-category industry classification, primary job (12-mon ref period)"
    lab var laborincome "Total annual individual labor income in all jobs, incl. bonuses, etc. "
    lab var linc_nc "Total annual wage income in all jobs, excl. bonuses, etc. "
    lab var lstatus "Labor status (7-day ref period)"
    lab var lstatus_year "Labor status (12-mon ref period)"
    lab var minlaborage "Labor module application age (7-day ref period)"
    lab var minlaborage_year "Labor module application age (12-mon ref period)"
    lab var njobs "Total number of jobs"
    lab var nlfreason "Reason not in the labor force (7-day ref period)"
    lab var nlfreason_year "Reason not in the labor force (12-mon ref period)"
    lab var occup "1 digit occupational classification, primary job (7-day ref period)"
    lab var occup_2 "1 digit occupational classification, secondary job (7-day ref period)"
    lab var occup_2_year "1 digit occupational classification, secondary job (12-mon ref period)"
    lab var occup_orig "Original occupational classification, primary job (7-day ref period)"
    lab var occup_orig_2 "Original occupational classification, secondary job (7-day ref period)"
    lab var occup_orig_2_year "Original occupational classification, secondary job (12-mon ref period)"
    lab var occup_orig_year "Original occupational classification, primary job (12-mon ref period)"
    lab var occup_year "1 digit occupational classification, primary job (12-mon ref period)"
    lab var ocusec "Sector of activity, primary job (7-day ref period)"
    lab var ocusec_2 "Sector of activity, secondary job (7-day ref period)"
    lab var ocusec_2_year "Sector of activity, secondary job (12-mon ref period)"
    lab var ocusec_year "Sector of activity, primary job (12-mon ref period)"
    lab var socialsec "Social security (7-day ref period)"
    lab var socialsec_year "Social security (12-mon ref period)"
    lab var t_hours_annual "Total hours worked in all jobs in the previous 12 months"
    lab var t_hours_others "Annualized hours worked in all but primary and secondary jobs (7-day ref period)"
    lab var t_hours_others_year "Annualized hours worked in all but primary and secondary jobs (12-mon ref period)"
    lab var t_hours_total "Annualized hours worked in all jobs (7-day ref period)"
    lab var t_hours_total_year "Annualized hours worked in all jobs (12-mon ref period)"
    lab var t_wage_nc_others "Annualized wage in all but primary & secondary jobs excl. bonuses, etc. (7-day ref period)"
    lab var t_wage_nc_others_year "Annualized wage in all but primary & secondary jobs excl. bonuses, etc. (12-mon ref period)"
    lab var t_wage_nc_total "Annualized wage in all jobs excl. bonuses, etc. (7-day ref period)"
    lab var t_wage_nc_total_year "Annualized wage in all jobs excl. bonuses, etc. (12-mon ref period)"
    lab var t_wage_others "Annualized wage in all but primary and secondary jobs (7-day ref period)"
    lab var t_wage_others_year "Annualized wage in all but primary and secondary jobs (12-mon ref period)"
    lab var t_wage_total "Annualized total wage for all jobs (7-day ref period)"
    lab var t_wage_total_year "Annualized total wage for all jobs (12-mon ref period)"
    lab var unempldur_l "Unemployment duration (months) lower bracket (7-day ref period)"
    lab var unempldur_l_year "Unemployment duration (months) lower bracket (12-mon ref period)"
    lab var unempldur_u "Unemployment duration (months) upper bracket (7-day ref period)"
    lab var unempldur_u_year "Unemployment duration (months) upper bracket (12-mon ref period)"
    lab var union "Union membership (7-day ref period)"
    lab var union_year "Union membership (12-mon ref period)"
    lab var unitwage "Time unit of last wages payment, primary job (7-day ref period)"
    lab var unitwage_2 "Time unit of last wages payment, secondary job (7-day ref period)"
    lab var unitwage_2_year "Time unit of last wages payment, secondary job (12-mon ref period)"
    lab var unitwage_year "Time unit of last wages payment, primary job (12-mon ref period)"
    lab var wage_nc "Wage payment, primary job, excl. bonuses, etc. (7-day ref period)"
    lab var wage_nc_2 "Wage payment, secondary job, excl. bonuses, etc. (7-day ref period)"
    lab var wage_nc_2_year "Wage payment, secondary job, excl. bonuses, etc. (12-mon ref period)"
    lab var wage_nc_year "Wage payment, primary job, excl. bonuses, etc. (12-mon ref period)"
    lab var wage_total "Annualized total wage, primary job (7-day ref period)"
    lab var wage_total_2 "Annualized total wage, secondary job (7-day ref period)"
    lab var wage_total_2_year "Annualized total wage, secondary job (12-mon ref period)"
    lab var wage_total_year "Annualized total wage, primary job (12-mon ref period)"
    lab var whours "Hours of work in last week, primary job (7-day ref period)"
    lab var whours_2 "Hours of work in last week, secondary job (7-day ref period)"
    lab var whours_2_year "Hours of work in last week, secondary job (12-mon ref period)"
    lab var whours_year "Hours of work in last week, primary job (12-mon ref period)"
    lab var wmonths "Months worked in the last 12 months, primary job (7-day ref period)"
    lab var wmonths_2 "Months worked in the last 12 months, secondary job (7-day ref period)"
    lab var wmonths_2_year "Months worked in the last 12 months, secondary job (12-mon ref period)"
    lab var wmonths_year "Months worked in the last 12 months, primary job (12-mon ref period)"
    lab var psu "Primary Sampling Unit"
    lab var converfactor "Conversion factor"
    lab var countrycode "country code"
    lab var gaul_adm1_code "GAUL code for admin1 level"
    lab var gaul_adm2_code "GAUL code for admin2 level"
    lab var harmonization "Type of harmonization"
    lab var hsize "Household size"
    lab var hhid "Household identifier "
    lab var int_month "interview month"
    lab var int_year "interview year"
    lab var subnatid1 "Subnational ID - highest level"
    lab var subnatid1_prev "Subnational ID of most recent previous survey – highest level"
    lab var subnatid2 "Subnational ID - second highest level"
    lab var subnatid2_prev "Subnational ID of most recent previous survey – second highest level"
    lab var subnatid3 "Subnational ID - third highest level"
    lab var subnatid3_prev "Subnational ID of most recent previous survey – third highest level"
    lab var subnatid4 "Subnational ID - lowest level"
    lab var subnatid4_prev "Subnational ID of most recent previous survey – fourth highest level"
    lab var urban "Urban (1) or rural (0)"
    lab var spdef "Spatial deflator (if one is used)"
    lab var strata "Strata"
    lab var subnatidsurvey "Survey representation of geographical units"
    lab var survey "Type of survey"
    lab var welfareother "Welfare aggregate if different welfare type is used from welfare, welfarenom, welfaredef"
    lab var welfareothertype "Type of welfare measure (income, consumption or expenditure) for welfareother"
    lab var welfare "Welfare aggregate used for estimating international poverty (provided to PovcalNet)"
    lab var welfaredef "Welfare aggregate spatially deflated"
    lab var welfarenom "Welfare aggregate in nominal terms"
    lab var welfshprosperity "Welfare aggregate for shared prosperity (if different from poverty)"
    lab var welfshprtype "Welfare type for shared prosperity indicator (income, consumption or expenditure)"
    lab var welfaretype "Type of welfare measure (income, consumption or expenditure) for welfare, welfarenom, welfaredef"
    lab var weight "Household weight"
    lab var year "4-digit year of survey based on IHSN standards"
    lab var pid_orig "Personal identifier in the raw data "
    lab var hhid_orig "Household identifier in the raw data "
    lab var cpi "CPI ratio value of survey (rebased to 2005 on base 1)"
    lab var cpiperiod "Periodicity of CPI (year, year&month, year&quarter, weighted)"
    lab var ppp "PPP conversion factor"
    lab var veralt "Version number of adaptation to the master data file"
    lab var vermast "Version number of master data file"
    lab var weighttype "Weight type (frequency, probability, analytical, importance)"
	
*******************************************************************************
* Section 4: Value labels 
*******************************************************************************

	* Define value labels
        lab def acqui_house 1  "Purchased"  2  "Inherited"  3 "Other", replace
        lab def acqui_land 1  "Purchased"  2  "Inherited"  3 "Other", replace
        lab def agriland 1 "Yes"  0 "No", replace
        lab def agrilandownti 1  "Title; deed" 2  "Leasehold (govt issued)"  3  "Customary land certificate/plot level" 4 "Customary based / group right"  5  "Cooperative"  6  "Other", replace
        lab def ac 1 "Yes"  0 "No", replace
        lab def bath 1 "Yes"  0 "No", replace
        lab def bcycle 1 "Yes"  0 "No", replace
        lab def boat 1 "Yes"  0 "No", replace
        lab def canoe 1 "Yes"  0 "No", replace
        lab def car 1 "Yes"  0 "No", replace
        lab def cellphone 1 "Yes"  0 "No", replace
        lab def central_acc 1 "Yes"  0 "No", replace
        lab def computer 1 "Yes"  0 "No", replace
        lab def docuagriland 1 "Yes"  0 "No", replace
        lab def doculand 1 "Yes"  0 "No", replace
        lab def dwelownlti 1 "Yes"  0 "No", replace
        lab def dwelownti 1 "Title, deed, freehold"  2 "Government issued leasehold" 3  "Occupancy certificate – govt issued" 4 "legal document in the name of group (community; cooperative)" 5 "condominium (apartment)" 6 "Other", replace
        lab def dweltyp 1 "Detached house" 2 "Multi-family house" 3 "Separate apartment" 4 "Communal apartment" 5 "Room in a larger dwelling" 6 "Several buildings connected" 7 "Several separate buildings" 8 "Improvised housing unit" 9 "Other", replace
        lab def elec_acc 1 "Yes, public/quasi-public" 2  " Yes, private" 3  "Yes, source unstated" 4  "No", replace
        lab def electricity 1 "Yes"  0 "No", replace
        lab def electyp 1  "Electricity" 2  "Gas"  3  "Lamp"  4  "Others" 10 "No cook and light source", replace
        lab def etablet 1 "Yes"  0 "No", replace
        lab def ewpump 1 "Yes"  0 "No", replace
        lab def fan 1 "Yes"  0 "No", replace
        lab def fem_agrilandownti 1 "Yes"  0 "No", replace
        lab def fem_doculand 1 "Yes"  0 "No", replace
        lab def fem_dwelownlti 1 "Yes"  0 "No", replace
        lab def floor 1  "Natural – Earth/sand"   2  "Natural – Dung" 3  "Natural –¬ Other"  4  "Rudimentary –¬ Wood planks"  5 "Rudimentary –¬ Palm/bamboo"    6"Rudimentary – Other"  7 "Finished – Parquet or polished wood"  8 "Finished – Vinyl or asphalt strips" 9  "Finished – Ceramic/marble/granite"   10   "Finished – Floor tiles/teraso"  11  "Finished – Cement/red bricks"  12  "Finished – Carpet" 13  "Finished – Other" 14  "Other – Specific", replace
        lab def fridge 1 "Yes"  0 "No", replace
        lab def cooksource  1  "Firewood"  2  "Kerosene"  3  "Charcoal"  4  "Electricity"  5  "Gas"  9  "Other" 10 "No cook source", replace
        lab def lightsource 1 "Electricity" 2 "Kerosene" 3 "Candles" 4 "Gas" 9 "Other" 10 "No cook and light source", replace
        lab def waste 1 "Solid waste collected on a regular basis by authorized collectors" 2 "Solid waste collected on an irregular basis by authorized collectors" 3 "Solid waste collected by self‐appointed collectors" 4 "Occupants dispose of solid waste in a local dump supervised by authorities" 5 "Occupants dispose of solid waste in a local dump not supervised by authorities" 6 "Occupants burn solid waste" 7 "Occupants bury solid waste" 8 "Occupants dispose solid waste into river, sea, creek, pond" 9 "Occupants compost solid waste" 10 "Other arrangement", replace
        lab def gas 0 "No" 1 "Yes, piped gas (LNG)" 2 "Yes, bottled gas (LPG)" 3 "Yes, but don't know", replace
        lab def heatsource 1 "Firewood"  2 "Kerosene" 3 "Charcoal" 4 "Electricity" 5 "Gas" 6 "Central" 9 "Other" 10 "No heating", replace
        lab def imp_san_rec 1 "Yes"  0 "No", replace
        lab def imp_wat_rec 1 "Yes"  0 "No", replace
        lab def inher_agriland 1 "Yes"  0 "No", replace
        lab def internet 1  "Subscribed in the house"  2  "Accessible outside the house"  3  " Either" 4  "No internet", replace
        lab def kitchen 1 "Yes"  0 "No", replace
        lab def landownti 1  "Title; deed"  2  "leasehold (govt issued)"  3  "Customary land certificate/plot level"  4   "Customary based/group right"   5  "Cooperative group right"   6  "Other", replace
        lab def landphone 1 "Yes"  0 "No", replace
        lab def mcycle 1 "Yes"  0 "No", replace
        lab def open_def 0 "availability of any facility"   1 "no facility, or bush, or field", replace
        lab def ownagriland 1 "Yes"  0 "No", replace
        lab def ownhouse 1 "Ownership/secure rights"  2 "Renting" 3 "Provided for free" 4 "Without permission", replace
        lab def ownland 1 "Yes"  0 "No", replace
        lab def oxcart 1 "Yes"  0 "No", replace
        lab def phone 1 "Yes"  0 "No", replace
        lab def piped  1 "Yes"  0 "No", replace
        lab def piped_to_prem 1 "Yes"  0 "No", replace
        lab def purch_agriland 1 "Yes"  0 "No", replace
        lab def radio 1 "Yes"  0 "No", replace
        lab def rentin_agriland 1 "Yes"  0 "No", replace
        lab def rentout_agriland 1 "Yes"  0 "No", replace
        lab def ricecook 1 "Yes"  0 "No", replace
        lab def roof 1 "Natural – Thatch/palm leaf" 2  "Natural – Sod"  3  "Natural – Other"  4  "Rudimentary – Rustic mat"  5 "Rudimentary – Palm/bamboo" 6  "Rudimentary – Wood planks"  7 "Rudimentary – Other"  8  "Finished – Roofing"  9  "Finished – Asbestos" 10     "Finished – Tile" 11  "Finished – Concrete" 12  "Finished – Metal tile" 13  "Finished – Roofing shingles" 14  "Finished – Other" 15  "Other – Specific", replace
        lab def sellagriland 1 "Yes"  0 "No", replace
        lab def selldwel 1 "Yes"  0 "No", replace
        lab def sellland 1 "Yes"  0 "No", replace
        lab def sewer 0 "No"   1  "flush/pour flush to piped sewer system" , replace
        lab def sewmach 1 "Yes"  0 "No", replace
        lab def stove 1 "Yes"  0 "No", replace
        lab def tv 1 "Yes"  0 "No", replace
        lab def tv_cable 1 "Yes"  0 "No", replace
        lab def sanitation_source 1 "A flush toilet"  2 "A piped sewer system"  3 "A septic tank"  4 "Pit latrine" 5 "Ventilated improved pit latrine (VIP)"  6 "Pit latrine with slab"  7 "Composting toilet" 8 "Special case"  9 "A flush/pour flush to elsewhere"  10 "A pit latrine without slab" 11 "Bucket"  12 "Hanging toilet or hanging latrine"  13 "No facilities or bush or field"  14 "Other", replace
        lab def toilet_acc 0 "No"  1 "Yes, in premise"  2 "Yes, but not in premise including public toilet" 3 "Yes, unstated whether in or outside premise", replace
        lab def transagriland 1 "Yes"  0 "No", replace
        lab def transdwel 1 "Yes"  0 "No", replace
        lab def transland 1 "Yes"  0 "No", replace
        lab def typlivqrt 1 "Housing units, conventional dwelling with basic facilities" 2 "Housing units, conventional dwelling without basic facilities" 3 "Other", replace
        lab def video 1 "Yes"  0 "No", replace
        lab def w_30m 1 "Collection time of imp_wat_rec less than or equal to 30 mins" 0 "Collection time of imp_wat_rec more than 30 mins", replace
        lab def w_avail 1 "water is available continuously, reliable source" 0  "water source is unreliable", replace
        lab def wall 1  "Natural – Cane/palm/trunks" 2  "Natural – Dirt" 3  "Natural – Other" 4 "Rudimentary – Bamboo with mud" 5  "Rudimentary – Stone with mud"  6  "Rudimentary – Uncovered adobe" 7  "Rudimentary – Plywood" 8  "Rudimentary – Cardboard" 9  "Rudimentary – Reused wood"  10  "Rudimentary – Other"  11  "Finished – Woven Bamboo"12  "Finished – Stone with lime/cement" 13  "Finished – Cement blocks"14  "Finished – Covered adobe"  15  "Finished – Wood planks/shingles"  16 "Finished – Plaster wire" 17  "Finished – GRC/Gypsum/Asbestos" 18  "Finished – Other " 19 "Other", replace
        lab def washmach 1 "Yes"  0 "No", replace
        lab def water_source 1 "Piped water into dwelling"  2 "Piped water to yard/plot"  3 "Public tap or standpipe" 4 "Tube well or borehole"  5 "Protected dug well"  6 "Protected spring"  7 "Bottled water" 8 "Rainwater"  9 "Unprotected spring"  10 "Unprotected dug well"  11 "Cart with small tank/drum" 12 "Tanker-truck"  13 "Surface water"  14 "Other", replace
        lab def watertype_quest 1 "Drinking water"  2 "General water"  3 "Both"  4 "Other", replace
        lab def school 1 "Yes"  0 "No", replace
        lab def comm_dsablty 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def conc_dsord 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def educat4 1 "No education"  2 "Primary (complete or incomplete)"  3 "Secondary (complete or incomplete)" 4 "Tertiary (complete or incomplete)", replace
        lab def educat5 1 "No education"  2 "Primary incomplete"  3 "Primary complete but Secondary incomplete" 4 "Secondary complete"  5 "Tertiary (completed or incomplete)", replace
        lab def educat7 1 "No education"  2 "Primary incomplete"  3 "Primary complete"  4 "Secondary incomplete"  5 "Secondary complete"  6 "Post secondary but not university"  7 "University", replace
        lab def eye_dsablty 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def hear_dsablty 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def literacy 1 " Yes, can read and write"  0  " No, cannot read or write" , replace
        lab def marital 1 "Married"  2 "Never married"  3 "Living together" 4 "Divorced/Separated"  5 "Widowed", replace
        lab def primarycomp 1 "Yes"  0 "No", replace
        lab def relationharm 1 "Head" 2 "Spouse" 3 "Child" 4 "Parents" 5 "Other relative" 6 "Non-relative", replace
        lab def male 1  " Male"  0  "Female", replace
        lab def slfcre_dsablty 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def walk_dsablty 1  "No – no difficulty"  2  "Yes – some difficulty"  3  "Yes – a lot of difficulty"  4  "Cannot do at all", replace
        lab def contract 1 "Yes"  0 "No", replace
        lab def contract_year  1 "No"  1 "Yes", replace
        lab def empstat 1 "Paid Employee"  2 "Non-Paid Employee"  3 "Employer"  4 "Self-employed" 5 "Other, workers not classifiable by status", replace
        lab def empstat_2 1 "Paid Employee"  2 "Non-Paid Employee"  3 "Employer"  4 "Self-employed" 5 "Other, workers not classifiable by status", replace
        lab def empstat_2_year 1 "Paid Employee"  2 "Non-Paid Employee"  3 "Employer"  4 "Self-employed" 5 "Other, workers not classifiable by status", replace
        lab def empstat_year 1 "Paid Employee"  2 "Non-Paid Employee"  3 "Employer"  4 "Self-employed" 5 "Other, workers not classifiable by status", replace
        lab def healthins 1 "Yes"  0 "No", replace
        lab def healthins_year 1 "Yes"  0 "No", replace
        lab def industrycat10 1 "Agriculture, Hunting, Fishing, etc." 2 "Mining" 3 "Manufacturing"  4 "Public Utility Services"  5 "Construction"  6 "Commerce" 7 "Transport and Communications" 8 "Financial and Business Services"  9 "Public Administration"  10 "Others Services, Unspecified", replace
        lab def industrycat10_2 1 "Agriculture, Hunting, Fishing, etc." 2 "Mining" 3 "Manufacturing"  4 "Public Utility Services"  5 "Construction"  6 "Commerce" 7 "Transport and Communications" 8 "Financial and Business Services"  9 "Public Administration"  10 "Others Services, Unspecified", replace
        lab def industrycat10_2_year 1 "Agriculture, Hunting, Fishing, etc." 2 "Mining" 3 "Manufacturing"  4 "Public Utility Services"  5 "Construction"  6 "Commerce" 7 "Transport and Communications" 8 "Financial and Business Services"  9 "Public Administration"  10 "Others Services, Unspecified", replace
        lab def industrycat10_year 1 "Agriculture, Hunting, Fishing, etc." 2 "Mining" 3 "Manufacturing"  4 "Public Utility Services"  5 "Construction"  6 "Commerce" 7 "Transport and Communications" 8 "Financial and Business Services"  9 "Public Administration"  10 "Others Services, Unspecified", replace
        lab def industrycat4 1 "Agriculture" 2 "Industry" 3 "Services" 4 "Other", replace
        lab def industrycat4_2 1 "Agriculture" 2 "Industry" 3 "Services" 4 "Other", replace
        lab def industrycat4_2_year 1 "Agriculture" 2 "Industry" 3 "Services" 4 "Other", replace
        lab def industrycat4_year 1 "Agriculture" 2 "Industry" 3 "Services" 4 "Other", replace
        lab def lstatus 1 "Employed"  2 "Unemployed"  3 "Not in labor force", replace
        lab def lstatus_year 1 "Employed"  2 "Unemployed"  3 "Not in labor force", replace
        lab def nlfreason 1 "Student"  2 "Housewife"  3 "Retired"  4 "Disabled" 5"Others", replace
        lab def nlfreason_year 1 "Student"  2 "Housewife"  3 "Retired"  4 "Disabled" 5"Others", replace
        lab def occup 1 "Managers"  2  "Professionals"  3  "Technicians and associate professionals"  4  "Clerical support workers"  5 "Service and sales workers" 6 "Skilled agricultural, forestry and fishery workers" 7  "Craft and related trades workers" 8  "Plant and machine operators, and assemblers" 9 "Elementary occupations" 10  "Armed forces occupations" 99 "Other/unspecified", replace
        lab def occup_2 1 "Managers"  2  "Professionals"  3  "Technicians and associate professionals"  4  "Clerical support workers"  5 "Service and sales workers" 6 "Skilled agricultural, forestry and fishery workers" 7  "Craft and related trades workers" 8  "Plant and machine operators, and assemblers" 9 "Elementary occupations" 10  "Armed forces occupations" 99 "Other/unspecified", replace
        lab def occup_2_year 1 "Managers"  2  "Professionals"  3  "Technicians and associate professionals"  4  "Clerical support workers"  5 "Service and sales workers" 6 "Skilled agricultural, forestry and fishery workers" 7  "Craft and related trades workers" 8  "Plant and machine operators, and assemblers" 9 "Elementary occupations" 10  "Armed forces occupations" 99 "Other/unspecified", replace
        lab def occup_year 1 "Managers"  2  "Professionals"  3  "Technicians and associate professionals"  4  "Clerical support workers"  5 "Service and sales workers" 6 "Skilled agricultural, forestry and fishery workers" 7  "Craft and related trades workers" 8  "Plant and machine operators, and assemblers" 9 "Elementary occupations" 10  "Armed forces occupations" 99 "Other/unspecified", replace
        lab def ocusec 1 "Public sector, Central Government, Army" 2 "Private, NGO" 3 "State owned" 4 "Public or State-owned, but cannot distinguish", replace
        lab def ocusec_2 1 "Public sector, Central Government, Army" 2 "Private, NGO" 3 "State owned" 4 "Public or State-owned, but cannot distinguish", replace
        lab def ocusec_2_year 1 "Public sector, Central Government, Army" 2 "Private, NGO" 3 "State owned" 4 "Public or State-owned, but cannot distinguish", replace
        lab def ocusec_year 1 "Public sector, Central Government, Army" 2 "Private, NGO" 3 "State owned" 4 "Public or State-owned, but cannot distinguish", replace
        lab def socialsec 1 "Yes"  0 "No", replace
        lab def socialsec_year 1 "Yes"  0 "No", replace
        lab def union 1 "Yes"  0 "No", replace
        lab def union_year 1 "Yes"  0 "No", replace
        lab def unitwage 1  "Daily"  2 "Weekly"  3 "Every two weeks"  4 "Every two months" 5 "Monthly"  6 "Quarterly" 7 "Every six months" 8 "Annually" 9 "Hourly"  10 "Other", replace
        lab def unitwage_2 1 "Daily"  2 "Weekly"  3 "Every two weeks"  4 "Every two months" 5 "Monthly"  6 "Quarterly" 7 "Every six months" 8 "Annually" 9 "Hourly"  10 "Other", replace
        lab def unitwage_2_year 1 "Daily"  2 "Weekly"  3 "Every two weeks"  4 "Every two months" 5 "Monthly"  6 "Quarterly" 7 "Every six months" 8 "Annually" 9 "Hourly"  10 "Other", replace
        lab def unitwage_year 1 "Daily"  2 "Weekly"  3 "Every two weeks"  4 "Every two months" 5 "Monthly"  6 "Quarterly" 7 "Every six months" 8 "Annually" 9 "Hourly"  10 "Other", replace
        lab def int_month 1 "January" 2 "February" 3 "March" 4 "April" 5 "May" 6 "June" 7 "July" 8 "August" 9 "September" 10 "October" 11 "November" 12 "December", replace
        lab def urban 0 "Rural" 1 "Urban" , replace
		
	* Assign value labels 
        local vars int_month school literacy educat4 educat5 educat7 primarycomp ///
	urban male relationharm marital eye_dsablty hear_dsablty walk_dsablty ///
	conc_dsord slfcre_dsablty comm_dsablty lstatus nlfreason empstat ocusec ///
	industrycat10 industrycat4 occup unitwage contract healthins socialsec ///
	union empstat_2 ocusec_2 industrycat10_2 industrycat4_2 occup_2 unitwage_2 ///
	lstatus_year nlfreason_year empstat_year ocusec_year industrycat10_year ///
	industrycat4_year occup_year unitwage_year contract_year healthins_year ///
	socialsec_year union_year empstat_2_year ocusec_2_year industrycat10_2_year ///
	industrycat4_2_year occup_2_year unitwage_2_year water_source imp_wat_rec ///
	watertype_quest piped piped_to_prem w_30m w_avail sanitation_source ///
	toilet_acc sewer open_def imp_san_rec waste central_acc heatsource gas ///
	cooksource lightsource elec_acc electricity electyp landphone cellphone ///
	phone computer etablet internet radio tv tv_cable video fridge sewmach ///
	washmach stove ricecook fan ac ewpump bcycle mcycle oxcart boat car canoe ///
	roof wall floor kitchen bath ownhouse acqui_house dwelownlti fem_dwelownlti ///
	dwelownti selldwel transdwel ownland acqui_land doculand fem_doculand ///
	landownti sellland transland agriland ownagriland purch_agriland ///
	inher_agriland rentout_agriland rentin_agriland docuagriland ///
	fem_agrilandownti agrilandownti sellagriland transagriland dweltyp typlivqrt

	foreach var of varlist `vars' {
        lab val `var' `var'	
	}

*******************************************************************************
* Section 5: Clean up
*******************************************************************************
    sort hhid pid
	keep  `gmd_2_0_vars'
	order `gmd_2_0_vars'
