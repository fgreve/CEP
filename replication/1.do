**se debe arreglar la var. factor que está con coma
drop _all
use C:\Users\fernando.greve\Dropbox\23-12-2012\1\1v0.dta

gen encuesta = 1 
gen ciiu_rev2 = ciiu4

//TRABAJO
gen obreros_95= obr95
gen obreros_94= obr94
gen obreros_93= obr93

gen empleados_95= empl95
gen empleados_94= empl94
gen empleados_93= empl93

gen trabajo_95= obreros_95 + empleados_95
gen trabajo_94= obreros_94 + empleados_94
gen trabajo_93= obreros_93 + empleados_93

//VENTAS
gen ventas_95=ventas95
gen ventas_94=ventas94
gen ventas_93=ventas93

//CAPITAL 
gen capital_93=aftot93
gen capital_94=aftot94
gen capital_95=aftot95

//VALOR AGREGADO 
gen valor_agregado_95=va95
gen valor_agregado_94=va94
gen valor_agregado_93=va93

//EXPORTACIONES
gen exportaciones_95=export95
gen exportaciones_94=export94
gen exportaciones_93=export93

gen exportaciones_95_dummy = 0
gen exportaciones_94_dummy = 0
gen exportaciones_93_dummy = 0

replace exportaciones_95_dummy =1 if exportaciones_95>0
replace exportaciones_94_dummy =1 if exportaciones_94>0
replace exportaciones_93_dummy =1 if exportaciones_93>0

//INVERSION EN MAQUINARIAS
gen inversion_maquinarias_95=invmaq95
gen inversion_maquinarias_94=invmaq94
gen inversion_maquinarias_93=invmaq93

gen inversion_maquinarias_95_dummy = 0
gen inversion_maquinarias_94_dummy = 0
gen inversion_maquinarias_93_dummy = 0

replace inversion_maquinarias_95_dummy =1 if inversion_maquinarias_95>0
replace inversion_maquinarias_94_dummy =1 if inversion_maquinarias_94>0
replace inversion_maquinarias_93_dummy =1 if inversion_maquinarias_93>0

//INVERSION EN LICENCIAS
gen inversion_licencias_95=lte95
gen inversion_licencias_94=lte94
gen inversion_licencias_93=lte93

gen inversion_licencias_95_dummy = 0
gen inversion_licencias_94_dummy = 0
gen inversion_licencias_93_dummy = 0

replace inversion_licencias_95_dummy =1 if inversion_licencias_95>0
replace inversion_licencias_94_dummy =1 if inversion_licencias_94>0
replace inversion_licencias_93_dummy =1 if inversion_licencias_93>0

//PROPIEDAD EXTRANJERA
gen capital_extranjero_95_dummy =0
replace capital_extranjero_95_dummy  =1 if prop95==2 | prop95==3 

gen capital_extranjero_94_dummy =0
replace capital_extranjero_94_dummy  =1 if prop94==2 | prop94==3

gen capital_extranjero_93_dummy =0
replace capital_extranjero_93_dummy  =1 if prop93==2 | prop93==3  


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
gen inn_94=  otros_94
gen inn_95=  otros_95

gen id_94 =   i_d_94
gen id_95 =   i_d_95

replace inn_94= 0 if inn_94==.  

replace id_94= 0 if id_94==. 

gen total_94 = inn_94 + id_94
gen total_95 = inn_95 + id_95  


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_x100 =__9321_+ __9322_+ __9323_
replace financ_publico_inn_x100 =0 if total_94+total_95==0  
gen financ_publico_inn_dummy=0
replace financ_publico_inn_dummy  =1 if financ_publico_inn_x100 >0
gen total_publico_94 = financ_publico_inn_x100 * total_94
gen total_publico_95 = financ_publico_inn_x100 * total_95


//FINANCIAMIENTO PRIVADO
gen financ_privado_inn_x100 = 100 - financ_publico_inn_x100 
gen financ_privado_inn_dummy=1
replace financ_privado_inn_dummy  =0 if financ_privado_inn_x100==0
gen total_privado_94 = financ_privado_inn_x100 * total_94
gen total_privado_95 = financ_privado_inn_x100 * total_95


//INNOVACION PRODUCTO NUEVO PARA EL MERCADO
gen inn_producto=  __113_ 
gen inn_producto_dummy=0
replace inn_producto_dummy =1 if inn_producto>3

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= __121_
gen inn_proceso_dummy=0
replace inn_proceso_dummy =1 if inn_proceso>3

//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0



//COOPERACION

//UNIVERSIDADES
gen universidades =__321_
replace universidades  =0 if universidades==.  
gen universidades_dummy =0
replace universidades_dummy  =1 if universidades>3

//INST PRIVADOS
gen inst_privados =__322_
replace inst_privados =0 if inst_privados==.  
gen inst_privados_dummy =0
replace inst_privados_dummy  =1 if inst_privados>0

//CLIENTES Y/O PROVEEDORES
gen clientes_proveedores=__323_ 
replace clientes_proveedores  =0 if clientes_proveedores==. 
gen clientes_proveedores_dummy =0
replace clientes_proveedores_dummy  =1 if clientes_proveedores>0

//INST PUBLICOS
gen inst_publicos =__326_
replace inst_publicos  =0 if inst_publicos==.  
gen inst_publicos_dummy =0
replace inst_publicos_dummy  = 1 if inst_publicos>3

//COMPETENCIA
gen competencia =__327_ 
replace competencia  =0 if competencia ==. 
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0

//INVESTIGADORES
gen investigadores=__511_ 
replace investigadores  =0 if investigadores ==.
gen investigadores_dummy =0
replace investigadores_dummy  =1 if investigadores>0

//UNIVERSIDADES Y/O INSTITUTOS TECNOLÓGICOS
gen univ_inst=__512_ 
replace univ_inst  =0 if univ_inst ==.
gen univ_inst_dummy =0
replace univ_inst_dummy  =1 if univ_inst>2

//INFLACIÓN
gen inf_95 = 0.5748
gen inf_94 = 0.5311
gen inf_93 = 0.4765

gen GD=cond(total_95==0,0,1)
gen gD=cond(total_94==0,0,1)

gen l = trabajo_94
gen L = trabajo_95

gen expD = exportaciones_94_dummy
gen EXPD = exportaciones_95_dummy

gen exp    = exportaciones_94/inf_94
gen EXP    = exportaciones_95/inf_95

gen k_ext= capital_extranjero_95_dummy  

gen licD   = inversion_licencias_94_dummy

gen lic = inversion_licencias_94/inf_94
gen LIC = inversion_licencias_95/inf_95

gen g = total_94/inf_94
gen G = total_95/inf_95

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_dummy

gen va = valor_agregado_94/inf_94
gen VA = valor_agregado_95/inf_95

gen v = ventas_94/inf_94
gen V = ventas_95/inf_95

gen k = capital_94/inf_94
gen K  = capital_95/inf_95

save "C:\Users\fernando.greve\Dropbox\WP1\1.dta", replace
