
        CREATE OR REPLACE FUNCTION sp_create_artista(p_('artistaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('nacionalidad', 'character varying') character varying, p_('fechanacimiento', 'date') date, p_('bibliografia', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO artista (artistaid, nombre, apellido, cedula, nacionalidad, fechanacimiento, bibliografia)
            VALUES (p_artistaid, p_nombre, p_apellido, p_cedula, p_nacionalidad, p_fechanacimiento, p_bibliografia);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_artista (p_id IN integer) RETURNS SETOF artista AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM artista
            WHERE artistaid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_artista (p_('artistaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('nacionalidad', 'character varying') character varying, p_('fechanacimiento', 'date') date, p_('bibliografia', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE artista
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, nacionalidad = p_nacionalidad, fechanacimiento = p_fechanacimiento, bibliografia = p_bibliografia
            WHERE artistaid = p_artistaid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_artista (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM artista
            WHERE artistaid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_compra(p_('compraid', 'integer') integer, p_('fechacompra', 'date') date, p_('total', 'numeric') numeric, p_('visitanteid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO compra (compraid, fechacompra, total, visitanteid)
            VALUES (p_compraid, p_fechacompra, p_total, p_visitanteid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_compra (p_id IN integer) RETURNS SETOF compra AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM compra
            WHERE compraid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_compra (p_('compraid', 'integer') integer, p_('fechacompra', 'date') date, p_('total', 'numeric') numeric, p_('visitanteid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE compra
            SET fechacompra = p_fechacompra, total = p_total, visitanteid = p_visitanteid
            WHERE compraid = p_compraid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_compra (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM compra
            WHERE compraid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_donacion(p_('donacionid', 'integer') integer, p_('descripcion', 'character varying') character varying, p_('fechadonacion', 'date') date, p_('museoid', 'integer') integer, p_('donanteid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO donacion (donacionid, descripcion, fechadonacion, museoid, donanteid)
            VALUES (p_donacionid, p_descripcion, p_fechadonacion, p_museoid, p_donanteid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_donacion (p_id IN integer) RETURNS SETOF donacion AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM donacion
            WHERE donacionid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_donacion (p_('donacionid', 'integer') integer, p_('descripcion', 'character varying') character varying, p_('fechadonacion', 'date') date, p_('museoid', 'integer') integer, p_('donanteid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE donacion
            SET descripcion = p_descripcion, fechadonacion = p_fechadonacion, museoid = p_museoid, donanteid = p_donanteid
            WHERE donacionid = p_donacionid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_donacion (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM donacion
            WHERE donacionid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_donante(p_('donanteid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('celular', 'character varying') character varying, p_('fechanacimiento', 'date') date) RETURNS VOID AS $$
        BEGIN
            INSERT INTO donante (donanteid, nombre, apellido, cedula, celular, fechanacimiento)
            VALUES (p_donanteid, p_nombre, p_apellido, p_cedula, p_celular, p_fechanacimiento);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_donante (p_id IN integer) RETURNS SETOF donante AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM donante
            WHERE donanteid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_donante (p_('donanteid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('celular', 'character varying') character varying, p_('fechanacimiento', 'date') date) RETURNS VOID AS $$
        BEGIN
            UPDATE donante
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, celular = p_celular, fechanacimiento = p_fechanacimiento
            WHERE donanteid = p_donanteid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_donante (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM donante
            WHERE donanteid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_empleado(p_('empleadoid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('salario', 'numeric') numeric, p_('fechaingreso', 'date') date, p_('fechasalida', 'date') date, p_('museoid', 'integer') integer, p_('rolid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO empleado (empleadoid, nombre, apellido, cedula, salario, fechaingreso, fechasalida, museoid, rolid)
            VALUES (p_empleadoid, p_nombre, p_apellido, p_cedula, p_salario, p_fechaingreso, p_fechasalida, p_museoid, p_rolid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_empleado (p_id IN integer) RETURNS SETOF empleado AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM empleado
            WHERE empleadoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_empleado (p_('empleadoid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('salario', 'numeric') numeric, p_('fechaingreso', 'date') date, p_('fechasalida', 'date') date, p_('museoid', 'integer') integer, p_('rolid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE empleado
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, salario = p_salario, fechaingreso = p_fechaingreso, fechasalida = p_fechasalida, museoid = p_museoid, rolid = p_rolid
            WHERE empleadoid = p_empleadoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_empleado (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM empleado
            WHERE empleadoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_entrada(p_('entradaid', 'integer') integer, p_('fechaentrada', 'date') date, p_('precio', 'numeric') numeric, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO entrada (entradaid, fechaentrada, precio, museoid)
            VALUES (p_entradaid, p_fechaentrada, p_precio, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_entrada (p_id IN integer) RETURNS SETOF entrada AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM entrada
            WHERE entradaid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_entrada (p_('entradaid', 'integer') integer, p_('fechaentrada', 'date') date, p_('precio', 'numeric') numeric, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE entrada
            SET fechaentrada = p_fechaentrada, precio = p_precio, museoid = p_museoid
            WHERE entradaid = p_entradaid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_entrada (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM entrada
            WHERE entradaid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_incidente(p_('incidenteid', 'integer') integer, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechaincidente', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO incidente (incidenteid, tipo, descripcion, fechaincidente, museoid)
            VALUES (p_incidenteid, p_tipo, p_descripcion, p_fechaincidente, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_incidente (p_id IN integer) RETURNS SETOF incidente AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM incidente
            WHERE incidenteid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_incidente (p_('incidenteid', 'integer') integer, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechaincidente', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE incidente
            SET tipo = p_tipo, descripcion = p_descripcion, fechaincidente = p_fechaincidente, museoid = p_museoid
            WHERE incidenteid = p_incidenteid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_incidente (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM incidente
            WHERE incidenteid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_mantenimiento(p_('mantenimientoid', 'integer') integer, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechamantenimiento', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO mantenimiento (mantenimientoid, tipo, descripcion, fechamantenimiento, museoid)
            VALUES (p_mantenimientoid, p_tipo, p_descripcion, p_fechamantenimiento, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_mantenimiento (p_id IN integer) RETURNS SETOF mantenimiento AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM mantenimiento
            WHERE mantenimientoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_mantenimiento (p_('mantenimientoid', 'integer') integer, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechamantenimiento', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE mantenimiento
            SET tipo = p_tipo, descripcion = p_descripcion, fechamantenimiento = p_fechamantenimiento, museoid = p_museoid
            WHERE mantenimientoid = p_mantenimientoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_mantenimiento (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM mantenimiento
            WHERE mantenimientoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_museo(p_('museoid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('ubicacion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO museo (museoid, nombre, ubicacion)
            VALUES (p_museoid, p_nombre, p_ubicacion);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_museo (p_id IN integer) RETURNS SETOF museo AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM museo
            WHERE museoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_museo (p_('museoid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('ubicacion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE museo
            SET nombre = p_nombre, ubicacion = p_ubicacion
            WHERE museoid = p_museoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_museo (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM museo
            WHERE museoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_obradearte(p_('obraid', 'integer') integer, p_('titulo', 'character varying') character varying, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechacreacion', 'date') date, p_('museoid', 'integer') integer, p_('artistaid', 'integer') integer, p_('ubicacionobraid', 'integer') integer, p_('donacionid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO obradearte (obraid, titulo, tipo, descripcion, fechacreacion, museoid, artistaid, ubicacionobraid, donacionid)
            VALUES (p_obraid, p_titulo, p_tipo, p_descripcion, p_fechacreacion, p_museoid, p_artistaid, p_ubicacionobraid, p_donacionid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_obradearte (p_id IN integer) RETURNS SETOF obradearte AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM obradearte
            WHERE obraid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_obradearte (p_('obraid', 'integer') integer, p_('titulo', 'character varying') character varying, p_('tipo', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('fechacreacion', 'date') date, p_('museoid', 'integer') integer, p_('artistaid', 'integer') integer, p_('ubicacionobraid', 'integer') integer, p_('donacionid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE obradearte
            SET titulo = p_titulo, tipo = p_tipo, descripcion = p_descripcion, fechacreacion = p_fechacreacion, museoid = p_museoid, artistaid = p_artistaid, ubicacionobraid = p_ubicacionobraid, donacionid = p_donacionid
            WHERE obraid = p_obraid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_obradearte (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM obradearte
            WHERE obraid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_patrocinador(p_('patrocinadorid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO patrocinador (patrocinadorid, nombre, apellido, descripcion, museoid)
            VALUES (p_patrocinadorid, p_nombre, p_apellido, p_descripcion, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_patrocinador (p_id IN integer) RETURNS SETOF patrocinador AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM patrocinador
            WHERE patrocinadorid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_patrocinador (p_('patrocinadorid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE patrocinador
            SET nombre = p_nombre, apellido = p_apellido, descripcion = p_descripcion, museoid = p_museoid
            WHERE patrocinadorid = p_patrocinadorid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_patrocinador (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM patrocinador
            WHERE patrocinadorid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_prestador(p_('prestadorid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('nacionalidad', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO prestador (prestadorid, nombre, apellido, cedula, nacionalidad)
            VALUES (p_prestadorid, p_nombre, p_apellido, p_cedula, p_nacionalidad);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_prestador (p_id IN integer) RETURNS SETOF prestador AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM prestador
            WHERE prestadorid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_prestador (p_('prestadorid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('nacionalidad', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE prestador
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, nacionalidad = p_nacionalidad
            WHERE prestadorid = p_prestadorid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_prestador (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM prestador
            WHERE prestadorid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_prestamo(p_('prestamoid', 'integer') integer, p_('fechaprestamo', 'date') date, p_('fechadevolucion', 'date') date, p_('motivo', 'character varying') character varying, p_('museoid', 'integer') integer, p_('prestadorid', 'integer') integer, p_('obraid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO prestamo (prestamoid, fechaprestamo, fechadevolucion, motivo, museoid, prestadorid, obraid)
            VALUES (p_prestamoid, p_fechaprestamo, p_fechadevolucion, p_motivo, p_museoid, p_prestadorid, p_obraid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_prestamo (p_id IN integer) RETURNS SETOF prestamo AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM prestamo
            WHERE prestamoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_prestamo (p_('prestamoid', 'integer') integer, p_('fechaprestamo', 'date') date, p_('fechadevolucion', 'date') date, p_('motivo', 'character varying') character varying, p_('museoid', 'integer') integer, p_('prestadorid', 'integer') integer, p_('obraid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE prestamo
            SET fechaprestamo = p_fechaprestamo, fechadevolucion = p_fechadevolucion, motivo = p_motivo, museoid = p_museoid, prestadorid = p_prestadorid, obraid = p_obraid
            WHERE prestamoid = p_prestamoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_prestamo (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM prestamo
            WHERE prestamoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_producto(p_('productoid', 'integer') integer, p_('compraid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('precio', 'numeric') numeric, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO producto (productoid, compraid, nombre, precio, descripcion)
            VALUES (p_productoid, p_compraid, p_nombre, p_precio, p_descripcion);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_producto (p_id IN integer) RETURNS SETOF producto AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM producto
            WHERE productoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_producto (p_('productoid', 'integer') integer, p_('compraid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('precio', 'numeric') numeric, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE producto
            SET compraid = p_compraid, nombre = p_nombre, precio = p_precio, descripcion = p_descripcion
            WHERE productoid = p_productoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_producto (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM producto
            WHERE productoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_productotienda(p_('productoid', 'integer') integer, p_('tiendaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('precio', 'numeric') numeric, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO productotienda (productoid, tiendaid, nombre, precio, descripcion)
            VALUES (p_productoid, p_tiendaid, p_nombre, p_precio, p_descripcion);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_productotienda (p_id IN integer) RETURNS SETOF productotienda AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM productotienda
            WHERE productoid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_productotienda (p_('productoid', 'integer') integer, p_('tiendaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('precio', 'numeric') numeric, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE productotienda
            SET tiendaid = p_tiendaid, nombre = p_nombre, precio = p_precio, descripcion = p_descripcion
            WHERE productoid = p_productoid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_productotienda (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM productotienda
            WHERE productoid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_propietario(p_('propietarioid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO propietario (propietarioid, nombre, apellido, cedula)
            VALUES (p_propietarioid, p_nombre, p_apellido, p_cedula);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_propietario (p_id IN integer) RETURNS SETOF propietario AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM propietario
            WHERE propietarioid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_propietario (p_('propietarioid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE propietario
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula
            WHERE propietarioid = p_propietarioid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_propietario (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM propietario
            WHERE propietarioid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_rol(p_('rolid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO rol (rolid, nombre, descripcion)
            VALUES (p_rolid, p_nombre, p_descripcion);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_rol (p_id IN integer) RETURNS SETOF rol AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM rol
            WHERE rolid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_rol (p_('rolid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('descripcion', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE rol
            SET nombre = p_nombre, descripcion = p_descripcion
            WHERE rolid = p_rolid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_rol (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM rol
            WHERE rolid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_tienda(p_('tiendaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('ubicacion', 'character varying') character varying, p_('museoid', 'integer') integer, p_('propietarioid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO tienda (tiendaid, nombre, descripcion, ubicacion, museoid, propietarioid)
            VALUES (p_tiendaid, p_nombre, p_descripcion, p_ubicacion, p_museoid, p_propietarioid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_tienda (p_id IN integer) RETURNS SETOF tienda AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM tienda
            WHERE tiendaid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_tienda (p_('tiendaid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('descripcion', 'character varying') character varying, p_('ubicacion', 'character varying') character varying, p_('museoid', 'integer') integer, p_('propietarioid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE tienda
            SET nombre = p_nombre, descripcion = p_descripcion, ubicacion = p_ubicacion, museoid = p_museoid, propietarioid = p_propietarioid
            WHERE tiendaid = p_tiendaid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_tienda (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM tienda
            WHERE tiendaid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_ubicacionobra(p_('ubicacionobraid', 'integer') integer, p_('piso', 'character varying') character varying, p_('seccion', 'character varying') character varying, p_('referencia', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            INSERT INTO ubicacionobra (ubicacionobraid, piso, seccion, referencia)
            VALUES (p_ubicacionobraid, p_piso, p_seccion, p_referencia);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_ubicacionobra (p_id IN integer) RETURNS SETOF ubicacionobra AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM ubicacionobra
            WHERE ubicacionobraid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_ubicacionobra (p_('ubicacionobraid', 'integer') integer, p_('piso', 'character varying') character varying, p_('seccion', 'character varying') character varying, p_('referencia', 'character varying') character varying) RETURNS VOID AS $$
        BEGIN
            UPDATE ubicacionobra
            SET piso = p_piso, seccion = p_seccion, referencia = p_referencia
            WHERE ubicacionobraid = p_ubicacionobraid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_ubicacionobra (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM ubicacionobra
            WHERE ubicacionobraid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_visitante(p_('visitanteid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('fechavisita', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO visitante (visitanteid, nombre, apellido, cedula, fechavisita, museoid)
            VALUES (p_visitanteid, p_nombre, p_apellido, p_cedula, p_fechavisita, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_visitante (p_id IN integer) RETURNS SETOF visitante AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM visitante
            WHERE visitanteid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_visitante (p_('visitanteid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('fechavisita', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE visitante
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, fechavisita = p_fechavisita, museoid = p_museoid
            WHERE visitanteid = p_visitanteid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_visitante (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM visitante
            WHERE visitanteid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_create_voluntario(p_('voluntarioid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('fechainicio', 'date') date, p_('fechafin', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            INSERT INTO voluntario (voluntarioid, nombre, apellido, cedula, fechainicio, fechafin, museoid)
            VALUES (p_voluntarioid, p_nombre, p_apellido, p_cedula, p_fechainicio, p_fechafin, p_museoid);
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_read_voluntario (p_id IN integer) RETURNS SETOF voluntario AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM voluntario
            WHERE voluntarioid = p_id;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_update_voluntario (p_('voluntarioid', 'integer') integer, p_('nombre', 'character varying') character varying, p_('apellido', 'character varying') character varying, p_('cedula', 'character varying') character varying, p_('fechainicio', 'date') date, p_('fechafin', 'date') date, p_('museoid', 'integer') integer) RETURNS VOID AS $$
        BEGIN
            UPDATE voluntario
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, fechainicio = p_fechainicio, fechafin = p_fechafin, museoid = p_museoid
            WHERE voluntarioid = p_voluntarioid;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        

        CREATE OR REPLACE FUNCTION sp_delete_voluntario (p_id IN integer) RETURNS VOID AS $$
        BEGIN
            DELETE FROM voluntario
            WHERE voluntarioid = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        