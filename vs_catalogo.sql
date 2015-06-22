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
                    WHEN c.relname = ANY (ARRAY['municipio'::name, 'uf'::name, 'anexo'::name, 'cfop'::name, 'tab_basecalculocredito'::name, 'tab_csosn'::name, 'tab_cst_icms'::name, 'tab_cst_ipi'::name, 'tab_cst_pis_cofins'::name, 'tab_modbc'::name, 'tab_modbcst'::name, 'tab_modelofiscal'::name, 'tab_naturezadareceita'::name, 'tab_ncm'::name, 'tab_tipocontribuicaoapurada'::name, 'tab_tipocreditoapurado'::name, 'tab_contribuicaoprevidenciaria'::name, 'atividade'::name]) THEN 2
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
  OWNER TO xcompany;
