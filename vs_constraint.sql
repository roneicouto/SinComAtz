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
  OWNER TO xcompany;
