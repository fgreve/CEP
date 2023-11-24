drop _all
*insheet using "C:\Users\fernando.greve\Dropbox\23-12-2012\5\5k.csv", comma
*save "C:\Users\fernando.greve\Dropbox\23-12-2012\5\5k.dta", replace

use C:\Users\fernando.greve\Dropbox\23-12-2012\5\5v0.dta

gen encuesta = 5

drop sociocoop
drop tiempo
drop exportaciones

*drop _merge
*merge  using "C:\Users\fernando.greve\Dropbox\23-12-2012\5\5k.dta"
*drop _merge 

gen factor = factor_exp

//REGION
drop region
gen region = region_est

//PROPIEDAD porcentaje
gen nacional_porcentaje   = conf_nacional
gen extranjera_porcentaje = conf_exranjero 

//SECTORES
gen categoria = categ_ciiu_2

//TRABAJO
gen empleados_06= empleo_ao_2006 
gen empleados_05= empleo_ao_2005

//VENTAS
gen ventas_06= ventas_ao_2006 
gen ventas_05= ventas_ao_2005

//VENTAS INNOVADORAS (porcentaje)
gen ventas_inn_05 = ventas_innov_2005
gen ventas_inn_06 = ventas_innov_2006
gen ventas_inn_porcentaje_05 = ventas_innov_2005 / ventas_05
gen ventas_inn_porcentaje_06 = ventas_innov_2006 / ventas_06

//EXPORTACIONES
gen exportaciones_06= expo_ao_2006
gen exportaciones_05= expo_ao_2005 

gen exportaciones_06_dummy = 0
gen exportaciones_05_dummy = 0

replace exportaciones_06_dummy =1 if exportaciones_06>0
replace exportaciones_05_dummy =1 if exportaciones_05>0


//INVERSION EN LICENCIAS
gen inversion_licencias_05=adquisicion_2005
gen inversion_licencias_06=adquisicion_2006

gen inversion_licencias_06_dummy = 0
gen inversion_licencias_05_dummy = 0

replace inversion_licencias_06_dummy =1 if inversion_licencias_06>0
replace inversion_licencias_05_dummy =1 if inversion_licencias_05>0

//PROPIEDAD EXTRANJERA
gen capital_extranjero_dummy =1
replace capital_extranjero_dummy  =0 if conf_exranjero==0

//dummies sectoriales
gen CIIU2_01=0
gen CIIU2_02=0
gen CIIU2_05=0
gen CIIU2_10=0
gen CIIU2_13=0
gen CIIU2_14=0
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
gen CIIU2_30=0
gen CIIU2_31=0
gen CIIU2_32=0
gen CIIU2_33=0
gen CIIU2_34=0
gen CIIU2_35=0
gen CIIU2_36=0
gen CIIU2_40=0
gen CIIU2_41=0
gen CIIU2_45=0
gen CIIU2_50=0
gen CIIU2_51=0
gen CIIU2_52=0
gen CIIU2_55=0
gen CIIU2_60=0
gen CIIU2_62=0
gen CIIU2_63=0
gen CIIU2_64=0
gen CIIU2_65=0
gen CIIU2_66=0
gen CIIU2_67=0
gen CIIU2_70=0
gen CIIU2_72=0
gen CIIU2_73=0
gen CIIU2_74=0
gen CIIU2_80=0
gen CIIU2_85=0
gen CIIU2_90=0
gen CIIU2_91=0
gen CIIU2_92=0
gen CIIU2_93=0


replace CIIU2_01=1 if ciiu=="01"
replace CIIU2_02=1 if ciiu=="02"
replace CIIU2_05=1 if ciiu=="05"
replace CIIU2_10=1 if ciiu=="10"
replace CIIU2_13=1 if ciiu=="13"
replace CIIU2_14=1 if ciiu=="14"
replace CIIU2_15=1 if ciiu=="15"
replace CIIU2_16=1 if ciiu=="16"
replace CIIU2_17=1 if ciiu=="17"
replace CIIU2_18=1 if ciiu=="18"
replace CIIU2_19=1 if ciiu=="19"
replace CIIU2_20=1 if ciiu=="20"
replace CIIU2_21=1 if ciiu=="21"
replace CIIU2_22=1 if ciiu=="22"
replace CIIU2_23=1 if ciiu=="23"
replace CIIU2_24=1 if ciiu=="24"
replace CIIU2_25=1 if ciiu=="25"
replace CIIU2_26=1 if ciiu=="26"
replace CIIU2_27=1 if ciiu=="27"
replace CIIU2_28=1 if ciiu=="28"
replace CIIU2_29=1 if ciiu=="29"
replace CIIU2_30=1 if ciiu=="30"
replace CIIU2_31=1 if ciiu=="31"
replace CIIU2_32=1 if ciiu=="32"
replace CIIU2_33=1 if ciiu=="33"
replace CIIU2_34=1 if ciiu=="34"
replace CIIU2_35=1 if ciiu=="35"
replace CIIU2_36=1 if ciiu=="36"
replace CIIU2_40=1 if ciiu=="40"
replace CIIU2_41=1 if ciiu=="41"
replace CIIU2_45=1 if ciiu=="45"
replace CIIU2_50=1 if ciiu=="50"
replace CIIU2_51=1 if ciiu=="51"
replace CIIU2_52=1 if ciiu=="52"
replace CIIU2_55=1 if ciiu=="55"
replace CIIU2_60=1 if ciiu=="60"
replace CIIU2_62=1 if ciiu=="62"
replace CIIU2_63=1 if ciiu=="63"
replace CIIU2_64=1 if ciiu=="64"
replace CIIU2_65=1 if ciiu=="65"
replace CIIU2_66=1 if ciiu=="66"
replace CIIU2_67=1 if ciiu=="67"
replace CIIU2_70=1 if ciiu=="70"
replace CIIU2_72=1 if ciiu=="72"
replace CIIU2_73=1 if ciiu=="73"
replace CIIU2_74=1 if ciiu=="74"
replace CIIU2_80=1 if ciiu=="80"
replace CIIU2_85=1 if ciiu=="85"
replace CIIU2_90=1 if ciiu=="90"
replace CIIU2_91=1 if ciiu=="91"
replace CIIU2_92=1 if ciiu=="92"
replace CIIU2_93=1 if ciiu=="93"

drop ciiu

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
replace sector_8=1 if CIIU2_28+CIIU2_29+CIIU2_30+CIIU2_31+CIIU2_32+CIIU2_33+CIIU2_34+CIIU2_35+CIIU2_36==1

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if sector_1+sector_2+sector_3+sector_4+sector_5+sector_6+sector_7+sector_8==1

//GASTO EN INNOVACIÓN
gen inn_05=  gasto_total_ai_2005  
gen inn_06=  gasto_total_ai_2006

gen id_05=gasto_total_id_2005
gen id_06=gasto_total_id_2006

replace inn_06= 0 if inn_06==. 
replace inn_05= 0 if inn_05==. 

replace id_06= 0 if id_06==. 
replace id_05= 0 if id_05==.

gen total_05 = inn_05 + id_05  
gen total_06 = inn_06 + id_06

gen patentes_05     = adquisicion_2005
gen capacitacion_05 = capacitacion_2005
gen otras_05   = otrasprepa_2005
gen introduccion_05 = introduccion_2005
gen maquinaria_05   = adquisicion_maq_2005

gen patentes_06     = adquisicion_2006
gen capacitacion_06 = capacitacion_2006
gen otras_06   = otrasprepa_2006
gen introduccion_06 = introduccion_2006
gen maquinaria_06   = adquisicion_maq_2006


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_05_x100=  recursos_extpubli_2005
gen financ_publico_inn_06_x100=  recursos_extpubli_2006
replace financ_publico_inn_05_x100 =0 if total_05==0
replace financ_publico_inn_06_x100 =0 if total_06==0
replace financ_publico_inn_05_x100=0  if recursos_extpubli_2005==.
replace financ_publico_inn_06_x100=0  if recursos_extpubli_2006==.

gen financ_publico_inn_05_dummy  =0
replace financ_publico_inn_05_dummy  =1 if financ_publico_inn_05_x100 >0

gen financ_publico_inn_06_dummy  =0
replace financ_publico_inn_06_dummy  =1 if financ_publico_inn_06_x100 >0  

gen total_publico_06 = financ_publico_inn_06_x100 * total_06
gen total_publico_05 = financ_publico_inn_05_x100 * total_05


//FINANCIAMIENTO PRIVADO
gen financ_privado_inn_06_x100 = 100 - financ_publico_inn_06_x100 
gen financ_privado_inn_06_dummy=0
replace financ_privado_inn_06_dummy  =1 if financ_privado_inn_06_x100>0

gen financ_privado_inn_05_x100 = 100 - financ_publico_inn_05_x100 
gen financ_privado_inn_05_dummy=0
replace financ_privado_inn_05_dummy  =1 if financ_privado_inn_05_x100>0

gen total_privado_06 = financ_privado_inn_06_x100 * total_06
gen total_privado_05 = financ_privado_inn_05_x100 * total_05




//INNOVACION PRODUCTO NUEVO PARA EL MERCADO
***se elimina la variable existente en la base
drop inn_producto  
gen inn_producto=  -(producto3-2) 
gen inn_producto_dummy= inn_producto

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
***se elimina la variable existente en la base
drop inn_proceso
gen inn_proceso= -(proceso3-2)
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
replace inst_publicos_dummy  = 1 if inst_publicos==1


//INFLACIÓN
gen inf_06 = 0.8681
gen inf_05 = 0.8396

gen GD=cond(total_06==0,0,1)
gen gD=cond(total_05==0,0,1)

gen l = empleados_05
gen L = empleados_06

gen expD = exportaciones_05_dummy
gen EXPD = exportaciones_06_dummy

gen exp    = exportaciones_05/inf_05
gen EXP    = exportaciones_06/inf_06

gen k_ext= capital_extranjero_dummy  

gen licD   = inversion_licencias_05_dummy

gen lic = inversion_licencias_05/inf_05
gen LIC = inversion_licencias_06/inf_06

gen g = total_05/inf_05
gen G = total_06/inf_06

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_06_dummy 

gen v = ventas_05/inf_05
gen V = ventas_06/inf_06

*gen k = capital_05/inf_05
*gen K  = capital_06/inf_06

gen patentes 	     = patentes_05/inf_05
gen capacitacion_inn = capacitacion_05/inf_05  
gen otras_inn	     = otras_05/inf_05        
gen introduccion_inn = introduccion_05/inf_05  
gen maquinaria_inn   = maquinaria_05/inf_05   

gen PATENTES 	     = patentes_06/inf_06
gen CAPACITACION_INN = capacitacion_06/inf_06  
gen OTRAS_INN	     = otras_06/inf_06        
gen INTRODUCCION_INN = introduccion_06/inf_06  
gen MAQUINARIA_INN   = maquinaria_06/inf_06

save "C:\Users\fernando.greve\Dropbox\WP1\5.dta", replace
