**se tiene una base de 559 (la limpiada por benavente)
**la variable "sector señala si es empresa manufacturera o no
drop _all
use C:\Users\fernando.greve\Dropbox\23-12-2012\3\3v0.dta
drop va
gen encuesta = 3

*gen id =  enia_199
*sort id

//TRABAJO
gen obreros_00= obr00
gen obreros_99= obr99
*gen obreros_98= obr98

gen empleados_00= empl00
gen empleados_99= empl99
*gen empleados_98= empl98

gen trabajo_00= obreros_00 + empleados_00
gen trabajo_99= obreros_99 + empleados_99
*gen trabajo_98= obreros_98 + empleados_98

//VENTAS
gen ventas = valor_venta

//CAPITAL 
gen capital_00=actot00
gen capital_99=actot99
gen capital_98=aftot98

//VALOR AGREGADO 
gen valor_agregado_00=va00
gen valor_agregado_99=va99
gen valor_agregado_98=va98

//PRODUCCIÓN 
gen produccion_00=vbp00
gen produccion_99=vbp99

//EXPORTACIONES
gen exportaciones_00=export00
gen exportaciones_99=export99
gen exportaciones_98=export98

gen exportaciones_00_dummy = 0
gen exportaciones_99_dummy = 0
gen exportaciones_98_dummy = 0

replace exportaciones_00_dummy =1 if exportaciones_00>0
replace exportaciones_99_dummy =1 if exportaciones_99>0
replace exportaciones_98_dummy =1 if exportaciones_98>0

//INVERSION EN MAQUINARIAS
gen inversion_maquinarias_00=invmaq00
gen inversion_maquinarias_99=invmaq99
gen inversion_maquinarias_98=invmaq98

gen inversion_maquinarias_00_dummy = 0
gen inversion_maquinarias_99_dummy = 0
gen inversion_maquinarias_98_dummy = 0

replace inversion_maquinarias_00_dummy =1 if inversion_maquinarias_00>0
replace inversion_maquinarias_99_dummy =1 if inversion_maquinarias_99>0
replace inversion_maquinarias_98_dummy =1 if inversion_maquinarias_98>0

//INVERSION EN LICENCIAS
gen inversion_licencias_00=lte00
gen inversion_licencias_99=lte99
gen inversion_licencias_98=lte98

gen inversion_licencias_00_dummy = 0
gen inversion_licencias_99_dummy = 0
gen inversion_licencias_98_dummy = 0

replace inversion_licencias_00_dummy =1 if inversion_licencias_00>0
replace inversion_licencias_99_dummy =1 if inversion_licencias_99>0
replace inversion_licencias_98_dummy =1 if inversion_licencias_98>0

//PROPIEDAD EXTRANJERA
gen capital_extranjero_00_dummy =0
replace capital_extranjero_00_dummy  =1 if prop00==2 | prop00==3 

gen capital_extranjero_99_dummy =0
replace capital_extranjero_99_dummy  =1 if prop99==2 | prop99==3

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

replace CIIU2_31=1 if ciiu22dig==31
replace CIIU2_32=1 if ciiu22dig==32
replace CIIU2_33=1 if ciiu22dig==33
replace CIIU2_34=1 if ciiu22dig==34
replace CIIU2_35=1 if ciiu22dig==35
replace CIIU2_36=1 if ciiu22dig==36
replace CIIU2_37=1 if ciiu22dig==37
replace CIIU2_38=1 if ciiu22dig==38
replace CIIU2_39=1 if ciiu22dig==39

gen sector_1 =CIIU2_31
gen sector_2 =CIIU2_32
gen sector_3 =CIIU2_33
gen sector_4 =CIIU2_34
gen sector_5 =CIIU2_35
gen sector_6 =CIIU2_36
gen sector_7 =CIIU2_37
gen sector_8 =CIIU2_38
gen sector_9 =CIIU2_39

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if sector_1+sector_2+sector_3+sector_4+sector_5+sector_6+sector_7+sector_8==1

//GASTO EN INNOVACIÓN
gen inn_00=  v1022_20 + v1023_20 + v1024_20
gen inn_01=  v1022_21 + v1023_21 + v1024_21

gen id_00 =   v1021_20
gen id_01 =   v1021_21

replace inn_00= 0 if inn_00==. 
replace inn_01= 0 if inn_01==. 

replace id_00= 0 if id_00==. 
replace id_01= 0 if id_01==.

gen total_00 = v1025_20
gen total_01 = v1025_21 


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_x100  = v1032
replace financ_publico_inn_x100 =0 if total_01==0
gen financ_publico_inn_dummy  =0
replace financ_publico_inn_dummy  =1 if financ_publico_inn_x100 >0
gen total_publico_00 = financ_publico_inn_x100 * total_00
gen total_publico_01 = financ_publico_inn_x100 * total_01

//FINANCIAMIENTO PRIVADO
gen financ_privado_inn_x100 = 100 - financ_publico_inn_x100 
gen financ_privado_inn_dummy=0
replace financ_privado_inn_dummy  =1 if financ_privado_inn_x100>0
gen total_privado_00 = financ_privado_inn_x100 * total_00
gen total_privado_01 = financ_privado_inn_x100 * total_01


//INNOVACION PRODUCTO NUEVO PARA EL MERCADO
gen inn_producto=  v213 
gen inn_producto_dummy=0
replace inn_producto_dummy =1 if inn_producto>3

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= v223
gen inn_proceso_dummy=0
replace inn_proceso_dummy =1 if inn_proceso>3

//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0



//COOPERACION

//UNIVERSIDADES
gen universidades = v421
replace universidades  =0 if universidades==.  
gen universidades_dummy =0
replace universidades_dummy  =1 if universidades>3

//CONSULTORES
gen consultores= v422 
replace consultores  =0 if consultores ==.
gen consultores_dummy =0
replace consultores_dummy  =1 if consultores>0

//CLIENTES Y/O PROVEEDORES
gen clientes_proveedores= v423
replace clientes_proveedores  =0 if clientes_proveedores==.  
gen clientes_proveedores_dummy =0
replace clientes_proveedores_dummy  =1 if clientes_proveedores>0

//COMPETENCIA
gen competencia = v424  
replace competencia  =0 if competencia ==.
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0

//INST PUBLICOS
gen inst_publicos = v425 
replace inst_publicos  =0 if inst_publicos==. 
gen inst_publicos_dummy =0
replace inst_publicos_dummy  = 1 if inst_publicos>3

//investigadores y/o univ y/o centros de investigacion
gen invest_centros_univ= v711
replace invest_centros_univ  =0 if invest_centros_univ==.
gen invest_centros_univ_dummy=0
replace invest_centros_univ_dummy  =1 if invest_centros_univ>0


//INFLACIÓN
gen inf_01 = 0.7652
gen inf_00 = 0.7388
gen inf_99 = 0.7115
gen inf_98 = 0.6885

gen GD=cond(total_01==0,0,1)
gen gD=cond(total_00==0,0,1)

gen l = trabajo_99
gen L = trabajo_00

gen expD = exportaciones_99_dummy
gen EXPD = exportaciones_00_dummy

gen exp    = exportaciones_99/inf_99
gen EXP    = exportaciones_00/inf_00

gen k_ext= capital_extranjero_00_dummy  

gen licD   = inversion_licencias_99_dummy

gen lic = inversion_licencias_99/inf_99
gen LIC = inversion_licencias_00/inf_00

*gen g = total_00/inf_00
gen G = total_00/inf_00

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_dummy

gen va = valor_agregado_99/inf_99
gen VA = valor_agregado_00/inf_00

gen v = produccion_99/inf_99
gen V = produccion_00/inf_00

gen k = capital_99/inf_99
gen K  = capital_00/inf_00

save "C:\Users\fernando.greve\Dropbox\WP1\3.dta", replace

