
    CREATE OR REPLACE FUNCTION audit_prestamo() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestamo', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestamo', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestamo', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS prestamo_audit_trigger ON prestamo;
    CREATE TRIGGER prestamo_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON prestamo
    FOR EACH ROW EXECUTE FUNCTION audit_prestamo();
    
    CREATE OR REPLACE FUNCTION audit_prestador() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestador', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestador', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('prestador', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    
    DROP TRIGGER IF EXISTS prestador_audit_trigger ON prestador;
    CREATE TRIGGER prestador_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON prestador
    FOR EACH ROW EXECUTE FUNCTION audit_prestador();
    