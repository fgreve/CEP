drop _all
insheet using "C:\Users\fernando.greve\Dropbox\23-12-2012\4\4k.csv", comma
save "C:\Users\fernando.greve\Dropbox\23-12-2012\4\4k.dta", replace

use C:\Users\fernando.greve\Dropbox\23-12-2012\4\4v0.dta
gen encuesta = 4

merge  using "C:\Users\fernando.greve\Dropbox\23-12-2012\4\4k.dta"
drop _merge 

drop inn

gen ventas_n = real(ventas)
drop ventas
gen ventas = ventas_n
drop ventas_n

gen factor = factor_exp

//TRABAJO
gen empleados_04= empleo_ao_2004 
gen empleados_03= empleo_ao_2003

//VENTAS
gen ventas_04= ventas_ao_2004 
gen ventas_03= ventas_ao_2003

//EXPORTACIONES
gen exportaciones_04= expo_ao_2004
gen exportaciones_03= expo_ao_2003 

gen exportaciones_04_dummy = 0
gen exportaciones_03_dummy = 0

replace exportaciones_04_dummy =1 if exportaciones_04>0
replace exportaciones_03_dummy =1 if exportaciones_03>0


//INVERSION EN LICENCIAS
gen inversion_licencias_03=adquisicion_2003
gen inversion_licencias_04=adquisicion_2004

gen inversion_licencias_04_dummy = 0
gen inversion_licencias_03_dummy = 0

replace inversion_licencias_04_dummy =1 if inversion_licencias_04>0
replace inversion_licencias_03_dummy =1 if inversion_licencias_03>0

//PROPIEDAD EXTRANJERA
gen capital_extranjero_dummy =0
replace capital_extranjero_dummy  =1 if e_propiedad =="Extranjera" | e_propiedad=="Mixta" 


//DUMMIES SECTORIALES
gen CIIU2_15=0
gen CIIU2_16=0
gen CIIU2_17=0
gen CIIU2_18=0
gen CIIU2_19=0
gen CIIU2_20=0
gen CIIU2_21=0
gen CIIU2_22=0
gen CIIU2_23=0
gen CIIU2_24=0
gen CIIU2_25=0
gen CIIU2_26=0
gen CIIU2_27=0
gen CIIU2_28=0
gen CIIU2_29=0
gen CIIU2_31=0
gen CIIU2_32=0
gen CIIU2_33=0
gen CIIU2_34=0
gen CIIU2_35=0
gen CIIU2_36=0

replace CIIU2_15=1 if ciiufinal_str==15
replace CIIU2_16=1 if ciiufinal_str==16
replace CIIU2_17=1 if ciiufinal_str==17
replace CIIU2_18=1 if ciiufinal_str==18
replace CIIU2_19=1 if ciiufinal_str==19
replace CIIU2_20=1 if ciiufinal_str==20
replace CIIU2_21=1 if ciiufinal_str==21
replace CIIU2_22=1 if ciiufinal_str==22
replace CIIU2_23=1 if ciiufinal_str==23
replace CIIU2_24=1 if ciiufinal_str==24
replace CIIU2_25=1 if ciiufinal_str==25
replace CIIU2_26=1 if ciiufinal_str==26
replace CIIU2_27=1 if ciiufinal_str==27
replace CIIU2_28=1 if ciiufinal_str==28
replace CIIU2_29=1 if ciiufinal_str==29
replace CIIU2_31=1 if ciiufinal_str==31
replace CIIU2_32=1 if ciiufinal_str==32
replace CIIU2_33=1 if ciiufinal_str==33
replace CIIU2_34=1 if ciiufinal_str==34
replace CIIU2_35=1 if ciiufinal_str==35
replace CIIU2_36=1 if ciiufinal_str==36

gen sector_1 =0
replace sector_1=1 if CIIU2_15+CIIU2_16==1

gen sector_2 =0
replace sector_2=1 if CIIU2_17+CIIU2_18+CIIU2_19==1

gen sector_3 =0
replace sector_3=1 if CIIU2_20==1

gen sector_4 =0
replace sector_4=1 if CIIU2_21+CIIU2_22==1

gen sector_5 =0
replace sector_5=1 if CIIU2_24+CIIU2_25==1

gen sector_6 =0
replace sector_6=1 if CIIU2_26==1

gen sector_7 =0
replace sector_7=1 if CIIU2_27==1

gen sector_8 =0
replace sector_8=1 if CIIU2_28+CIIU2_29+CIIU2_31+CIIU2_32+CIIU2_33+CIIU2_34+CIIU2_35+CIIU2_36==1

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if sector_1+sector_2+sector_3+sector_4+sector_5+sector_6+sector_7+sector_8==1


//GASTO EN INNOVACIÓN
gen inn_04=  gasto_total_inn_2004
gen inn_03=  gasto_total_inn_2003

gen id_04 =   gastoinvbasica2004 + gastoinvaplicada2004 + gastoinvdesarrollo2004
gen id_03 =   gastoinvbasica2003 + gastoinvaplicada2003 + gastoinvdesarrollo2003

replace inn_04= 0 if inn_04==. 
replace inn_03= 0 if inn_03==. 

replace id_04= 0 if id_04==. 
replace id_03= 0 if id_03==.

gen total_04 = inn_04 + id_04
gen total_03 = inn_03 + id_03  


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_04_x100=  recursos_extpubli_2004
gen financ_publico_inn_03_x100=  recursos_extpubli_2003
replace financ_publico_inn_04_x100 =0 if total_04==0
replace financ_publico_inn_03_x100 =0 if total_03==0
replace financ_publico_inn_04_x100=0  if recursos_extpubli_2004==.
replace financ_publico_inn_03_x100=0  if recursos_extpubli_2003==.

gen financ_publico_inn_03_dummy  =0
replace financ_publico_inn_03_dummy  =1 if financ_publico_inn_03_x100 >0

gen financ_publico_inn_04_dummy  =0
replace financ_publico_inn_04_dummy  =1 if financ_publico_inn_04_x100 >0

gen total_publico_04 = financ_publico_inn_04_x100 * total_04
gen total_publico_03 = financ_publico_inn_03_x100 * total_03


//FINANCIAMIENTO PRIVADO
gen financ_privado_inn_04_x100 = 100 - financ_publico_inn_04_x100 
gen financ_privado_inn_04_dummy=0
replace financ_privado_inn_04_dummy  =1 if financ_privado_inn_04_x100>0

gen financ_privado_inn_03_x100 = 100 - financ_publico_inn_03_x100 
gen financ_privado_inn_03_dummy=0
replace financ_privado_inn_03_dummy  =1 if financ_privado_inn_03_x100>0

gen total_privado_04 = financ_privado_inn_04_x100 * total_04
gen total_privado_03 = financ_privado_inn_03_x100 * total_03



//INNOVACION PRODUCTO NUEVO PARA EL MERCADO
gen inn_producto=  producto3 
gen inn_producto_dummy= inn_producto

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= proceso3
gen inn_proceso_dummy=inn_proceso

//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0


//COOPERACION

//PROVEEDORES
gen proveedores= proveedores_ch+ proveedores_ext 
replace proveedores  =0 if proveedores==. 
gen proveedores_dummy =0
replace proveedores_dummy  =1 if proveedores>0

//CLIENTES
gen clientes= clientes_ch+ clientes_ext
replace clientes  =0 if clientes==.   
gen clientes_dummy =0
replace clientes_dummy  =1 if clientes>0

//COMPETENCIA
gen competencia = competidores_ch+ competidores_ext 
replace competencia  =0 if competencia ==.  
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0

//consultores y/o laboratorios y/o institutos privados
gen consultores_inst_privados= consultores_ch+ consultores_ext
replace consultores_inst_privados=0 if consultores_inst_privados==.
gen consultores_inst_privados_dummy=0
replace consultores_inst_privados_dummy  =1 if consultores_inst_privados>0

//UNIVERSIDADES
gen universidades = universidades_ch  
replace universidades  =0 if universidades==.
gen universidades_dummy =0
replace universidades_dummy  =1 if universidades==1

//INST PUBLICOS
gen inst_publicos = institutos_ch 
replace inst_publicos  =0 if inst_publicos==. 
gen inst_publicos_dummy =0
replace inst_publicos_dummy  = 1 if inst_publicos>0



//INFLACIÓN
gen inf_04 = 0.8148
gen inf_03 = 0.8063

gen GD=cond(total_04==0,0,1)
gen gD=cond(total_03==0,0,1)

gen l = empleados_03
gen L = empleados_04

gen expD = exportaciones_03_dummy
gen EXPD = exportaciones_04_dummy

gen exp    = exportaciones_03/inf_03
gen EXP    = exportaciones_04/inf_04

gen k_ext= capital_extranjero_dummy  

gen licD   = inversion_licencias_03_dummy

gen lic = inversion_licencias_03/inf_03
gen LIC = inversion_licencias_04/inf_04

gen g = total_03/inf_03
gen G = total_04/inf_04

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_04_dummy 

gen v = ventas_03/inf_03
gen V = ventas_04/inf_04

*gen k = capital_03/inf_03
*gen K  = capital_04/inf_04

save "C:\Users\fernando.greve\Dropbox\WP1\4.dta", replace
