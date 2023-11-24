drop _all
*insheet using "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6k.csv", comma
*save "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6k.dta", replace

*import excel "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6.xlsx", sheet("ATRIBUTOS") firstrow

use C:\Users\fernando.greve\Dropbox\23-12-2012\6\6_manufactura_v0.dta

*save "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6v0.dta", replace

*drop _merge
*merge  using "C:\Users\fernando.greve\Dropbox\23-12-2012\6\6k.dta"
*drop _merge 

gen encuesta = 6

//REGION
*region está creada por default

//PROPIEDAD porcentaje
gen nacional_porcentaje   = p026
gen extranjera_porcentaje = p027

//SECTORES
*gen categoria = categoria

//AÑO
gen año = p024
gen edad = 2008-año

//TRABAJO
gen empleados_08= p205 + p207
gen empleados_07= p204 + p206

gen profesionales_tecnicos_07 = p208
gen profesionales_tecnicos_08 = p209

//VENTAS
gen ventas_07= p200
gen ventas_08= p201

//VENTAS INNOVADORAS (porcentaje)
gen ventas_inn_porcentaje_07 = (p3014+p3016)/100 
gen ventas_inn_porcentaje_08 = (p3015+p3017)/100

//EXPORTACIONES
gen exportaciones_08= p203 
gen exportaciones_07= p202

gen exportaciones_08_dummy = 0
gen exportaciones_07_dummy = 0

replace exportaciones_08_dummy =1 if exportaciones_08>0
replace exportaciones_07_dummy =1 if exportaciones_07>0


//INVERSION EN LICENCIAS
gen inversion_licencias_08=p3087
gen inversion_licencias_07=p3086

gen inversion_licencias_08_dummy = 0
gen inversion_licencias_07_dummy = 0

replace inversion_licencias_08_dummy =1 if inversion_licencias_08>0
replace inversion_licencias_07_dummy =1 if inversion_licencias_07>0


//PROPIEDAD EXTRANJERA
gen capital_extranjero  = p027
gen capital_extranjero_dummy =1
replace capital_extranjero_dummy  =0 if capital_extranjero ==0


//dummies sectoriales
gen CIIU2_31=0
gen CIIU2_32=0
gen CIIU2_33=0
gen CIIU2_34=0
gen CIIU2_35=0
gen CIIU2_36=0
gen CIIU2_37=0
gen CIIU2_38=0
gen CIIU2_39=0

replace CIIU2_31=1 if ciiu_2_digit==31
replace CIIU2_32=1 if ciiu_2_digit==32
replace CIIU2_33=1 if ciiu_2_digit==33
replace CIIU2_34=1 if ciiu_2_digit==34
replace CIIU2_35=1 if ciiu_2_digit==35
replace CIIU2_36=1 if ciiu_2_digit==36
replace CIIU2_37=1 if ciiu_2_digit==37
replace CIIU2_38=1 if ciiu_2_digit==38
replace CIIU2_39=1 if ciiu_2_digit==39

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
gen inn_07=  gasto_inn2007  
gen inn_08=  gasto_inn2008

gen id_08= gasto_id12008 + gasto_id22008 + gasto_id32008
gen id_07= gasto_id12007 + gasto_id22007 + gasto_id32007

replace inn_08= 0 if inn_08==. 
replace inn_07= 0 if inn_07==. 

replace id_08= 0 if id_08==. 
replace id_07= 0 if id_07==.


gen total_08 = inn_08 + id_08  
gen total_07 = inn_07 + id_07

gen patentes_07     = p3086
gen capacitacion_07 = p3088
gen otras_07        = p3092
gen introduccion_07 = p3090
gen maquinaria_07   = p3084

gen patentes_08     = p3087
gen capacitacion_08 = p3089
gen otras_08        = p3093
gen introduccion_08 = p3091
gen maquinaria_08   = p3085

//FINANCIAMIENTO PUBLICO
gen financ_publico_inn_07_x100=  p3098
gen financ_publico_inn_08_x100=  p3099
replace financ_publico_inn_07_x100 =0 if total_07==0
replace financ_publico_inn_08_x100 =0 if total_08==0
replace financ_publico_inn_07_x100=0  if financ_publico_inn_07_x100==.
replace financ_publico_inn_08_x100=0  if financ_publico_inn_08_x100==.

gen financ_publico_inn_07_dummy  =0
replace financ_publico_inn_07_dummy  =1 if financ_publico_inn_07_x100 >0

gen financ_publico_inn_08_dummy  =0
replace financ_publico_inn_08_dummy  =1 if financ_publico_inn_08_x100 >0   

gen total_publico_08 = financ_publico_inn_08_x100 * total_08
gen total_publico_07 = financ_publico_inn_07_x100 * total_07


//FINANCIAMIENTO PRIVADO
gen financ_privado_inn_08_x100 = 100 - financ_publico_inn_08_x100 
gen financ_privado_inn_08_dummy=0
replace financ_privado_inn_08_dummy  =1 if financ_privado_inn_08_x100>0

gen financ_privado_inn_07_x100 = 100 - financ_publico_inn_07_x100 
gen financ_privado_inn_07_dummy=0
replace financ_privado_inn_07_dummy  =1 if financ_privado_inn_07_x100>0

gen total_privado_08 = financ_privado_inn_08_x100 * total_08
gen total_privado_07 = financ_privado_inn_07_x100 * total_07


//INNOVACION PRODUCTO NUEVO PARA EL MERCADO  
gen inn_producto= p3004
replace inn_producto= 0 if inn_producto==. 
gen inn_producto_dummy= inn_producto

//INNOVACION EN PROCESOS TECNOLOGICOS NUEVOS
gen inn_proceso= p3024
replace inn_proceso= 0 if inn_proceso==. 
gen inn_proceso_dummy= inn_proceso


//innovacion de producto y/o proceso
gen inn_producto_o_proceso = inn_proceso_dummy + inn_producto_dummy 
gen inn_producto_o_proceso_dummy = 1
replace inn_producto_o_proceso_dummy =0 if inn_producto_o_proceso == 0


//COOPERACION

//PROVEEDORES
gen proveedores= p3168 + p3170
replace proveedores  =0 if proveedores==.
gen proveedores_dummy =0
replace proveedores_dummy  =1 if proveedores>0

//CLIENTES
gen clientes= p3172 + p3174
replace clientes  =0 if clientes==.   
gen clientes_dummy =0
replace clientes_dummy  =1 if clientes>0

//COMPETENCIA
gen competencia = p3176 + p3178
replace competencia  =0 if competencia ==.   
gen competencia_dummy =0
replace competencia_dummy  =1 if competencia >0

//consultores y/o laboratorios y/o institutos privados
gen consultores_inst_privados= p3180 + p3182
replace consultores_inst_privados=0 if consultores_inst_privados==. 
gen consultores_inst_privados_dummy=0
replace consultores_inst_privados_dummy  =1 if consultores_inst_privados>0

//UNIVERSIDADES
*gen universidades = p3184 + p3186 
gen universidades = p3154
replace universidades  =0 if universidades==. 
gen universidades_dummy =1
replace universidades_dummy  =0 if universidades==0

//INST PUBLICOS
*gen inst_publicos = p3188
gen inst_publicos = p3157
replace inst_publicos  =0 if inst_publicos==. 
gen inst_publicos_dummy =1
replace inst_publicos_dummy  = 0 if inst_publicos==0

//OBSTACULOS
gen obs_fondos_propios             = -1*(p3196-5)
gen obs_fin_externo                = -1*(p3197-5)
gen obs_info_tecnologia            = -1*(p3199-5)
gen obs_info_mercado        	   = -1*(p3200-5)
gen obs_empresa_establecida        = -1*(p3201-5)
gen obs_demanda_incierta           = -1*(p3202-5)
gen obs_poco_dinamismo_tecnologico = -1*(p3204-5)
gen obs_coop_otras_empresas        = -1*(p3205-5)
gen obs_coop_inst_publicas         = -1*(p3206-5)

//EFECTOS DE LA INNOVACION
gen diversificacion_prod  = -1*(p3046-5)
gen participacion_mercado = -1*(p3047-5)
gen mejorar_calidad       = -1*(p3048-5)
gen reduccion_costos      = -1*(p3049-5)
gen reduccion_energia     = -1*(p3050-5)


//INFLACIÓN
gen inf_08 = 0.9854
gen inf_07 = 0.9064

gen GD=cond(total_08==0,0,1)
gen gD=cond(total_07==0,0,1)

gen l = empleados_07
gen L = empleados_08

gen expD = exportaciones_07_dummy
gen EXPD = exportaciones_08_dummy

gen exp    = exportaciones_07/inf_07
gen EXP    = exportaciones_08/inf_08

gen k_ext= capital_extranjero_dummy  

gen licD   = inversion_licencias_07_dummy

gen lic = inversion_licencias_07/inf_07
gen LIC = inversion_licencias_08/inf_08

gen g = total_07/inf_07
gen G = total_08/inf_08

gen inn  = inn_producto_o_proceso_dummy
gen prod = inn_producto_dummy
gen proc = inn_proceso_dummy

gen fin = financ_publico_inn_08_dummy 

gen v = ventas_07/inf_07
gen V = ventas_08/inf_08

*gen k = capital_07/inf_07
*gen K  = capital_08/inf_08

gen patentes 	     = patentes_07/inf_07
gen capacitacion_inn = capacitacion_07/inf_07  
gen otras_inn	     = otras_07/inf_07        
gen introduccion_inn = introduccion_07/inf_07  
gen maquinaria_inn   = maquinaria_07/inf_07   
gen gasto_id         = id_07/inf_07

gen PATENTES 	     = patentes_08/inf_08
gen CAPACITACION_INN = capacitacion_08/inf_08  
gen OTRAS_INN	     = otras_08/inf_08        
gen INTRODUCCION_INN = introduccion_08/inf_08  
gen MAQUINARIA_INN   = maquinaria_08/inf_08
gen GASTO_ID         = id_08/inf_08

gen profesionales_tecnicos = profesionales_tecnicos_07
gen PROFESIONALES_TECNICOS = profesionales_tecnicos_08

save "C:\Users\fernando.greve\Dropbox\WP1\6_manufactura.dta", replace
