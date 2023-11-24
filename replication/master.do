drop _all
set memory 1g

run "C:\Users\fernando.greve\Dropbox\WP1\1.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\2.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\3.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\4.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\5.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\6_manufactura.do"
drop _all
run "C:\Users\fernando.greve\Dropbox\WP1\7.do"
drop _all

import excel using "C:\Users\fernando.greve\Dropbox\WP1\dolar.xlsx" , ///
sheet(ExportCuadro) cellrange(A3) firstrow clear
*gen Año = Ao
gen Dolar =  DlarObservadopesospord
gen Dolar_ajustado = Dolar/7
gen TCR =  ndicedetipodecambioreal
save "C:\Users\fernando.greve\Dropbox\WP1\dolar.dta", replace

use "C:\Users\fernando.greve\Dropbox\23-12-2012\1\1.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\2\2.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\3\3.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\4\4.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\5\5.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6_manufactura.dta"
append using "C:\Users\fernando.greve\Dropbox\23-12-2012\7\7.dta"

drop if manufactura_dummy==0 

gen ln_l    = ln(l)
gen ln_L    = ln(L)
gen ln_exp  = ln(exp)
gen ln_EXP  = ln(EXP)
gen ln_lic    = ln(lic)
gen ln_g  = ln(g)
gen ln_G  = ln(G)
gen ln_v  = ln(v)
gen ln_V  = ln(V)
gen vl  = v/l
gen VL  = V/L
gen ln_vl  = ln(vl)
gen ln_VL  = ln(VL)
gen ln_k  = ln(k)
gen ln_K  = ln(K)
gen gl  = g/l
gen GL  = G/L
gen ln_gl  = ln(gl)
gen ln_GL  = ln(GL)
gen gv  = g/v
gen GV  = G/V
gen ev = exp/v
gen EV = EXP/V
gen ln_ev = ln(ev)
gen ln_EV = ln(EV)
gen coop = inst_publicos_dummy + universidades_dummy
replace coop = 1 if coop==2
replace coop = 0 if coop==.
gen G_mil = G/1000 
gen EXP_mil = EXP/1000

gen Alimentos = sector_1
gen Textil = sector_2 
gen Madera = sector_3 
gen Papel = sector_4 
gen Quimica = sector_5 
gen Min_y_Metb = sector_6 + sector_7
gen MetalMecanica = sector_8

gen Subsector2=.
replace Subsector2=1 if sector_1==1
replace Subsector2=2 if sector_2==1
replace Subsector2=3 if sector_3==1
replace Subsector2=4 if sector_4==1
replace Subsector2=5 if sector_5==1
replace Subsector2=6 if sector_6==1 | sector_7==1
replace Subsector2=7 if sector_8==1

recode Subsector2 ///
(1 = 1 "Alimentos") ///
(2 = 2 "Textil") ///
(3 = 3 "Madera") ///
(4 = 4 "Papel") ///
(5 = 5 "Quimica") ///
(6 = 6 "Min-Metb") ///
(7 = 7 "M-M"), ///
gen(Subsector) 


gen enc_1 = 0
gen enc_2 = 0
gen enc_3 = 0
gen enc_4 = 0
gen enc_5 = 0
gen enc_6 = 0
gen enc_7 = 0

replace enc_1=1 if encuesta==1
replace enc_2=1 if encuesta==2
replace enc_3=1 if encuesta==3
replace enc_4=1 if encuesta==4
replace enc_5=1 if encuesta==5
replace enc_6=1 if encuesta==6
replace enc_7=1 if encuesta==7

recode encuesta ///
(1 = 1 "1995") ///
(2 = 2 "1998") ///
(3 = 3 "2000") ///
(4 = 4 "2004") ///
(5 = 5 "2006") ///
(6 = 6 "2008") ///
(7 = 7 "2010"), ///
gen(Año) 

*drop if trabajo_93==0 | trabajo_94==0 | trabajo_95==0 | trabajo_97==0 | empleados_99==0 | empleados_00==0 | empleados_03==0 | empleados_04==0 | empleados_05==0 | empleados_06==0 | empleados_07==0 | empleados_08==0
*drop if V==0 | v==0
*drop if empleados_03>10000 & encuesta==4

*drop if l==. | l>6000 | l<10
*drop if L==. | L>6000 | L<10
*drop if trabajo_96==. & encuesta==2 
*drop if trabajo_96>6000 & encuesta==2 
*drop if trabajo_96<10 & encuesta==2

************ labels **************************************************
label variable exp           "Export"  
label variable ln_exp        "Export (log)"  

label variable EXP           "Export"
label variable ln_EXP        "Export (log)"

label variable exp `"Export"'

label variable Alimentos 	 `"Alimentos"'
label variable Textil 		 `"Textil"'
label variable Madera 		 `"Madera"'
label variable Papel 		 `"Papel"'
label variable Quimica 		 `"Quimica"'
label variable Min_y_Metb 	 `"Minerales no-Metalicos  y Metales básicos"'
label variable MetalMecanica `"Metal-mecanica"'

label variable GD                   "Gasto.Innov(d)"  
label variable gD                   "Gasto.Innov(d)"
label variable l                    "Empleo" 
label variable L                    "Empleo"  
label variable ln_l                 "Empleo (log)" 
label variable ln_L                 "Empleo (log)"   
label variable ln_exp               "Export" 
label variable expD                 "Export(d)" 
label variable k_ext                "Prop.Extranj(d)"
label variable ln_lic               "Adq.Licencias (log)"
label variable licD          	    "Adq.Licencias(d)"
label variable EXPD        		    "Export(d)"
label variable ln_EXP          		"Export (log)"
label variable inn          		"Innov.prod/proc(d)"
label variable prod         		"Innov.prod(d)"
label variable proc         		"Innov.proc(d)"
label variable ln_g            		"Gasto.Innov (log)" 
label variable ln_G        			"Gasto.Innov (log)" 
label variable fin         		    "fin.publico(d)"
label variable ln_vl           		"Prod.laboral (log)"
label variable ln_VL           		"Prod.laboral (log)"
label variable vl           		"Prod.laboral"
label variable VL           		"Prod.laboral"
label variable ln_v            		"ventas (log)"
label variable ln_V                 "ventas (log)"
label variable universidades_dummy  "coop.univ(d)"
label variable inst_publicos_dummy  "coop.inst.public(d)"
label variable G_mil 				"Gasto.Innov"
label variable EXP_mil 				"Export"
label variable GL 					"Esfuerzo innov."
label variable gl 					"Esfuerzo innovacion"
label variable EV 					"Intensidad export"
label variable ev 					"Intensidad export"


label variable ln_gl "Gasto.Innov por trab (log)"

global encuesta "enc_1 enc_2 enc_3 enc_4 enc_5 enc_6 enc_7"
global sector "Alimentos Textil Madera Papel Quimica Min_y_Metb"

***************************************************************************************************************************
///EST.DESCRIPTIVA 

gen  n_inn    = 1
replace n_inn = 0 if inn==1

gen  n_GD     = 1
replace n_GD  = 0 if GD==1

gen  n_EXPD    = 1
replace n_EXPD=0 if EXPD==1

gen  n_k_ext    = 1
replace n_k_ext=0 if k_ext==1

gen exp_innov     = GD*EXPD

gen inn_x100   	   = inn*100
gen n_inn_x100     = n_inn*100
gen prod_x100      = prod*100
gen proc_x100      = proc*100
gen GD_x100        = GD*100
gen n_GD_x100      = n_GD*100
gen k_ext_x100     = k_ext*100
gen n_k_ext_x100   = n_k_ext*100
gen fin_x100       = fin*100
gen EXPD_x100      = EXPD*100
gen n_EXPD_x100    = n_EXPD*100
gen coop_x100      = coop*100
gen INN            = factor
gen exp_innov_x100 = exp_innov*100

label variable inn_x100 "Innov. en prod. y proc."
label variable prod_x100 "Innov. en Productos"
label variable proc_x100 "Innov. en Procesos"
label variable GD_x100 "Inversion en Innov."
label variable k_ext_x100 "Prop. Extranjera"
label variable fin_x100 "Reciben Financ. Publico"
label variable EXPD_x100 "Exportadoras"
label variable coop_x100 "Coop. Inst.Publicos y Univ."
label variable INN "Firmas representadas"
label variable exp_innov_x100 "Innov. y Export."

//EST.DESCRIPTIVA X SECTOR
estimates drop _all
eststo clear
*global vars "inn_x100 prod_x100 proc_x100 GD_x100 k_ext_x100 fin_x100 EXPD_100 coop_100"
global vars "EXPD_x100 GD_x100 exp_innov_x100"

quiet estpost su $vars [aweight = factor] , detail
eststo E0

quiet estpost su $vars [aweight = factor] if Alimentos==1 , detail
eststo E1

quiet estpost su $vars [aweight = factor] if Textil==1 , detail
eststo E2

quiet estpost su $vars [aweight = factor] if Madera==1 , detail
eststo E3

quiet estpost su $vars [aweight = factor] if Papel==1 , detail
eststo E4

quiet estpost su $vars [aweight = factor] if Quimica==1 , detail
eststo E5

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 , detail
eststo E6

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 , detail
eststo E7

esttab E0 E1 E2 E3 E4 E5 E6 E7 using "C:\Users\fernando.greve\Dropbox\WP1\estdescSectores2.tex", ///
replace collabels(none) f plain label nogaps nonumbers noobs nomtitles /// 
addnotes("Fuente: Elaboracion propia en base a la informacion de la EIT y Enia.") ///
cells(mean(fmt(1)))


///CANTIDAD DE FIRMAS X SECTOR
estimates drop _all
eststo clear

quiet estpost su INN   , detail
eststo E0

quiet estpost su INN  if Alimentos==1 , detail
eststo E1

quiet estpost su INN  if Textil==1 , detail
eststo E2

quiet estpost su INN  if Madera==1 , detail
eststo E3

quiet estpost su INN  if Papel==1 , detail
eststo E4

quiet estpost su INN  if Quimica==1 , detail
eststo E5

quiet estpost su INN  if Min_y_Metb==1 , detail
eststo E6

quiet estpost su INN  if MetalMecanica==1 , detail
eststo E7

esttab E0 E1 E2 E3 E4 E5 E6 E7 using "C:\Users\fernando.greve\Dropbox\WP1\cantidadSector2.tex", ///  
nonumbers replace collabels(none) f plain label nogaps nomtitles /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells("sum(fmt(%15.0fc))")


//EST.DESCRIPTIVA X SECTOR y POR AÑO

***TOTAL MUESTRA
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] , detail
eststo E0, title("Total") 

quiet estpost su $vars [aweight = factor] if  encuesta==1 , detail
eststo E1, title("1995")

quiet estpost su $vars [aweight = factor] if  encuesta==2 , detail
eststo E2, title("1998")

quiet estpost su $vars [aweight = factor] if  encuesta==3 , detail
eststo E3, title("2000")

quiet estpost su $vars [aweight = factor] if  encuesta==4 , detail
eststo E4, title("2004")

quiet estpost su $vars [aweight = factor] if  encuesta==5 , detail
eststo E5, title("2006")

quiet estpost su $vars [aweight = factor] if  encuesta==6 , detail
eststo E6, title("2008")

quiet estpost su $vars [aweight = factor] if  encuesta==7 , detail
eststo E7, title("2010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAno.tex", ///
replace collabels(none) f plain label nogaps nonumbers noobs nomtitles /// 
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))


///CANTIDAD DE FIRMAS X AÑO
estimates drop _all
eststo clear

quiet estpost su INN   , detail
eststo E0

quiet estpost su INN  if encuesta==1 , detail
eststo E1

quiet estpost su INN  if encuesta==2 , detail
eststo E2

quiet estpost su INN  if encuesta==3 , detail
eststo E3

quiet estpost su INN  if encuesta==4 , detail
eststo E4

quiet estpost su INN  if encuesta==5 , detail
eststo E5

quiet estpost su INN  if encuesta==6 , detail
eststo E6

quiet estpost su INN  if encuesta==7 , detail
eststo E7

esttab E0 E1 E2 E3 E4 E5 E6 E7 using "C:\Users\fernando.greve\Dropbox\WP1\cantidadAno.tex", ///  
nonumbers replace collabels(none) f plain label nogaps nomtitles /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells("sum(fmt(%15.0fc))")











***ALIMENTOS
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Alimentos==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if Alimentos==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoAlimentos.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoAlimentos") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***Textil
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Textil==1 , detail
eststo E0, title("Tex") 

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==6 , detail
eststo E6, title("2.008")

*quiet estpost su $vars [aweight = factor] if Textil==1 & encuesta==7 , detail
*eststo E7, title("2010")

esttab E0 E1 E2 E3 E4 E5 E6 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoTextil.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoTextil") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***Madera
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Madera==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if Madera==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoMadera.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoMadera") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***Papel
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Papel==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if Papel==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoPapel.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoPapel") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***Quimica
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Quimica==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if Quimica==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoQuimica.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoQuimica") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***Min_y_Metb
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if Min_y_Metb==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoMin_y_Metb.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoMin_y_Metb") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))

***MetalMecanica
estimates drop _all
eststo clear

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 , detail
eststo E0, title("Alim") 

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==1 , detail
eststo E1, title("1.995")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==2 , detail
eststo E2, title("1.998")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==3 , detail
eststo E3, title("2.000")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==4 , detail
eststo E4, title("2.004")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==5 , detail
eststo E5, title("2.006")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==6 , detail
eststo E6, title("2.008")

quiet estpost su $vars [aweight = factor] if MetalMecanica==1 & encuesta==7 , detail
eststo E7, title("2.010")

esttab E0 E1 E2 E3 E4 E5 E6 E7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\estdescAnoMetalMecanica.tex", ///
replace label nogaps nonumbers noobs mlabels(,titles) type /// 
collabels(none) ///
title("estdescAñoMetalMecanica") /// 
stats(N, fmt(%15.0fc) labels("Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///
cells(mean(fmt(1)))


*************************************************************************************
///TEST DE MEDIAS GASTO X TRABAJADOR (sector)
estimates drop _all
eststo clear

label variable gl "Esfuerzo Gasto Innov"

mean gl [pweight = factor]  , over(expD) 
lincom [gl]1 - [gl]0
eststo c , add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c , add(p_diff r(p)) title("Total") 

mean gl [pweight = factor] if Alimentos==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c1, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c1, add(p_diff r(p)) title("Alim") 

mean gl [pweight = factor] if Textil==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c2, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c2, add(p_diff r(p)) title("Text") 

mean gl [pweight = factor] if Madera==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c3, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c3, add(p_diff r(p)) title("Mad") 

mean gl [pweight = factor] if Papel==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c4, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c4, add(p_diff r(p)) title("Pap") 

mean gl [pweight = factor] if Quimica==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c5, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c5, add(p_diff r(p)) title("Quim") 

mean gl [pweight = factor] if Min_y_Metb==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c6, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c6, add(p_diff r(p)) title("M-MB") 

mean gl [pweight = factor] if MetalMecanica==1 , over(expD) 
lincom [gl]1 - [gl]0
eststo c7, add(Diff r(estimate) ) 
test [gl]1 = [gl]0
eststo c7, add(p_diff r(p)) title("M-M.") 

esttab c c1 c2 c3 c4 c5 c6 c7 using "C:\Users\fernando.greve\Dropbox\WP1\MeanGastoSector.tex", ///
star(* 0.10 ** 0.05 *** 0.01) noobs nogaps not  /// 
replace nonumbers mlabels(,titles) /// 
title("Test de medias: Esfuerzo en Innovación") ///
coeflabels( 0 "no-export" 1 "export") ///
stat(Diff p_diff N, fmt(%15.0fc %15.3fc %15.0fc) star ///
labels( "Diferencia" "(P-estad.)" "Obs.")) ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia.") ///


*************************************************************************************
///causalidad_ev
estimates drop _all
eststo clear

quiet tobit EV  ev gl vl   $encuesta [pweight = factor] , ll(0)
test _b[gl]=0 
eststo c , add(Fc_g r(F) p_g r(p) ) title("Total") 
*test _b[vl]=0 
*eststo c, add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Alimentos==1   , ll(0)
test _b[gl]=0 
eststo c1 , add(Fc_g r(F) p_g r(p) ) title("Alim") 
*test _b[vl]=0 
*eststo c1 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Textil==1   , ll(0)
test _b[gl]=0 
eststo c2 , add(Fc_g r(F) p_g r(p) ) title("Text") 
*test _b[vl]=0 
*eststo c2 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Madera==1   , ll(0)
test _b[gl]=0 
eststo c3 , add(Fc_g r(F) p_g r(p) ) title("Mad") 
*test _b[vl]=0 
*eststo c3, add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Papel==1   , ll(0)
test _b[gl]=0 
eststo c4 , add(Fc_g r(F) p_g r(p) ) title("Pap") 
*test _b[vl]=0 
*eststo c4 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Quimica==1   , ll(0)
test _b[gl]=0 
eststo c5 , add(Fc_g r(F) p_g r(p) ) title("Quim") 
*test _b[vl]=0 
*eststo c5, add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if Min_y_Metb==1   , ll(0)
test _b[gl]=0 
eststo c6 , add(Fc_g r(F) p_g r(p) ) title("M-MB") 
*test _b[vl]=0 
*eststo c6 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit EV  ev gl vl  $encuesta [pweight = factor] if MetalMecanica==1   , ll(0)
test _b[gl]=0 
eststo c7 , add(Fc_g r(F) p_g r(p) ) title("M-M") 
*test _b[vl]=0 
*eststo c7 , add(Fc_vl r(F) p_vl r(p) )

quiet esttab c c1 c2 c3 c4 c5 c6 c7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\grangerexportacion.tex", ///
keep(gl) ///cells(none) suprime coeficientes de la regresion
cells(_sign) ///
nogaps collabels(none) mlabels(, titles ) star type not label nonumbers replace /// 
star(* 0.10 ** 0.05 *** 0.01) ///
title("F-estadistico, test de causalidad de Granger: Intensidad Export.") ///
stats(Fc_g p_g  N , /// 
fmt(%15.2fc %15.2fc  %15.0fc ) ///
labels( ///
"F-estad. Esfuerzo innovacion" "(p-estad.)" ///
 "Obs.") )  ///              
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia." ///
"Incluye dummies por año." ///
"Var de control: Productividad.")


///causalidad_gasto
estimates drop _all
eststo clear

quiet tobit GL  ev gl vl   $encuesta [pweight = factor] , ll(0)
test _b[ev]=0 
eststo c , add(Fc_ev r(F) p_ev r(p) ) title("Total") 
*test _b[vl]=0 
*eststo c, add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Alimentos==1   , ll(0)
test _b[ev]=0 
eststo c1 , add(Fc_ev r(F) p_ev r(p) ) title("Alim") 
*test _b[vl]=0 
*eststo c1 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Textil==1   , ll(0)
test _b[ev]=0 
eststo c2 , add(Fc_ev r(F) p_ev r(p) ) title("Text") 
*test _b[vl]=0 
*eststo c2 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Madera==1   , ll(0)
test _b[ev]=0 
eststo c3 , add(Fc_ev r(F) p_ev r(p) ) title("Mad") 
*test _b[vl]=0 
*eststo c3, add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Papel==1   , ll(0)
test _b[ev]=0 
eststo c4 , add(Fc_ev r(F) p_ev r(p) ) title("Pap") 
*test _b[vl]=0 
*eststo c4 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Quimica==1   , ll(0)
test _b[ev]=0 
eststo c5 , add(Fc_ev r(F) p_ev r(p) ) title("Quim") 
*test _b[vl]=0 
*eststo c5, add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if Min_y_Metb==1   , ll(0)
test _b[ev]=0 
eststo c6 , add(Fc_ev r(F) p_ev r(p) ) title("M-MB") 
*test _b[vl]=0 
*eststo c6 , add(Fc_vl r(F) p_vl r(p) )

quiet tobit GL  ev gl vl  $encuesta [pweight = factor] if MetalMecanica==1   , ll(0)
test _b[ev]=0 
eststo c7 , add(Fc_ev r(F) p_ev r(p) ) title("M-M") 
*test _b[vl]=0 
*eststo c7 , add(Fc_vl r(F) p_vl r(p) )

esttab c c1 c2 c3 c4 c5 c6 c7 ///
using "C:\Users\fernando.greve\Dropbox\WP1\grangerGasto.tex", ///
keep(ev) ///cells(none) suprime coeficientes de la regresion
cells(_sign) ///
nogaps collabels(none) mlabels(, titles ) star type not label nonumbers replace /// 
star(* 0.10 ** 0.05 *** 0.01) ///
title("F-estadistico, test de causalidad de Granger: Esfuerzo Innovación") ///
stats(Fc_ev p_ev  N , /// 
fmt(%15.2fc %15.2fc  %15.0fc ) ///
labels( ///
"F-estad. Intensidad Export." "(p-estad.)" ///
 "Obs.") )  ///
addnotes("Fuente: Elaboración propia en base a la información de la EIT y Enia." ///
"Incluye dummies por año." ///
"Var de control: Productividad.")

************ GRÁFICO DE PTF V/S IED TWOWAY ****************************************************
reg ln_gl ev
predict fitted_Total
label variable fitted_Total `"Valores ajustados"'
gr twoway (scatter  ln_gl ev  if (ln_gl>0  & ev>=0 & ev<1 ) , ///
clpattern(dash) clwidth(medthick))  ///
|| (line fitted_Total ev  if (ln_gl>0  & ev>=0 & ev<1 ) , ///
clpattern(dash) clwidth(medthick))  ///		 
,title("Exportación vs Innovación") subtitle("(Muestra Total)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white))			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Total.pdf" , as(pdf)  replace

reg ln_gl ev if Alimentos==1
predict fitted_Alimentos
label variable fitted_Alimentos `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (ln_gl>0  & ev>=0 & ev<1 & Alimentos==1) , ///
clpattern(dash) clwidth(medthick))  ///
|| (line fitted_Alimentos ev  if (ln_gl>0  & ev>=0 & ev<1 & Alimentos==1 ) , ///
clpattern(dash) clwidth(medthick))  ///			 
,title("Exportación vs Innovación") subtitle("(Alimentos)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Alimentos.pdf" , as(pdf)  replace

reg ln_gl ev if Textil==1
predict fitted_Textil
label variable fitted_Textil `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (ln_gl>0 & ev>=0 & ev<1 & Textil==1) , ///
clpattern(dash) clwidth(medthick))  ///	
|| (line fitted_Textil ev  if (ln_gl>0  & ev>=0 & ev<1 & Textil==1) , ///
clpattern(dash) clwidth(medthick))  ///		 
,title("Exportación vs Innovación") subtitle("(Textil)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Textil.pdf" , as(pdf)  replace

reg ln_gl ev if Madera==1
predict fitted_Madera
label variable fitted_Madera `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (ln_gl>0  & ev>=0 & ev<1 & Madera==1) , ///
clpattern(dash) clwidth(medthick))  ///		 
|| (line fitted_Madera ev  if (ln_gl>0  & ev>=0 & ev<1 & Madera==1) , ///
clpattern(dash) clwidth(medthick))  ///
,title("Exportación vs Innovación") subtitle("(Madera)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Madera.pdf" , as(pdf)  replace

reg ln_gl ev if Papel==1
predict fitted_Papel
label variable fitted_Papel `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (ln_gl>0 & ev>=0 & ev<1 & Papel==1) , ///
clpattern(dash) clwidth(medthick))  ///		 
|| (line fitted_Madera ev  if (ln_gl>0  & ev>=0 & ev<1 & Papel==1) , ///
clpattern(dash) clwidth(medthick))  ///
,title("Exportación vs Innovación") subtitle("(Papel)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Papel.pdf" , as(pdf)  replace

reg ln_gl ev if Quimica==1
predict fitted_Quimica
label variable fitted_Quimica `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (ln_gl>0 & ev>=0 & ev<1 & Quimica==1) , ///
clpattern(dash) clwidth(medthick))  ///		 
|| (line fitted_Madera ev  if (ln_gl>0  & ev>=0 & ev<1 & Quimica==1) , ///
clpattern(dash) clwidth(medthick))  ///
,title("Exportación vs Innovación") subtitle("(Quimica)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Quimica.pdf" , as(pdf)  replace

reg ln_gl ev if Min_y_Metb==1
predict fitted_Min_y_Metb
label variable fitted_Min_y_Metb `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (Min_y_Metb==1 & ln_gl>0 & ev>=0 & ev<1) , ///
clpattern(dash) clwidth(medthick))  ///		 
|| (line fitted_Madera ev  if (ln_gl>0  & ev>=0 & ev<1 & Min_y_Metb==1) , ///
clpattern(dash) clwidth(medthick))  ///
,title("Exportación vs Innovación") subtitle("(Minerales y Metales base)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Min_y_Metb.pdf" , as(pdf)  replace

reg ln_gl ev if MetalMecanica==1
predict fitted_MetalMecanica
label variable fitted_MetalMecanica `"Valores ajustados"'
gr twoway (scatter  ln_gl ev if (MetalMecanica==1 & ln_gl>0 & ev>=0 & ev<1) , ///
clpattern(dash) clwidth(medthick))  ///		 
|| (line fitted_MetalMecanica ev  if (ln_gl>0  & ev>=0 & ev<1 & MetalMecanica==1) , ///
clpattern(dash) clwidth(medthick))  ///
,title("Exportación vs Innovación") subtitle("(Metal-mecanica)") ///		 
ytitle("Innovación esfuerzo (log)") ///			 
xtitle("Exportación intensidad (%)") ///
plotregion(fcolor(white)) graphregion(fcolor(white)) 			 
graph export "C:\Users\fernando.greve\Dropbox\WP1\twoway_Metal-mecanica.pdf" , as(pdf)  replace





graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor], over(Subsector) ///
label ///	
title("Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///			 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_total.pdf" , as(pdf)  replace
	
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==1 ///
, over(Subsector) ///
label ///	
title("Año 1995: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_1995.pdf" , as(pdf)  replace	
	
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==2 ///
, over(Subsector) ///
label ///	
title("Año 1998: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_1998.pdf" , as(pdf)  replace	
	
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==3 ///
, over(Subsector) ///
label ///	
title("Año 2000: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_2000.pdf" , as(pdf)  replace	
		
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==4 ///
, over(Subsector) ///
label ///	
title("Año 2004: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_2004.pdf" , as(pdf)  replace	
		
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==5 ///
, over(Subsector) ///
label ///	
title("Año 2006: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_2006.pdf" , as(pdf)  replace	
		
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==6 ///
, over(Subsector) ///
label ///	
title("Año 2008: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_2008.pdf" , as(pdf)  replace	
	
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] /// 
if encuesta==7 ///
, over(Subsector) ///
label ///	
title("Año 2010: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por Sub-sector manufacturero") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_2010.pdf" , as(pdf)  replace	
		
	
	
append using "C:\Users\fernando.greve\Dropbox\WP1\dolar.dta"
graph twoway line Dolar Ao ///
,title("Dólar observado") /// 
subtitle("Para el periodo 1995-2010") ///		 
ytitle("Dólar observado") ///			 
xtitle("Año") ///
xlabel(1995 1998 2000 2002 2004 2006 2008 2010) /// 
plotregion(fcolor(white)) graphregion(fcolor(white)) ///				
note("Fuente: Banco Central de Chile.") 
graph export "C:\Users\fernando.greve\Dropbox\WP1\dolar_observado.pdf" , as(pdf) replace				
								
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor], over(Año) ///
label ///	
title("Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)45) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano.pdf" , as(pdf)  replace

















			
graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Alimentos==1 ///
, over(Año) ///
label ///	
title("Sub-sector Alimentos: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Alimentos.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Textil==1 ///
, over(Año) ///
label ///	
title("Sub-sector Textil: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Textil.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Madera==1 ///
, over(Año) ///
label ///	
title("Sub-sector Madera: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Madera.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Papel==1 ///
, over(Año) ///
label ///	
title("Sub-sector Papel: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Papel.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Quimica==1 ///
, over(Año) ///
label ///	
title("Sub-sector Quimica: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Quimica.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if Min_y_Metb==1 ///
, over(Año) ///
label ///	
title("Sub-sector Minerales y Metales base: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_Min_y_Metb.pdf" , as(pdf)  replace

graph bar (mean) EXPD_x100 GD_x100 exp_innov_x100 [aweight = factor] ///
if MetalMecanica==1 ///
, over(Año) ///
label ///	
title("Sub-sector Metal Mecanica: Porcentaje de firmas que exportan e Innovan") ///
subtitle("por año") ///		 
ytitle("Porcentaje") ///
ylabel(0(10)80) ///				 
legend( label(2 "Innov.") label(1 "Export.") label(3 "Innov-Export")) ///
plotregion(fcolor(white)) graphregion(fcolor(white)) ///
note("Fuente: Elaboración propia en base a la información de la EIT y Enia.")
graph export "C:\Users\fernando.greve\Dropbox\WP1\bar_ano_MetalMecanica.pdf" , as(pdf)  replace
