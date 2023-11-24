**solo se tiene acceso a la base limpiada por benavente (401 observaciones)
drop _all
use C:\Users\fernando.greve\Dropbox\23-12-2012\2\2v0.dta 
gen encuesta = 2
drop gl va

//TRABAJO
gen obreros_98= obr98
gen obreros_97= obr97
gen obreros_96= obr96

gen empleados_98= empl98
gen empleados_97= empl97
gen empleados_96= empl96

gen trabajo_98= obreros_98 + empleados_98
gen trabajo_97= obreros_97 + empleados_97
gen trabajo_96= obreros_96 + empleados_96

//VENTAS
gen ventas = sales

//CAPITAL
gen capital_98=aftot98
gen capital_97=aftot97
gen capital_96=aftot96

//VALOR AGREGADO 
gen valor_agregado_98=va98
gen valor_agregado_97=va97
gen valor_agregado_96=va96

//PRODUCCIÓN 
gen produccion_98=vbp98
gen produccion_97=vbp97

//EXPORTACIONES
gen exportaciones_98=export98
gen exportaciones_97=export97
gen exportaciones_96=export96

gen exportaciones_98_dummy = 0
gen exportaciones_97_dummy = 0
gen exportaciones_96_dummy = 0

replace exportaciones_98_dummy =1 if exportaciones_98>0
replace exportaciones_97_dummy =1 if exportaciones_97>0
replace exportaciones_96_dummy =1 if exportaciones_96>0

//INVERSION EN MAQUINARIAS
gen inversion_maquinarias_98=invmaq98
gen inversion_maquinarias_97=invmaq97
gen inversion_maquinarias_96=invmaq96

gen inversion_maquinarias_98_dummy = 0
gen inversion_maquinarias_97_dummy = 0
gen inversion_maquinarias_96_dummy = 0

replace inversion_maquinarias_98_dummy =1 if inversion_maquinarias_98>0
replace inversion_maquinarias_97_dummy =1 if inversion_maquinarias_97>0
replace inversion_maquinarias_96_dummy =1 if inversion_maquinarias_96>0

//INVERSION EN LICENCIAS
gen inversion_licencias_98=lte98
gen inversion_licencias_97=lte97
gen inversion_licencias_96=lte96

gen inversion_licencias_98_dummy = 0
gen inversion_licencias_97_dummy = 0
gen inversion_licencias_96_dummy = 0

replace inversion_licencias_98_dummy =1 if inversion_licencias_98>0
replace inversion_licencias_97_dummy =1 if inversion_licencias_97>0
replace inversion_licencias_96_dummy =1 if inversion_licencias_96>0

//PROPIEDAD EXTRANJERA
gen capital_extranjero_98_dummy =0
replace capital_extranjero_98_dummy  =1 if prop98==2 | prop98==3 

//DUMMIES SECTORIALES
gen CIIU2_31=0
gen CIIU2_32=0
gen CIIU2_33=0
gen CIIU2_34=0
gen CIIU2_35=0
gen CIIU2_36=0
gen CIIU2_37=0
gen CIIU2_38=0
gen CIIU2_39=0

replace CIIU2_31=1 if ciiu2==31
replace CIIU2_32=1 if ciiu2==32
replace CIIU2_33=1 if ciiu2==33
replace CIIU2_34=1 if ciiu2==34
replace CIIU2_35=1 if ciiu2==35
replace CIIU2_36=1 if ciiu2==36
replace CIIU2_37=1 if ciiu2==37
replace CIIU2_38=1 if ciiu2==38
replace CIIU2_39=1 if ciiu2==39

gen sector_1 =CIIU2_31
gen sector_2 =CIIU2_32
gen sector_3 =CIIU2_33
gen sector_4 =CIIU2_34
gen sector_5 =CIIU2_35
gen sector_6 =CIIU2_36
gen sector_7 =CIIU2_37
gen sector_8 =CIIU2_38

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if sector_1+sector_2+sector_3+sector_4+sector_5+sector_6+sector_7+sector_8==1

//GASTO EN INNOVACIÓN
gen inn_98=  otros_98  
gen inn_97=  otros97

gen id_98 =  i_d_98  
gen id_97 =  i_d_97_b

replace inn_97= 0 if inn_97==. 
replace inn_98= 0 if inn_98==. 

replace id_97= 0 if id_97==. 
replace id_98= 0 if id_98==.

gen total_98 = inn_98 + id_98
gen total_97 = inn_97 + id_97


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_x100 = publico
replace financ_publico_inn_x100 =0 if total_98==0
gen financ_publico_inn_dummy =0
replace financ_publico_inn_dummy  =1 if financ_publico_inn_x100 >0
gen total_publico_98 = financ_publico_inn_x100 * total_98
gen total_publico_97 = financ_publico_inn_x100 * total_97

//FINANCIAMIENTO PRIVADO
gen financiamiento_privado_inn_x100 = 100 - financ_publico_inn_x100 
gen financiamiento_privado_inn_dummy=1
replace financ_publico_inn_x100 =0 if total_98+total_97==0  
replace financiamiento_privado_inn_dummy  =0 if financiamiento_privado_inn_x100==0
gen total_privado_98 = financiamiento_privado_inn_x100 * total_98
gen total_privado_97 = financiamiento_privado_inn_x100 * total_97


//INNOVACION PRODUCTO NUEVO PARA EL MERCADO
gen inn_producto=  __113a_ 
gen inn_producto_dummy=0
replace inn_producto_dummy =1 if inn_producto >3


//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso=  __123a_ 
gen inn_proceso_dummy=0
replace inn_proceso_dummy =1 if inn_proceso >3

//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0


//COOPERACION

//UNIVERSIDADES
gen universidades =__312a_ 
replace universidades  =0 if universidades==. 
gen universidades_dummy =0
replace universidades_dummy  =1 if universidades>3

//CONSULTORES
gen consultores=__322a_ 
replace consultores  =0 if consultores ==.
gen consultores_dummy =0
replace consultores_dummy  =1 if consultores>0

//CLIENTES Y/O PROVEEDORES
gen clientes_proveed=__323a_  
gen clientes_proveed_dummy =0
replace clientes_proveed_dummy  =1 if clientes_proveed>0

//COMPETENCIA
gen competencia =__324a_
replace clientes_proveed  =0 if clientes_proveed==.  
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0
replace competencia  =0 if competencia ==.

//INST PUBLICOS
gen inst_publicos =__325a_ 
replace inst_publicos  =0 if inst_publicos==. 
gen inst_publicos_dummy =0
replace inst_publicos_dummy  =1 if inst_publicos>3

//investigadores y/o univ y/o centros de investigacion
gen invest_centros_univ=__611_
replace invest_centros_univ  =0 if invest_centros_univ==.
gen invest_centros_univ_dummy=0
replace invest_centros_univ_dummy  =1 if invest_centros_univ>0


//INFLACIÓN
gen inf_98 = 0.6885
gen inf_97 = 0.6550
gen inf_96 = 0.6171

gen GD=cond(total_98==0,0,1)
gen gD=cond(total_97==0,0,1)

gen l = trabajo_97
gen L = trabajo_98

gen expD = exportaciones_97_dummy
gen EXPD = exportaciones_98_dummy

gen exp    = exportaciones_97/inf_97
gen EXP    = exportaciones_98/inf_98

gen k_ext= capital_extranjero_98_dummy  

gen licD   = inversion_licencias_97_dummy

gen lic = inversion_licencias_97/inf_97
gen LIC = inversion_licencias_98/inf_98

gen g = total_97/inf_97
gen G = total_98/inf_98

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_dummy

gen va = valor_agregado_97/inf_97
gen VA = valor_agregado_98/inf_98

gen v = produccion_97/inf_97
gen V = produccion_98/inf_98

gen k = capital_97/inf_97
gen K = capital_98/inf_98

save "C:\Users\fernando.greve\Dropbox\WP1\2.dta", replace
