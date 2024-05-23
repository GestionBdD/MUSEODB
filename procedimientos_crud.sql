
        CREATE OR REPLACE PROCEDURE sp_create_artista(p_('ARTISTAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('NACIONALIDAD', 'VARCHAR2') VARCHAR2, p_('FECHANACIMIENTO', 'DATE') DATE, p_('BIBLIOGRAFIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO artista (artistaid, nombre, apellido, cedula, nacionalidad, fechanacimiento, bibliografia)
            VALUES (p_artistaid, p_nombre, p_apellido, p_cedula, p_nacionalidad, p_fechanacimiento, p_bibliografia);
            COMMIT;
        END sp_create_artista;
        

        CREATE OR REPLACE PROCEDURE sp_read_artista (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT artistaid, nombre, apellido, cedula, nacionalidad, fechanacimiento, bibliografia
            FROM artista
            WHERE artistaid = p_id;
        END sp_read_artista;
        

        CREATE OR REPLACE PROCEDURE sp_update_artista (p_('ARTISTAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('NACIONALIDAD', 'VARCHAR2') VARCHAR2, p_('FECHANACIMIENTO', 'DATE') DATE, p_('BIBLIOGRAFIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE artista
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, nacionalidad = p_nacionalidad, fechanacimiento = p_fechanacimiento, bibliografia = p_bibliografia
            WHERE artistaid = p_artistaid;
            COMMIT;
        END sp_update_artista;
        

        CREATE OR REPLACE PROCEDURE sp_delete_artista (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM artista
            WHERE artistaid = p_id;
            COMMIT;
        END sp_delete_artista;
        

        CREATE OR REPLACE PROCEDURE sp_create_compra(p_('COMPRAID', 'NUMBER') NUMBER, p_('FECHACOMPRA', 'DATE') DATE, p_('TOTAL', 'NUMBER') NUMBER, p_('VISITANTEID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO compra (compraid, fechacompra, total, visitanteid)
            VALUES (p_compraid, p_fechacompra, p_total, p_visitanteid);
            COMMIT;
        END sp_create_compra;
        

        CREATE OR REPLACE PROCEDURE sp_read_compra (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT compraid, fechacompra, total, visitanteid
            FROM compra
            WHERE compraid = p_id;
        END sp_read_compra;
        

        CREATE OR REPLACE PROCEDURE sp_update_compra (p_('COMPRAID', 'NUMBER') NUMBER, p_('FECHACOMPRA', 'DATE') DATE, p_('TOTAL', 'NUMBER') NUMBER, p_('VISITANTEID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE compra
            SET fechacompra = p_fechacompra, total = p_total, visitanteid = p_visitanteid
            WHERE compraid = p_compraid;
            COMMIT;
        END sp_update_compra;
        

        CREATE OR REPLACE PROCEDURE sp_delete_compra (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM compra
            WHERE compraid = p_id;
            COMMIT;
        END sp_delete_compra;
        

        CREATE OR REPLACE PROCEDURE sp_create_donacion(p_('DONACIONID', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHADONACION', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('DONANTEID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO donacion (donacionid, descripcion, fechadonacion, museoid, donanteid)
            VALUES (p_donacionid, p_descripcion, p_fechadonacion, p_museoid, p_donanteid);
            COMMIT;
        END sp_create_donacion;
        

        CREATE OR REPLACE PROCEDURE sp_read_donacion (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT donacionid, descripcion, fechadonacion, museoid, donanteid
            FROM donacion
            WHERE donacionid = p_id;
        END sp_read_donacion;
        

        CREATE OR REPLACE PROCEDURE sp_update_donacion (p_('DONACIONID', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHADONACION', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('DONANTEID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE donacion
            SET descripcion = p_descripcion, fechadonacion = p_fechadonacion, museoid = p_museoid, donanteid = p_donanteid
            WHERE donacionid = p_donacionid;
            COMMIT;
        END sp_update_donacion;
        

        CREATE OR REPLACE PROCEDURE sp_delete_donacion (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM donacion
            WHERE donacionid = p_id;
            COMMIT;
        END sp_delete_donacion;
        

        CREATE OR REPLACE PROCEDURE sp_create_donante(p_('DONANTEID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('CELULAR', 'VARCHAR2') VARCHAR2, p_('FECHANACIMIENTO', 'DATE') DATE) IS
        BEGIN
            INSERT INTO donante (donanteid, nombre, apellido, cedula, celular, fechanacimiento)
            VALUES (p_donanteid, p_nombre, p_apellido, p_cedula, p_celular, p_fechanacimiento);
            COMMIT;
        END sp_create_donante;
        

        CREATE OR REPLACE PROCEDURE sp_read_donante (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT donanteid, nombre, apellido, cedula, celular, fechanacimiento
            FROM donante
            WHERE donanteid = p_id;
        END sp_read_donante;
        

        CREATE OR REPLACE PROCEDURE sp_update_donante (p_('DONANTEID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('CELULAR', 'VARCHAR2') VARCHAR2, p_('FECHANACIMIENTO', 'DATE') DATE) IS
        BEGIN
            UPDATE donante
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, celular = p_celular, fechanacimiento = p_fechanacimiento
            WHERE donanteid = p_donanteid;
            COMMIT;
        END sp_update_donante;
        

        CREATE OR REPLACE PROCEDURE sp_delete_donante (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM donante
            WHERE donanteid = p_id;
            COMMIT;
        END sp_delete_donante;
        

        CREATE OR REPLACE PROCEDURE sp_create_empleado(p_('EMPLEADOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('SALARIO', 'NUMBER') NUMBER, p_('FECHAINGRESO', 'DATE') DATE, p_('FECHASALIDA', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('ROLID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO empleado (empleadoid, nombre, apellido, cedula, salario, fechaingreso, fechasalida, museoid, rolid)
            VALUES (p_empleadoid, p_nombre, p_apellido, p_cedula, p_salario, p_fechaingreso, p_fechasalida, p_museoid, p_rolid);
            COMMIT;
        END sp_create_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_read_empleado (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT empleadoid, nombre, apellido, cedula, salario, fechaingreso, fechasalida, museoid, rolid
            FROM empleado
            WHERE empleadoid = p_id;
        END sp_read_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_update_empleado (p_('EMPLEADOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('SALARIO', 'NUMBER') NUMBER, p_('FECHAINGRESO', 'DATE') DATE, p_('FECHASALIDA', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('ROLID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE empleado
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, salario = p_salario, fechaingreso = p_fechaingreso, fechasalida = p_fechasalida, museoid = p_museoid, rolid = p_rolid
            WHERE empleadoid = p_empleadoid;
            COMMIT;
        END sp_update_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_delete_empleado (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM empleado
            WHERE empleadoid = p_id;
            COMMIT;
        END sp_delete_empleado;
        

        CREATE OR REPLACE PROCEDURE sp_create_entrada(p_('ENTRADAID', 'NUMBER') NUMBER, p_('FECHAENTRADA', 'DATE') DATE, p_('PRECIO', 'NUMBER') NUMBER, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO entrada (entradaid, fechaentrada, precio, museoid)
            VALUES (p_entradaid, p_fechaentrada, p_precio, p_museoid);
            COMMIT;
        END sp_create_entrada;
        

        CREATE OR REPLACE PROCEDURE sp_read_entrada (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT entradaid, fechaentrada, precio, museoid
            FROM entrada
            WHERE entradaid = p_id;
        END sp_read_entrada;
        

        CREATE OR REPLACE PROCEDURE sp_update_entrada (p_('ENTRADAID', 'NUMBER') NUMBER, p_('FECHAENTRADA', 'DATE') DATE, p_('PRECIO', 'NUMBER') NUMBER, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE entrada
            SET fechaentrada = p_fechaentrada, precio = p_precio, museoid = p_museoid
            WHERE entradaid = p_entradaid;
            COMMIT;
        END sp_update_entrada;
        

        CREATE OR REPLACE PROCEDURE sp_delete_entrada (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM entrada
            WHERE entradaid = p_id;
            COMMIT;
        END sp_delete_entrada;
        

        CREATE OR REPLACE PROCEDURE sp_create_incidente(p_('INCIDENTEID', 'NUMBER') NUMBER, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHAINCIDENTE', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO incidente (incidenteid, tipo, descripcion, fechaincidente, museoid)
            VALUES (p_incidenteid, p_tipo, p_descripcion, p_fechaincidente, p_museoid);
            COMMIT;
        END sp_create_incidente;
        

        CREATE OR REPLACE PROCEDURE sp_read_incidente (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT incidenteid, tipo, descripcion, fechaincidente, museoid
            FROM incidente
            WHERE incidenteid = p_id;
        END sp_read_incidente;
        

        CREATE OR REPLACE PROCEDURE sp_update_incidente (p_('INCIDENTEID', 'NUMBER') NUMBER, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHAINCIDENTE', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE incidente
            SET tipo = p_tipo, descripcion = p_descripcion, fechaincidente = p_fechaincidente, museoid = p_museoid
            WHERE incidenteid = p_incidenteid;
            COMMIT;
        END sp_update_incidente;
        

        CREATE OR REPLACE PROCEDURE sp_delete_incidente (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM incidente
            WHERE incidenteid = p_id;
            COMMIT;
        END sp_delete_incidente;
        

        CREATE OR REPLACE PROCEDURE sp_create_mantenimiento(p_('MANTENIMIENTOID', 'NUMBER') NUMBER, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHAMANTENIMIENTO', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO mantenimiento (mantenimientoid, tipo, descripcion, fechamantenimiento, museoid)
            VALUES (p_mantenimientoid, p_tipo, p_descripcion, p_fechamantenimiento, p_museoid);
            COMMIT;
        END sp_create_mantenimiento;
        

        CREATE OR REPLACE PROCEDURE sp_read_mantenimiento (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT mantenimientoid, tipo, descripcion, fechamantenimiento, museoid
            FROM mantenimiento
            WHERE mantenimientoid = p_id;
        END sp_read_mantenimiento;
        

        CREATE OR REPLACE PROCEDURE sp_update_mantenimiento (p_('MANTENIMIENTOID', 'NUMBER') NUMBER, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHAMANTENIMIENTO', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE mantenimiento
            SET tipo = p_tipo, descripcion = p_descripcion, fechamantenimiento = p_fechamantenimiento, museoid = p_museoid
            WHERE mantenimientoid = p_mantenimientoid;
            COMMIT;
        END sp_update_mantenimiento;
        

        CREATE OR REPLACE PROCEDURE sp_delete_mantenimiento (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM mantenimiento
            WHERE mantenimientoid = p_id;
            COMMIT;
        END sp_delete_mantenimiento;
        

        CREATE OR REPLACE PROCEDURE sp_create_museo(p_('MUSEOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('UBICACION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO museo (museoid, nombre, ubicacion)
            VALUES (p_museoid, p_nombre, p_ubicacion);
            COMMIT;
        END sp_create_museo;
        

        CREATE OR REPLACE PROCEDURE sp_read_museo (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT museoid, nombre, ubicacion
            FROM museo
            WHERE museoid = p_id;
        END sp_read_museo;
        

        CREATE OR REPLACE PROCEDURE sp_update_museo (p_('MUSEOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('UBICACION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE museo
            SET nombre = p_nombre, ubicacion = p_ubicacion
            WHERE museoid = p_museoid;
            COMMIT;
        END sp_update_museo;
        

        CREATE OR REPLACE PROCEDURE sp_delete_museo (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM museo
            WHERE museoid = p_id;
            COMMIT;
        END sp_delete_museo;
        

        CREATE OR REPLACE PROCEDURE sp_create_obradearte(p_('OBRAID', 'NUMBER') NUMBER, p_('TITULO', 'VARCHAR2') VARCHAR2, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHACREACION', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('ARTISTAID', 'NUMBER') NUMBER, p_('UBICACIONOBRAID', 'NUMBER') NUMBER, p_('DONACIONID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO obradearte (obraid, titulo, tipo, descripcion, fechacreacion, museoid, artistaid, ubicacionobraid, donacionid)
            VALUES (p_obraid, p_titulo, p_tipo, p_descripcion, p_fechacreacion, p_museoid, p_artistaid, p_ubicacionobraid, p_donacionid);
            COMMIT;
        END sp_create_obradearte;
        

        CREATE OR REPLACE PROCEDURE sp_read_obradearte (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT obraid, titulo, tipo, descripcion, fechacreacion, museoid, artistaid, ubicacionobraid, donacionid
            FROM obradearte
            WHERE obraid = p_id;
        END sp_read_obradearte;
        

        CREATE OR REPLACE PROCEDURE sp_update_obradearte (p_('OBRAID', 'NUMBER') NUMBER, p_('TITULO', 'VARCHAR2') VARCHAR2, p_('TIPO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('FECHACREACION', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER, p_('ARTISTAID', 'NUMBER') NUMBER, p_('UBICACIONOBRAID', 'NUMBER') NUMBER, p_('DONACIONID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE obradearte
            SET titulo = p_titulo, tipo = p_tipo, descripcion = p_descripcion, fechacreacion = p_fechacreacion, museoid = p_museoid, artistaid = p_artistaid, ubicacionobraid = p_ubicacionobraid, donacionid = p_donacionid
            WHERE obraid = p_obraid;
            COMMIT;
        END sp_update_obradearte;
        

        CREATE OR REPLACE PROCEDURE sp_delete_obradearte (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM obradearte
            WHERE obraid = p_id;
            COMMIT;
        END sp_delete_obradearte;
        

        CREATE OR REPLACE PROCEDURE sp_create_patrocinador(p_('PATROCINADORID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO patrocinador (patrocinadorid, nombre, apellido, descripcion, museoid)
            VALUES (p_patrocinadorid, p_nombre, p_apellido, p_descripcion, p_museoid);
            COMMIT;
        END sp_create_patrocinador;
        

        CREATE OR REPLACE PROCEDURE sp_read_patrocinador (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT patrocinadorid, nombre, apellido, descripcion, museoid
            FROM patrocinador
            WHERE patrocinadorid = p_id;
        END sp_read_patrocinador;
        

        CREATE OR REPLACE PROCEDURE sp_update_patrocinador (p_('PATROCINADORID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE patrocinador
            SET nombre = p_nombre, apellido = p_apellido, descripcion = p_descripcion, museoid = p_museoid
            WHERE patrocinadorid = p_patrocinadorid;
            COMMIT;
        END sp_update_patrocinador;
        

        CREATE OR REPLACE PROCEDURE sp_delete_patrocinador (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM patrocinador
            WHERE patrocinadorid = p_id;
            COMMIT;
        END sp_delete_patrocinador;
        

        CREATE OR REPLACE PROCEDURE sp_create_prestador(p_('PRESTADORID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('NACIONALIDAD', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO prestador (prestadorid, nombre, apellido, cedula, nacionalidad)
            VALUES (p_prestadorid, p_nombre, p_apellido, p_cedula, p_nacionalidad);
            COMMIT;
        END sp_create_prestador;
        

        CREATE OR REPLACE PROCEDURE sp_read_prestador (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT prestadorid, nombre, apellido, cedula, nacionalidad
            FROM prestador
            WHERE prestadorid = p_id;
        END sp_read_prestador;
        

        CREATE OR REPLACE PROCEDURE sp_update_prestador (p_('PRESTADORID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('NACIONALIDAD', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE prestador
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, nacionalidad = p_nacionalidad
            WHERE prestadorid = p_prestadorid;
            COMMIT;
        END sp_update_prestador;
        

        CREATE OR REPLACE PROCEDURE sp_delete_prestador (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM prestador
            WHERE prestadorid = p_id;
            COMMIT;
        END sp_delete_prestador;
        

        CREATE OR REPLACE PROCEDURE sp_create_prestamo(p_('PRESTAMOID', 'NUMBER') NUMBER, p_('FECHAPRESTAMO', 'DATE') DATE, p_('FECHADEVOLUCION', 'DATE') DATE, p_('MOTIVO', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER, p_('PRESTADORID', 'NUMBER') NUMBER, p_('OBRAID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO prestamo (prestamoid, fechaprestamo, fechadevolucion, motivo, museoid, prestadorid, obraid)
            VALUES (p_prestamoid, p_fechaprestamo, p_fechadevolucion, p_motivo, p_museoid, p_prestadorid, p_obraid);
            COMMIT;
        END sp_create_prestamo;
        

        CREATE OR REPLACE PROCEDURE sp_read_prestamo (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT prestamoid, fechaprestamo, fechadevolucion, motivo, museoid, prestadorid, obraid
            FROM prestamo
            WHERE prestamoid = p_id;
        END sp_read_prestamo;
        

        CREATE OR REPLACE PROCEDURE sp_update_prestamo (p_('PRESTAMOID', 'NUMBER') NUMBER, p_('FECHAPRESTAMO', 'DATE') DATE, p_('FECHADEVOLUCION', 'DATE') DATE, p_('MOTIVO', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER, p_('PRESTADORID', 'NUMBER') NUMBER, p_('OBRAID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE prestamo
            SET fechaprestamo = p_fechaprestamo, fechadevolucion = p_fechadevolucion, motivo = p_motivo, museoid = p_museoid, prestadorid = p_prestadorid, obraid = p_obraid
            WHERE prestamoid = p_prestamoid;
            COMMIT;
        END sp_update_prestamo;
        

        CREATE OR REPLACE PROCEDURE sp_delete_prestamo (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM prestamo
            WHERE prestamoid = p_id;
            COMMIT;
        END sp_delete_prestamo;
        

        CREATE OR REPLACE PROCEDURE sp_create_producto(p_('PRODUCTOID', 'NUMBER') NUMBER, p_('COMPRAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('PRECIO', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO producto (productoid, compraid, nombre, precio, descripcion)
            VALUES (p_productoid, p_compraid, p_nombre, p_precio, p_descripcion);
            COMMIT;
        END sp_create_producto;
        

        CREATE OR REPLACE PROCEDURE sp_read_producto (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT productoid, compraid, nombre, precio, descripcion
            FROM producto
            WHERE productoid = p_id;
        END sp_read_producto;
        

        CREATE OR REPLACE PROCEDURE sp_update_producto (p_('PRODUCTOID', 'NUMBER') NUMBER, p_('COMPRAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('PRECIO', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE producto
            SET compraid = p_compraid, nombre = p_nombre, precio = p_precio, descripcion = p_descripcion
            WHERE productoid = p_productoid;
            COMMIT;
        END sp_update_producto;
        

        CREATE OR REPLACE PROCEDURE sp_delete_producto (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM producto
            WHERE productoid = p_id;
            COMMIT;
        END sp_delete_producto;
        

        CREATE OR REPLACE PROCEDURE sp_create_productotienda(p_('PRODUCTOID', 'NUMBER') NUMBER, p_('TIENDAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('PRECIO', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO productotienda (productoid, tiendaid, nombre, precio, descripcion)
            VALUES (p_productoid, p_tiendaid, p_nombre, p_precio, p_descripcion);
            COMMIT;
        END sp_create_productotienda;
        

        CREATE OR REPLACE PROCEDURE sp_read_productotienda (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT productoid, tiendaid, nombre, precio, descripcion
            FROM productotienda
            WHERE productoid = p_id;
        END sp_read_productotienda;
        

        CREATE OR REPLACE PROCEDURE sp_update_productotienda (p_('PRODUCTOID', 'NUMBER') NUMBER, p_('TIENDAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('PRECIO', 'NUMBER') NUMBER, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE productotienda
            SET tiendaid = p_tiendaid, nombre = p_nombre, precio = p_precio, descripcion = p_descripcion
            WHERE productoid = p_productoid;
            COMMIT;
        END sp_update_productotienda;
        

        CREATE OR REPLACE PROCEDURE sp_delete_productotienda (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM productotienda
            WHERE productoid = p_id;
            COMMIT;
        END sp_delete_productotienda;
        

        CREATE OR REPLACE PROCEDURE sp_create_propietario(p_('PROPIETARIOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO propietario (propietarioid, nombre, apellido, cedula)
            VALUES (p_propietarioid, p_nombre, p_apellido, p_cedula);
            COMMIT;
        END sp_create_propietario;
        

        CREATE OR REPLACE PROCEDURE sp_read_propietario (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT propietarioid, nombre, apellido, cedula
            FROM propietario
            WHERE propietarioid = p_id;
        END sp_read_propietario;
        

        CREATE OR REPLACE PROCEDURE sp_update_propietario (p_('PROPIETARIOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE propietario
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula
            WHERE propietarioid = p_propietarioid;
            COMMIT;
        END sp_update_propietario;
        

        CREATE OR REPLACE PROCEDURE sp_delete_propietario (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM propietario
            WHERE propietarioid = p_id;
            COMMIT;
        END sp_delete_propietario;
        

        CREATE OR REPLACE PROCEDURE sp_create_rol(p_('ROLID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO rol (rolid, nombre, descripcion)
            VALUES (p_rolid, p_nombre, p_descripcion);
            COMMIT;
        END sp_create_rol;
        

        CREATE OR REPLACE PROCEDURE sp_read_rol (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT rolid, nombre, descripcion
            FROM rol
            WHERE rolid = p_id;
        END sp_read_rol;
        

        CREATE OR REPLACE PROCEDURE sp_update_rol (p_('ROLID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE rol
            SET nombre = p_nombre, descripcion = p_descripcion
            WHERE rolid = p_rolid;
            COMMIT;
        END sp_update_rol;
        

        CREATE OR REPLACE PROCEDURE sp_delete_rol (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM rol
            WHERE rolid = p_id;
            COMMIT;
        END sp_delete_rol;
        

        CREATE OR REPLACE PROCEDURE sp_create_tienda(p_('TIENDAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('UBICACION', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER, p_('PROPIETARIOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO tienda (tiendaid, nombre, descripcion, ubicacion, museoid, propietarioid)
            VALUES (p_tiendaid, p_nombre, p_descripcion, p_ubicacion, p_museoid, p_propietarioid);
            COMMIT;
        END sp_create_tienda;
        

        CREATE OR REPLACE PROCEDURE sp_read_tienda (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT tiendaid, nombre, descripcion, ubicacion, museoid, propietarioid
            FROM tienda
            WHERE tiendaid = p_id;
        END sp_read_tienda;
        

        CREATE OR REPLACE PROCEDURE sp_update_tienda (p_('TIENDAID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('DESCRIPCION', 'VARCHAR2') VARCHAR2, p_('UBICACION', 'VARCHAR2') VARCHAR2, p_('MUSEOID', 'NUMBER') NUMBER, p_('PROPIETARIOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE tienda
            SET nombre = p_nombre, descripcion = p_descripcion, ubicacion = p_ubicacion, museoid = p_museoid, propietarioid = p_propietarioid
            WHERE tiendaid = p_tiendaid;
            COMMIT;
        END sp_update_tienda;
        

        CREATE OR REPLACE PROCEDURE sp_delete_tienda (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM tienda
            WHERE tiendaid = p_id;
            COMMIT;
        END sp_delete_tienda;
        

        CREATE OR REPLACE PROCEDURE sp_create_ubicacionobra(p_('UBICACIONOBRAID', 'NUMBER') NUMBER, p_('PISO', 'VARCHAR2') VARCHAR2, p_('SECCION', 'VARCHAR2') VARCHAR2, p_('REFERENCIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            INSERT INTO ubicacionobra (ubicacionobraid, piso, seccion, referencia)
            VALUES (p_ubicacionobraid, p_piso, p_seccion, p_referencia);
            COMMIT;
        END sp_create_ubicacionobra;
        

        CREATE OR REPLACE PROCEDURE sp_read_ubicacionobra (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT ubicacionobraid, piso, seccion, referencia
            FROM ubicacionobra
            WHERE ubicacionobraid = p_id;
        END sp_read_ubicacionobra;
        

        CREATE OR REPLACE PROCEDURE sp_update_ubicacionobra (p_('UBICACIONOBRAID', 'NUMBER') NUMBER, p_('PISO', 'VARCHAR2') VARCHAR2, p_('SECCION', 'VARCHAR2') VARCHAR2, p_('REFERENCIA', 'VARCHAR2') VARCHAR2) IS
        BEGIN
            UPDATE ubicacionobra
            SET piso = p_piso, seccion = p_seccion, referencia = p_referencia
            WHERE ubicacionobraid = p_ubicacionobraid;
            COMMIT;
        END sp_update_ubicacionobra;
        

        CREATE OR REPLACE PROCEDURE sp_delete_ubicacionobra (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM ubicacionobra
            WHERE ubicacionobraid = p_id;
            COMMIT;
        END sp_delete_ubicacionobra;
        

        CREATE OR REPLACE PROCEDURE sp_create_visitante(p_('VISITANTEID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('FECHAVISITA', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO visitante (visitanteid, nombre, apellido, cedula, fechavisita, museoid)
            VALUES (p_visitanteid, p_nombre, p_apellido, p_cedula, p_fechavisita, p_museoid);
            COMMIT;
        END sp_create_visitante;
        

        CREATE OR REPLACE PROCEDURE sp_read_visitante (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT visitanteid, nombre, apellido, cedula, fechavisita, museoid
            FROM visitante
            WHERE visitanteid = p_id;
        END sp_read_visitante;
        

        CREATE OR REPLACE PROCEDURE sp_update_visitante (p_('VISITANTEID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('FECHAVISITA', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE visitante
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, fechavisita = p_fechavisita, museoid = p_museoid
            WHERE visitanteid = p_visitanteid;
            COMMIT;
        END sp_update_visitante;
        

        CREATE OR REPLACE PROCEDURE sp_delete_visitante (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM visitante
            WHERE visitanteid = p_id;
            COMMIT;
        END sp_delete_visitante;
        

        CREATE OR REPLACE PROCEDURE sp_create_voluntario(p_('VOLUNTARIOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('FECHAINICIO', 'DATE') DATE, p_('FECHAFIN', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            INSERT INTO voluntario (voluntarioid, nombre, apellido, cedula, fechainicio, fechafin, museoid)
            VALUES (p_voluntarioid, p_nombre, p_apellido, p_cedula, p_fechainicio, p_fechafin, p_museoid);
            COMMIT;
        END sp_create_voluntario;
        

        CREATE OR REPLACE PROCEDURE sp_read_voluntario (p_id IN NUMBER, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT voluntarioid, nombre, apellido, cedula, fechainicio, fechafin, museoid
            FROM voluntario
            WHERE voluntarioid = p_id;
        END sp_read_voluntario;
        

        CREATE OR REPLACE PROCEDURE sp_update_voluntario (p_('VOLUNTARIOID', 'NUMBER') NUMBER, p_('NOMBRE', 'VARCHAR2') VARCHAR2, p_('APELLIDO', 'VARCHAR2') VARCHAR2, p_('CEDULA', 'VARCHAR2') VARCHAR2, p_('FECHAINICIO', 'DATE') DATE, p_('FECHAFIN', 'DATE') DATE, p_('MUSEOID', 'NUMBER') NUMBER) IS
        BEGIN
            UPDATE voluntario
            SET nombre = p_nombre, apellido = p_apellido, cedula = p_cedula, fechainicio = p_fechainicio, fechafin = p_fechafin, museoid = p_museoid
            WHERE voluntarioid = p_voluntarioid;
            COMMIT;
        END sp_update_voluntario;
        

        CREATE OR REPLACE PROCEDURE sp_delete_voluntario (p_id IN NUMBER) IS
        BEGIN
            DELETE FROM voluntario
            WHERE voluntarioid = p_id;
            COMMIT;
        END sp_delete_voluntario;
        