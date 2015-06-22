--PREPARAR SINCOM PARA ATUALIZAR
-- View: vs_catalogo

-- DROP VIEW vs_catalogo;

CREATE OR REPLACE VIEW vs_catalogo AS 
         SELECT c.oid AS id, 
            n.nspname AS schema, 
            c.relname::text AS nome, 
                CASE c.relkind
                    WHEN 'r'::"char" THEN 'Table'::text
                    WHEN 'v'::"char" THEN 'View'::text
                    WHEN 'i'::"char" THEN 'index'::text
                    WHEN 'S'::"char" THEN 'Sequence'::text
                    WHEN 'c'::"char" THEN 'Type'::text
                    WHEN 's'::"char" THEN 'special'::text
                    ELSE c.relkind::text
                END AS tipo, 
                CASE
                    WHEN c.relname = ANY (ARRAY['cep_bairros'::name, 'cep_cidades'::name, 'cep_enderecos'::name]) THEN 1
                    WHEN c.relname = ANY (ARRAY['bancos_padrao'::name, 'ceps'::name, 'document'::name, 'dre_contas'::name, 'dre_grupos'::name, 'dre_modelos'::name,
                     'natoperac'::name,'paf_softhouse'::name, 'tab_uf'::name,'tab_municipios'::name, 'tab_ncm'::name]) THEN 2
                    ELSE 3
                END AS tipodesincronismodedados, 
            pg_size_pretty(pg_total_relation_size(c.oid::regclass))::character varying(15) AS tamanho, 
            ''::text AS scopo
           FROM pg_class c
      LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
     WHERE (c.relkind = ANY (ARRAY['r'::"char", 'v'::"char", 'S'::"char", 'c'::"char"])) AND n.nspname = "current_schema"()
UNION 
         SELECT p.oid AS id, 
            n.nspname AS schema, 
            ((quote_ident(p.proname::text) || '('::text) || oidvectortypes(p.proargtypes)) || ')'::text AS nome, 
            'Function'::text AS tipo, 
            1 AS tipodesincronismodedados, 
            ''::character varying(15) AS tamanho, 
            p.proargnames::text AS scopo
           FROM pg_proc p
      LEFT JOIN pg_namespace n ON n.oid = p.pronamespace
     WHERE n.nspname = "current_schema"();

ALTER TABLE vs_catalogo
  OWNER TO postgres;


  -- View: vs_constraint

-- DROP VIEW vs_constraint;

CREATE OR REPLACE VIEW vs_constraint AS 
 SELECT ct.constraint_schema, 
    r.conname, 
    ct.table_name, 
    pg_get_constraintdef(r.oid, true) AS condef, 
    ct.constraint_type
   FROM information_schema.table_constraints ct
   LEFT JOIN pg_constraint r ON r.conname = ct.constraint_name::name
  WHERE ct.constraint_schema::name = "current_schema"() AND (ct.constraint_type::text = ANY (ARRAY['UNIQUE'::character varying::text, 'PRIMARY KEY'::character varying::text, 'FOREIGN KEY'::character varying::text]));

ALTER TABLE vs_constraint
  OWNER TO postgres;

-- View: vs_indexes

-- DROP VIEW vs_indexes;

CREATE OR REPLACE VIEW vs_indexes AS 
 SELECT c.relname AS table_name, 
    pg_get_indexdef(i.indexrelid, 0, true) AS column_name, 
    n.nspname AS schema, 
    pg_size_pretty(pg_total_relation_size(c.oid::regclass))::character varying(15) AS total_index_size, 
    c2.relname AS tabela
   FROM pg_class c
   JOIN pg_index i ON i.indexrelid = c.oid
   JOIN pg_class c2 ON i.indrelid = c2.oid
   LEFT JOIN pg_user u ON u.usesysid = c.relowner
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE NOT i.indisprimary AND (c.relkind = ANY (ARRAY['i'::"char", ''::"char"])) AND (n.nspname <> ALL (ARRAY['pg_catalog'::name, 'pg_toast'::name])) AND pg_table_is_visible(c.oid)
  ORDER BY c.relname, pg_get_indexdef(i.indexrelid, 0, true);

ALTER TABLE vs_indexes
  OWNER TO postgres;

-- View: vs_trigger_definicao

-- DROP VIEW vs_trigger_definicao;

CREATE OR REPLACE VIEW vs_trigger_definicao AS 
 SELECT DISTINCT tr.oid, 
    n.nspname AS schemaname, 
    c.relname AS tablename, 
    tr.tgname AS triggername, 
    pr.proname AS function_name, 
    pg_get_function_result(pr.oid) AS "Result data type", 
    pg_get_function_arguments(pr.oid) AS "Argument data types", 
        CASE
            WHEN pr.proisagg THEN 'agg'::text
            WHEN pr.proiswindow THEN 'window'::text
            WHEN pr.prorettype = 'trigger'::regtype::oid THEN 'trigger'::text
            ELSE 'normal'::text
        END AS "Type", 
        CASE
            WHEN pr.prorettype = 'trigger'::regtype::oid THEN pg_get_triggerdef(tr.oid)
            ELSE NULL::text
        END AS trigger_def
   FROM pg_class c
   JOIN pg_attribute a ON a.attrelid = c.oid
   JOIN pg_type t ON t.oid = a.atttypid
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
   LEFT JOIN pg_tablespace ts ON ts.oid = c.reltablespace
   LEFT JOIN pg_trigger tr ON tr.tgrelid::regclass::text = (
CASE
WHEN n.nspname <> 'public'::name THEN n.nspname::text || '.'::text
ELSE ''::text
END || c.relname::text)
   LEFT JOIN pg_proc pr ON pr.oid = tr.tgfoid
  WHERE a.attnum > 0 AND NOT a.attisdropped AND tr.tgisinternal IS NOT TRUE AND tr.tgname IS NOT NULL
  ORDER BY n.nspname, c.relname;

ALTER TABLE vs_trigger_definicao
  OWNER TO postgres;

-- View: vs_triggers

-- DROP VIEW vs_triggers;

CREATE OR REPLACE VIEW vs_triggers AS 
 SELECT triggers.trigger_catalog, 
    triggers.trigger_schema, 
    triggers.trigger_name, 
    triggers.event_manipulation, 
    triggers.event_object_catalog, 
    triggers.event_object_schema, 
    triggers.event_object_table, 
    triggers.action_order, 
    triggers.action_condition, 
    triggers.action_statement, 
    triggers.action_orientation, 
    triggers.action_timing, 
    triggers.action_reference_old_table, 
    triggers.action_reference_new_table, 
    triggers.action_reference_old_row, 
    triggers.action_reference_new_row, 
    triggers.created
   FROM information_schema.triggers;

ALTER TABLE vs_triggers
  OWNER TO postgres;

-- Function: compara_estrutura(character, character, character, character)

-- DROP FUNCTION compara_estrutura(character, character, character, character);

CREATE OR REPLACE FUNCTION compara_estrutura(pschemaorigem character, ptabelaorigem character, pschemadestino character, ptabeladestino character)
  RETURNS text AS
$BODY$DECLARE
  TabelaOrigem    record;
  TabelaDestino   record;
  Retorno Text;
  retorno2 Text;
contador integer;
 
  r text; 
begin 

 Retorno := '';

    Select into TabelaOrigem 
            *            
       from
          pg_class
          LEFT JOIN pg_catalog.pg_namespace n
							 ON n.oid = pg_class.relnamespace
       where 
        (lower(nspname),lower(relname))=(lower(pschemadestino),lower(ptabeladestino));
  if not found THEN

     Retorno := script_create(pTabelaOrigem, 'Table', pschemaorigem,false,'');
     Retorno := replace(Retorno,  'Create ' || ptabeladestino , 'Create ' ||    pschemadestino  || '.' || ptabeladestino );
  Else

				contador := 0;
        retorno2 := '';
				for TabelaOrigem IN
						 Select
									nomecoluna column_name,
									 formato tipo,
									 aceitanulo,
	                 replace(valordefault,'atualizacao.','')  valor_default
									--	case When lower(valordefault) like 'nextval%' Then '' else valordefault end valor_default
									
						 from
							pg_class
							 LEFT JOIN pg_catalog.pg_namespace n
							 ON n.oid = pg_class.relnamespace
							 LEFT JOIN atributos_colunas on idobjeto = pg_class.oid      
						 where 
							 (lower(nspname),lower(relname))=(lower(pschemaorigem),lower(ptabelaorigem))
				 loop
							
							 Select into TabelaDestino 
									 nomecoluna column_name,
									 formato tipo,
									 aceitanulo,
								 	valordefault  valor_default
										
							 from
								pg_class
								 LEFT JOIN pg_catalog.pg_namespace n
								 ON n.oid = pg_class.relnamespace
								 LEFT JOIN atributos_colunas on idobjeto = pg_class.oid      
							 where 
								 (lower(nspname),lower(relname), nomecoluna)=(lower(pschemadestino),lower(ptabeladestino),TabelaOrigem.column_name);
							 
							 if Found THEN

									if (TabelaOrigem.tipo,TabelaOrigem.aceitanulo,Coalesce(TabelaOrigem.valor_default,'semvalor') ) <>  (TabelaDestino.tipo,TabelaDestino.aceitanulo,Coalesce(TabelaDestino.valor_default ,'semvalor')) THEN
									
                      if   Tabeladestino.aceitanulo  and not TabelaOrigem.aceitanulo THEN
                          
													case Trim(Left(TabelaDestino.tipo,7))  
																When  
																	'real',
																	'numeric',
																	'bigint',
																	'oid',
																	'smallint',
																	'double precision'

																THEN
																	 retorno2 := retorno2 || case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  || 
                                  case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = 0' End;
																WHEN 
																	'real[]',
																	'numeric[]',
																	'bigint[]',
																	'oid[]',
																	'smallint[]',
																	'double precision[]'

																THEN
																	 retorno2 := retorno2 ||  case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  || 
                                   case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = ' || '''{0}''' end;
																	
																WHEN 
																	'date'																	
																THEN
																	 retorno2 := retorno2 || case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  ||
                                   case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = ' || '''19000101''' end;   
														
																WHEN 
																	'date[]'
																THEN
																	 retorno2 := retorno2 ||  case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  || ' = ' || '''{19000101}''';   																
																WHEN 
																	'boolean'
																THEN
																	 retorno2 := retorno2 ||  case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  || ' =  false';   
																WHEN 
																	'boolean[]'
																THEN
																	 retorno2 := retorno2 || case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  ||
                                   case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = ' || '''{false}''' end;   
																ELSE
																	 if TabelaDestino.tipo like '%[]%' THEN
																			retorno2 := retorno2 ||  case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  ||
                                   case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = ' || '''{}''' end;   
																	 ELSE
																			retorno2 := retorno2 ||  case When contador = 0 Then   ' set ' else ',' end || TabelaDestino.column_name  ||
                                      case When  Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' = ' || TabelaOrigem.valor_default Else ' = ' || '''''' end;   
																	 End IF;
																END CASE;
										      contador := 1;
                      End if; 

                      if TabelaOrigem.tipo <> TabelaDestino.tipo Then 
													retorno := Retorno  || case When Retorno <> '' Then ';' Else '' end || 'alter table ' || 
													pschemadestino || '.' || ptabeladestino || ' alter  column ' || 
													Tabelaorigem.column_name || ' type ' || tabelaorigem.tipo  || 
                          ' using ' || tabelaorigem.column_name || '::' || case TabelaOrigem.tipo when 'serial' Then 'integer' else tabelaorigem.tipo end;
                      End If;
                      if TabelaOrigem.aceitanulo <> TabelaDestino.aceitanulo Then 
                          retorno := Retorno  || case When Retorno <> '' Then ';' Else '' end || 'alter table ' || pschemadestino || '.' || ptabeladestino || ' alter  column ' || Tabelaorigem.column_name ||  case when tabelaorigem.aceitanulo Then ' drop not null ' 
                         Else ' set not null ' End || chr(13) || chr(10); 
                      End If;

                       if  Coalesce(TabelaOrigem.valor_default,'semvalor') <>  Coalesce(TabelaDestino.valor_default,'semvalor') Then 
                     
                          retorno := Retorno  || case When Retorno <> '' Then ';' Else '' end || 'alter table ' || pschemadestino || '.' || ptabeladestino || ' alter  column ' || Tabelaorigem.column_name || 
                         case when Coalesce(TabelaOrigem.valor_default,'semvalor') = 'semvalor' Then ' drop default ' 
                         Else ' set default  ' || tabelaorigem.Valor_default  End ; 
                      End If;

									
									End if; 
			 
								ELSE

									retorno := Retorno  || case When Retorno <> '' Then ';' Else '' end || 'alter table ' || 
								pschemadestino || '.' || ptabeladestino || ' add  column ' || 
											Tabelaorigem.column_name || ' ' || tabelaorigem.tipo   ||
										case when tabelaorigem.aceitanulo Then '' Else '  not null ' End  || 
										case When Coalesce(TabelaOrigem.valor_default,'semvalor') <> 'semvalor' Then ' Default  ' || TabelaOrigem.valor_default  else ' '  End  ; 
								End If;  
								-- RETURN Retorno;	
				
				 end loop;


				for TabelaOrigem IN
						 Select
									nomecoluna column_name
									
									
						 from
							pg_class
							 LEFT JOIN pg_catalog.pg_namespace n
							 ON n.oid = pg_class.relnamespace
							 LEFT JOIN atributos_colunas on idobjeto = pg_class.oid      
						 where 
							 (lower(nspname),lower(relname))=(lower(pschemadestino),lower(ptabeladestino))
				 loop
							
							 Select into TabelaDestino 
									 nomecoluna column_name
										
							 from
								pg_class
								 LEFT JOIN pg_catalog.pg_namespace n
								 ON n.oid = pg_class.relnamespace
								 LEFT JOIN atributos_colunas on idobjeto = pg_class.oid      
							 where 
								 (lower(nspname),lower(relname), nomecoluna)=(lower(pschemaorigem),lower(ptabelaorigem),TabelaOrigem.column_name);
							-- return  lower(pschemadestino) || lower(ptabeladestino) || TabelaOrigem.column_name;
							 if not Found THEN
								retorno := Retorno    || case When Retorno <> '' Then ';' Else '' end || 'alter table ' || 
						     		pschemadestino || '.' || ptabeladestino || ' drop  column ' || Tabelaorigem.column_name ;

								End If;  
								-- RETURN Retorno;	
				
				 end loop;

  End If; 
  if contador = 1 THEN
     Retorno := 'update ' || pschemadestino || '.' || ptabeladestino || ' ' || Retorno2  ||   case When Retorno <> '' Then ';' Else '' end  || retorno;
  End if;

  RETURN Retorno;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION compara_estrutura(character, character, character, character)
  OWNER TO postgres;


-- Function: script_create(character, character, character, boolean, character)

-- DROP FUNCTION script_create(character, character, character, boolean, character);

CREATE OR REPLACE FUNCTION script_create(pobjeto character, ptipo character, pschema character, patualizacao boolean, pscopo character)
  RETURNS text AS
$BODY$ DECLARE 
      REC RECORD;
      DESCRICAO Text;
      Contador integer;
      linguagem Text;


BEGIN
contador := 0;

if ptipo = 'Table' THEN
   Descricao := 'Create table ' || case When pAtualizacao Then 'atualizacao.' Else 	'' End || pobjeto ||chr(13) || chr(10) || '		' || '(' || chr(13) || chr(10); 
   for REC IN
				 Select
						 nomecoluna column_name,
						 formato tipo,
						 aceitanulo,
						 valordefault valor_default
							
				 from
					pg_class
					 LEFT JOIN pg_catalog.pg_namespace n
					 ON n.oid = pg_class.relnamespace
					 JOIN atributos_colunas on idobjeto = pg_class.oid      
				 where 
					 lower(nspname)=lower(pschema) and relname=pobjeto


   Loop
      Descricao := Descricao ||   case When contador > 0 Then ','  else '' End || chr(13) || chr(10)  || '		' || Trim(Rec.column_name) || ' ' ||  Case When lower(REC.Valor_default) like '%nextval%' Then ' Serial ' else    Trim(REC.tipo) End || '  ' || case When  not  REC.aceitanulo='YES' Then 'Not Null' else '' End ||  case When REC.Valor_default <> '' Then Case When lower(REC.Valor_default) like '%nextval%' Then '  ' else ' Default ' ||  REC.valor_default  end else '' end ;
      contador := 1;
   End Loop;

   Descricao := Descricao ||chr(13) || chr(10) || '		' || ')';
   
 				

elseif pTipo ='View' Then
   Descricao := 'Create View ' ||  pobjeto || chr(13) || chr(10) || '		' || ' as ' || chr(13) || chr(10); 
   for REC IN
    	 Select 
            view_definition 
       from 
          information_schema.views 
       where 
         table_name = pobjeto  and table_schema = pSchema
   Loop
      contador := 1;
      Descricao := Descricao ||   REC.view_definition || chr(13) || chr(10) ;
   End Loop;

elseif pTipo ='Sequence' Then

   Descricao := 'Create Sequence  ' || pobjeto || chr(13) || chr(10); 
   for REC IN
    	 Select 
            * 
       from 
          information_schema.sequences
       where 
         sequence_name = pobjeto and sequence_schema = pschema
   Loop
      contador := 1;
  
      Descricao := Descricao ||   ' INCREMENT ' || REC.increment || ' MINVALUE ' || REC.minimum_value || ' MAXVALUE ' || REC.maximum_value || ' START ' || REC.start_value;
   End Loop;

elseif pTipo like  '%Function%' Then



    select into  rec pg_get_functiondef(p.oid) definicao from pg_proc  p  LEFT JOIN pg_namespace n ON  n.oid = pronamespace where quote_ident(proname) || '(' || oidvectortypes(proargtypes)
                || ')'  =  pobjeto and  nspname = pschema;

   
    Descricao := '';

   if found Then
      contador := 1;
      Descricao := REC.definicao; 
    End If;
  

    
   

Elseif ptipo = 'Type' THEN
   Descricao := 'Create type '  || pobjeto || ' as '  ||chr(13) || chr(10) || '		' || '(' || chr(13) || chr(10); 
    for REC IN
       Select
           nomecoluna column_name,
           formato tipo,
           aceitanulo,
           valordefault valor_default
            
       from
        pg_class
         LEFT JOIN pg_catalog.pg_namespace n
         ON n.oid = pg_class.relnamespace
         LEFT JOIN atributos_colunas on idobjeto = pg_class.oid      
       where 
         lower(nspname)=lower(pschema) and relname=pobjeto

   Loop
      Descricao := Descricao ||   case When contador > 0 Then ','  else '' End || chr(13) || chr(10)  || '		' || Trim(Rec.column_name) || ' ' ||  Case When lower(REC.Valor_default) like '%nextval%' Then ' Serial ' else    Trim(REC.tipo) End || '  ' || case When  not  REC.aceitanulo='YES' Then 'Not Null' else '' End ||  case When REC.Valor_default <> '' Then Case When lower(REC.Valor_default) like '%nextval%' Then '  ' else ' Default ' ||  REC.valor_default  end else '' end ;
      contador := 1;
   End Loop;

   Descricao := Descricao ||chr(13) || chr(10) || '		' || ')';
  

End If;
  if contador = 0 THEN 
      Descricao := '';
  End If;  
  Return Descricao;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION script_create(character, character, character, boolean, character)
  OWNER TO postgres;


-- Function: script_drop(character, character, character, boolean)

-- DROP FUNCTION script_drop(character, character, character, boolean);

CREATE OR REPLACE FUNCTION script_drop(pobjeto character, ptipo character, pschema character, pexecutar boolean)
  RETURNS text AS
$BODY$ DECLARE 
      REC RECORD;
      DESCRICAO Text;
      Contador integer;
      linguagem Text;

BEGIN
contador := 0;
if ptipo = 'Table' THEN
    Descricao := 'DROP  Table ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 				

elseif pTipo ='View' Then
     Descricao := 'DROP  View ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
elseif pTipo ='Sequence' Then

     Descricao := 'DROP  Sequence ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
elseif pTipo like  '%Function%' Then
    Descricao := 'DROP  Function ' ||  pschema || '.' || pobjeto   ||chr(13) || chr(10);
    
   

Elseif ptipo = 'Type' THEN
   Descricao := 'DROP  TYPE ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
End If;
  Return Descricao;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION script_drop(character, character, character, boolean)
  OWNER TO postgres;



-- Function: script_drop(character, character, character, character, boolean)

-- DROP FUNCTION script_drop(character, character, character, character, boolean);

CREATE OR REPLACE FUNCTION script_drop(pobjeto character, ptipo character, pschema character, pscopo character, pexecutar boolean)
  RETURNS text AS
$BODY$ DECLARE 
      REC RECORD;
      DESCRICAO Text;
      Contador integer;
      linguagem Text;

BEGIN
contador := 0;
if ptipo = 'Table' THEN
    Descricao := 'DROP  Table ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 				

elseif pTipo ='View' Then
     Descricao := 'DROP  View ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
elseif pTipo ='Sequence' Then

     Descricao := 'DROP  Sequence ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
elseif pTipo like  '%Function%' Then

select into REC 
            'DROP FUNCTION ' || quote_ident(ns.nspname) || '.'
                || quote_ident(proname) || '(' || oidvectortypes(proargtypes)
                || ');' AS definicao
            FROM
               pg_proc
            INNER JOIN
               pg_namespace ns
           ON
               (pg_proc.pronamespace = ns.oid)
        WHERE
            ns.nspname = pschema

        AND   proname = pObjeto;


 
   if found Then
       Descricao  :=  REC.definicao;
    End If;
  

    
   

Elseif ptipo = 'Type' THEN
   Descricao := 'DROP  TYPE ' ||  pschema || '.' || pobjeto || ' 	CASCADE '  ||chr(13) || chr(10);
 
End If;
  if pExecutar THEN

     execute Descricao;
  End If;
  Return Descricao;
END
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION script_drop(character, character, character, character, boolean)
  OWNER TO postgres;


-- View: atributos_colunas

-- DROP VIEW atributos_colunas;

CREATE OR REPLACE VIEW atributos_colunas AS 
 SELECT a.attrelid AS idobjeto, 
    a.attname AS nomecoluna, 
    format_type(a.atttypid, a.atttypmod) AS formato, 
    ( SELECT "substring"(d.adsrc, 1, 128) AS "substring"
           FROM pg_attrdef d
          WHERE d.adrelid = a.attrelid AND d.adnum = a.attnum AND a.atthasdef) AS valordefault, 
    NOT a.attnotnull AS aceitanulo, 
    a.attnum
   FROM pg_attribute a
  WHERE a.attnum > 0 AND format_type(a.atttypid, a.atttypmod) <> '-'::text;

ALTER TABLE atributos_colunas
  OWNER TO postgres;
REVOKE ALL ON TABLE atributos_colunas FROM public;
REVOKE ALL ON TABLE atributos_colunas FROM postgres;






