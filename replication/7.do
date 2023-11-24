**VERIFICAR QUE LAS BASES ESTÉN ORDENADAS POR ID (default)
drop _all

use "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE1.dta"
sort ID
save "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE1v0.dta", replace

use "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE2.dta"
sort ID
save "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE2v0.dta", replace

use "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE3.dta"
sort ID
save "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE3v0.dta", replace

use C:\Users\fernando.greve\Dropbox\23-12-2012\7\ATRIBUTOS.dta
sort ID

merge ID using "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE1v0.dta"
drop _merge
sort ID
merge ID using "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE2v0.dta"
drop _merge 
sort ID
merge ID using "C:\Users\fernando.greve\Dropbox\23-12-2012\7\INNOVACIÓN2011_PARTE3v0.dta"
drop _merge 

save "C:\Users\fernando.greve\Dropbox\23-12-2012\7\7v0.dta", replace

*merge  using "C:\Users\fernando.greve\Dropbox\23-12-2012\7\7k.dta"
*drop _merge 

gen factor =  FE_VENTAS

gen encuesta = 7

//AÑO
gen año = P024
gen edad = 2010-año

//REGION
*gen region = REGION
gen region=0
replace region=1 if REGION=="1"
replace region=2 if REGION=="2"
replace region=3 if REGION=="3"
replace region=4 if REGION=="4"
replace region=5 if REGION=="5"
replace region=6 if REGION=="6"
replace region=7 if REGION=="7"
replace region=8 if REGION=="8"
replace region=9 if REGION=="9"
replace region=10 if REGION=="10"
replace region=11 if REGION=="11"
replace region=12 if REGION=="12"
replace region=13 if REGION=="13"
replace region=14 if REGION=="14"
replace region=15 if REGION=="15"
drop REGION

//PROPIEDAD porcentaje
gen nacional_porcentaje= P026
replace nacional_porcentaje=100 if P025==1
replace nacional_porcentaje=100 if P025==4
replace nacional_porcentaje=0   if P025==2

gen extranjera_porcentaje = P027
replace extranjera_porcentaje=0   if P025==1
replace extranjera_porcentaje=0   if P025==4
replace extranjera_porcentaje=100 if P025==2
count if extranjera_porcentaje==.

//SECTORES
gen categoria = SECTOR_ACTIVIDAD

//TRABAJO
gen empleados_09= P210 
gen empleados_10= P211 

gen profesionales_tecnicos_09 = P208
gen profesionales_tecnicos_10 = P209

//VENTAS
gen ventas_09= P200
gen ventas_10= P201

//VENTAS INNOVADORAS (porcentaje)
gen ventas_inn_porcentaje_09 = (P3014+P3016)/100 
gen ventas_inn_porcentaje_10 = (P3015+P3017)/100
replace ventas_inn_porcentaje_09=0 if ventas_inn_porcentaje_09==.
replace ventas_inn_porcentaje_10=0 if ventas_inn_porcentaje_10==.

//EXPORTACIONES
gen exportaciones_09= P202 
gen exportaciones_10= P203

gen exportaciones_09_dummy = 0
gen exportaciones_10_dummy = 0

replace exportaciones_09_dummy =1 if exportaciones_09>0
replace exportaciones_10_dummy =1 if exportaciones_10>0


//INVERSION EN LICENCIAS
gen inversion_licencias_09=P3086
gen inversion_licencias_10=P3087

gen inversion_licencias_09_dummy = 0
gen inversion_licencias_10_dummy = 0

replace inversion_licencias_09_dummy =1 if inversion_licencias_09>0
replace inversion_licencias_10_dummy =1 if inversion_licencias_10>0


//PROPIEDAD EXTRANJERA
gen capital_extranjero  = P025
gen capital_extranjero_dummy =1
replace capital_extranjero_dummy  =0 if capital_extranjero ==1 | capital_extranjero ==4


//dummies sectoriales

*gen Alimentos = sector_1
*gen Textil = sector_2 
*gen Madera = sector_3 
*gen Papel = sector_4 
*gen Quimica = sector_5 
*gen Min_y_Metb = sector_6 + sector_7
*gen MetalMecanica = sector_8

gen CIIU2_15=0
gen CIIU2_20=0
gen CIIU2_21=0
gen CIIU2_24=0
gen CIIU2_27=0
gen CIIU2_28=0
gen CIIU2_31=0
gen CIIU2_99=0


replace CIIU2_15=1 if DIVISION_ACTIVIDAD==15
replace CIIU2_20=1 if DIVISION_ACTIVIDAD==20
replace CIIU2_21=1 if DIVISION_ACTIVIDAD==21
replace CIIU2_24=1 if DIVISION_ACTIVIDAD==24
replace CIIU2_27=1 if DIVISION_ACTIVIDAD==27
replace CIIU2_28=1 if DIVISION_ACTIVIDAD==28
replace CIIU2_31=1 if DIVISION_ACTIVIDAD==31
replace CIIU2_99=1 if DIVISION_ACTIVIDAD==99


gen sector_1 =CIIU2_15
gen sector_2 =0
gen sector_3 =CIIU2_20
gen sector_4 =CIIU2_21
gen sector_5 =CIIU2_24
gen sector_6 =CIIU2_27
gen sector_7 =0
gen sector_8 =CIIU2_28

gen manufactura_dummy = 0
replace manufactura_dummy = 1 if sector_1+sector_2+sector_3+sector_4+sector_5+sector_6+sector_7+sector_8==1

//GASTO EN INNOVACIÓN
gen inn_09=  P3094   
gen inn_10=  P3095

*gen id_08= gasto_id12008 + gasto_id22008 + gasto_id32008
*gen id_07= gasto_id12007 + gasto_id22007 + gasto_id32007

gen id_09=.
gen id_10=.

replace inn_09= 0 if inn_09==. 
replace inn_10= 0 if inn_10==. 

*replace id_08= 0 if id_08==. 
*replace id_07= 0 if id_07==.

gen total_09 = inn_09   
gen total_10 = inn_10 

gen patentes_09     = P3086
gen capacitacion_09 = P3088
gen otras_09        = P3092
gen introduccion_09 = P3090
gen maquinaria_09   = P3084

gen patentes_10     = P3087
gen capacitacion_10 = P3089
gen otras_10        = P3093
gen introduccion_10 = P3091
gen maquinaria_10   = P3085


//FINANCIAMIENTO PUBLICO
gen financ_publico_inn=  P3275
*gen financ_publico_inn_08_x100=  p3099
*replace financ_publico_inn_07_x100 =0 if total_07==0
replace financ_publico_inn =0 if total_09==0 & total_10==0
replace financ_publico_inn=0  if financ_publico_inn==.
*replace financ_publico_inn_08_x100=0  if financ_publico_inn_08_x100==.

gen financ_publico_inn_dummy  =0
replace financ_publico_inn_dummy  =1 if financ_publico_inn > 0

*gen financ_publico_inn_08_dummy  =0
*replace financ_publico_inn_08_dummy  =1 if financ_publico_inn_08_x100 >0   

*gen total_publico_08 = financ_publico_inn_08_x100 * total_08
*gen total_publico_07 = financ_publico_inn_07_x100 * total_07


//FINANCIAMIENTO PRIVADO
*gen financ_privado_inn_08_x100 = 100 - financ_publico_inn_08_x100 
*gen financ_privado_inn_08_dummy=0
*replace financ_privado_inn_08_dummy  =1 if financ_privado_inn_08_x100>0

*gen financ_privado_inn_07_x100 = 100 - financ_publico_inn_07_x100 
*gen financ_privado_inn_07_dummy=0
*replace financ_privado_inn_07_dummy  =1 if financ_privado_inn_07_x100>0

*gen total_privado_08 = financ_privado_inn_08_x100 * total_08
*gen total_privado_07 = financ_privado_inn_07_x100 * total_07


//INNOVACION PRODUCTO NUEVO PARA EL MERCADO  
gen inn_producto= P3004
replace inn_producto= 0 if inn_producto==. 
gen inn_producto_dummy= inn_producto

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= P3024
replace inn_proceso= 0 if inn_proceso==. 
gen inn_proceso_dummy= inn_proceso


//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0


//COOPERACION

//PROVEEDORES
gen proveedores= P3168 + P3170
replace proveedores  =0 if proveedores==.
gen proveedores_dummy =0
replace proveedores_dummy  =1 if proveedores>0

//CLIENTES
gen clientes= P3172 + P3174
replace clientes  =0 if clientes==.   
gen clientes_dummy =0
replace clientes_dummy  =1 if clientes>0

//COMPETENCIA
gen competencia = P3176 + P3178
replace competencia  =0 if competencia ==.   
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0

//consultores y/o laboratorios y/o institutos privados
gen consultores_inst_privados= P3180 + P3182
replace consultores_inst_privados=0 if consultores_inst_privados==. 
gen consultores_inst_privados_dummy=0
replace consultores_inst_privados_dummy  =1 if consultores_inst_privados>0

//UNIVERSIDADES
*gen universidades = p3184 + p3186 
gen universidades = P3154
replace universidades  =0 if universidades==. 
gen universidades_dummy =0
replace universidades_dummy  =1 if universidades==1

//INST PUBLICOS
*gen inst_publicos = p3188
gen inst_publicos = P3157
replace inst_publicos  =0 if inst_publicos==. 
gen inst_publicos_dummy =0
replace inst_publicos_dummy  =1 if inst_publicos==1

//OBSTACULOS
gen obs_fondos_propios             = -1*(P3196-4)
gen obs_fin_externo                = -1*(P3197-4)
gen obs_info_tecnologia            = -1*(P3199-4)
gen obs_info_mercado        	   = -1*(P3200-4)
gen obs_empresa_establecida        = -1*(P3201-4)
gen obs_demanda_incierta           = -1*(P3202-4)
*gen obs_poco_dinamismo_tecnologico = -1*(P3204-4)
*gen obs_coop_otras_empresas        = -1*(P3205-4)
*gen obs_coop_inst_publicas         = -1*(P3206-4)

//EFECTOS DE LA INNOVACION
gen diversificacion_prod  = -1*(P3046-4)
gen participacion_mercado = -1*(P3047-4)
gen mejorar_calidad       = -1*(P3048-4)
gen reduccion_costos      = -1*(P3246-4)
*gen reduccion_energia     = -1*(P3050-4)


//INFLACIÓN
gen inf_09 = 1.0000
gen inf_10 = 1.0141

gen GD=cond(total_10==0,0,1)
gen gD=cond(total_09==0,0,1)

gen l = empleados_09
gen L = empleados_10

gen expD = exportaciones_09_dummy
gen EXPD = exportaciones_10_dummy

gen exp    = exportaciones_09/inf_09
gen EXP    = exportaciones_10/inf_10

gen k_ext= capital_extranjero_dummy  

gen licD   = inversion_licencias_09_dummy

gen lic = inversion_licencias_09/inf_09
gen LIC = inversion_licencias_10/inf_10

gen g = total_09/inf_09
gen G = total_10/inf_10

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn 

gen v = ventas_09/inf_09
gen V = ventas_10/inf_10

*gen k = capital_09/inf_09
*gen K  = capital_10/inf_10

gen patentes 	     = patentes_09/inf_09
gen capacitacion_inn = capacitacion_09/inf_09  
gen otras_inn	     = otras_09/inf_09        
gen introduccion_inn = introduccion_09/inf_09  
gen maquinaria_inn   = maquinaria_09/inf_09   

gen PATENTES 	     = patentes_10/inf_10
gen CAPACITACION_INN = capacitacion_10/inf_10  
gen OTRAS_INN	     = otras_10/inf_10        
gen INTRODUCCION_INN = introduccion_10/inf_10  
gen MAQUINARIA_INN   = maquinaria_10/inf_10

gen profesionales_tecnicos = profesionales_tecnicos_09
gen PROFESIONALES_TECNICOS = profesionales_tecnicos_10

save "C:\Users\fernando.greve\Dropbox\WP1\7.dta", replace
