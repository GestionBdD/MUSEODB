import cx_Oracle
import subprocess
import os
from datetime import datetime
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib import colors
from shutil import copyfile
import threading
import time

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Crear usuario en la base de datos")
    print("2. Lista de usuarios en la base de datos")
    print("3. Modificar un usuario")
    print("4. Eliminar un usuario")
    print("5. Crear un rol")
    print("6. Lista de Roles")
    print("7. Asignar un rol a un usuario")
    print("8. Respaldar base de datos")
    print("9. Restaurar base de datos")
    print("10. Generar PDF")
    print("11. CRUD")
    print("12. Aplicación de metadatos")
    print("13. Función de generación")
    print("14. Consultar datos con cursor")
    print("15. Cursor Dinámico")
    print("16. Cargar y Ejecutar Cursor desde Archivo")
    print("17. Aplicación de múltiples hilos")
    print("18. Historial de consultas realizadas")
    print("19. Modificar ubicacion de las obras")
    print("20. Salir")

# CREAR USUARIOS
def crear_usuario_oracle(cursor, nombre_usuario, contraseña):
    try:
        if not nombre_usuario.startswith("C##"):
            nombre_usuario = f"C##{nombre_usuario}"
        query = f"CREATE USER {nombre_usuario} IDENTIFIED BY {contraseña}"
        cursor.execute(query)
        query_privilegios = f"GRANT ALL PRIVILEGES TO {nombre_usuario}"
        cursor.execute(query_privilegios)
        print("Usuario creado y se le otorgaron todos los privilegios exitosamente.")
    except Exception as e:
        print(f"Error al crear el usuario: {e}")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    nombre_usuario = input("Ingrese el nombre del nuevo usuario de la base de datos: ")
    contraseña = input("Ingrese la contraseña para el nuevo usuario: ")
    crear_usuario_oracle(cursor, nombre_usuario, contraseña)

# MOSTRAR USUARIOS
def mostrar_usuarios(cursor):
    try:
        query = """
        SELECT username FROM all_users
        WHERE username NOT IN ('SYS', 'SYSTEM')
        ORDER BY username
        """
        cursor.execute(query)
        usuarios = cursor.fetchall()
        if usuarios:
            print("Usuarios de la base de datos:")
            for index, usuario in enumerate(usuarios, start=1):
                print(f"{index}. {usuario[0]}")
            return usuarios
        else:
            print("No hay usuarios disponibles.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de usuarios: {e}")
        return []

def opcion2(cursor):
    print("Ejecutando Opción 2...")
    mostrar_usuarios(cursor)

# MODIFICAR USUARIOS
def cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre):
    try:
        nueva_contraseña = "Temporal123"
        
        query_crear = f"CREATE USER {nuevo_nombre} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query_crear)
        
        query_privilegios = f"""
        SELECT privilege FROM dba_sys_privs WHERE grantee = '{nombre_actual}'
        UNION
        SELECT privilege FROM dba_tab_privs WHERE grantee = '{nombre_actual}'
        """
        cursor.execute(query_privilegios)
        privilegios = cursor.fetchall()
        for priv in privilegios:
            query_asignar_priv = f"GRANT {priv[0]} TO {nuevo_nombre}"
            cursor.execute(query_asignar_priv)

        query_eliminar = f"DROP USER {nombre_actual} CASCADE"
        cursor.execute(query_eliminar)
        
        print(f"Usuario {nombre_actual} renombrado a {nuevo_nombre} y eliminado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el nombre del usuario: {e}")

def cambiar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = f"ALTER USER {nombre_usuario} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query)
        print("Contraseña cambiada exitosamente.")
    except Exception as e:
        print(f"Error al cambiar la contraseña del usuario: {e}")

def opcion3(cursor):
    print("Ejecutando Opción 3...")
    usuarios = mostrar_usuarios(cursor)
    if usuarios:
        try:
            eleccion = int(input("Seleccione el número del usuario a modificar: "))
            nombre_actual = usuarios[eleccion - 1][0]
            nuevo_nombre = input("Ingrese el nuevo nombre del usuario: ")
            nueva_contraseña = input("Ingrese la nueva contraseña del usuario: ")
            
            cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre)
            cambiar_contraseña_usuario(cursor, nuevo_nombre, nueva_contraseña)  
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para modificar.")

# ELIMINAR USUARIOS
def eliminar_usuario_oracle(cursor, nombre_usuario):
    try:
        query = f"DROP USER {nombre_usuario} CASCADE"
        cursor.execute(query)
        print("Usuario eliminado exitosamente.")
    except Exception as e:
        print(f"Error al eliminar el usuario: {e}")

def opcion4(cursor):
    print("Ejecutando Opción 4...")
    usuarios = mostrar_usuarios(cursor)
    if usuarios:
        try:
            eleccion = int(input("Seleccione el número del usuario a eliminar: "))
            nombre_usuario = usuarios[eleccion - 1][0]
            confirmacion = input(f"Está seguro de que desea eliminar al usuario '{nombre_usuario}'? (s/n): ")
            if confirmacion.lower() == 's':
                eliminar_usuario_oracle(cursor, nombre_usuario)
            else:
                print("Eliminación cancelada.")
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para eliminar.")

# CREAR UN ROL
def crear_rol_oracle(cursor, nombre_rol):
    try:
        if not nombre_rol.startswith("C##"):
            nombre_rol = f"C##{nombre_rol}"
        query = f"CREATE ROLE {nombre_rol}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el rol: {e}")

def opcion5(cursor):
    print("Ejecutando Opción 5...")
    nombre_rol = input("Ingrese el nombre del nuevo rol: ")
    crear_rol_oracle(cursor, nombre_rol)

# MOSTRAR ROLES
def mostrar_roles(cursor):
    try:
        cursor.execute("SELECT role FROM dba_roles ORDER BY role")
        roles = cursor.fetchall()
        if roles:
            print("Roles disponibles en la base de datos:")
            for index, rol in enumerate(roles, start=1):
                print(f"{index}. {rol[0]}")
            return roles
        else:
            print("No hay roles disponibles.")
            return []
    except Exception as e:
        print(f"Error al obtener la lista de roles: {e}")
        return []

def opcion6(cursor):
    print("Ejecutando Opción 6...")
    mostrar_roles(cursor)

# ASIGNAR UN ROL A UN USUARIO
def asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol):
    try:
        query = f"GRANT {nombre_rol} TO {nombre_usuario}"
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' asignado exitosamente a '{nombre_usuario}'.")
    except Exception as e:
        print(f"Error al asignar el rol: {e}")

def opcion7(cursor):
    print("Ejecutando Opción 7...")
    usuarios = mostrar_usuarios(cursor)
    if usuarios:
        try:
            seleccion_usuario = int(input("Seleccione el número del usuario al que asignar el rol: ")) - 1
            nombre_usuario = usuarios[seleccion_usuario][0]
        except ValueError:
            print("Por favor, ingrese un número válido.")
            return
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
            return

    roles = mostrar_roles(cursor)
    if roles:
        try:
            seleccion_rol = int(input("Seleccione el número del rol a asignar: ")) - 1
            nombre_rol = roles[seleccion_rol][0]
        except ValueError:
            print("Por favor, ingrese un número válido.")
            return
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
            return

    asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol)

# RESPALDAR BASE DE DATOS
def realizar_respaldo(user, password, tnsname, directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
            print(f"Directorio {directory} creado.")

        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_archivo = f"{tnsname}_{fecha_hora}.dmp"
        archivo_log = f"{tnsname}_{fecha_hora}.log"
        
        command = f"expdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={nombre_archivo} logfile={archivo_log}"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)

        path_respaldo_oracle = os.path.join(r"C:\app\alext\product\21c\admin\xe\dpdump", nombre_archivo)
        path_log_oracle = os.path.join(r"C:\app\alext\product\21c\admin\xe\dpdump", archivo_log)
        
        path_respaldo_destino = os.path.join(directory, nombre_archivo)
        path_log_destino = os.path.join(directory, archivo_log)

        copyfile(path_respaldo_oracle, path_respaldo_destino)
        copyfile(path_log_oracle, path_log_destino)
        
        print(f"Respaldo realizado exitosamente y copiado a {path_respaldo_destino}")
    except Exception as e:
        print(f"Error al realizar el respaldo: {e}")

def opcion8(cursor):
    print("Ejecutando Opción 8...")
    user = "alext"
    password = "1234"
    tnsname = "xe"
    directory = r"C:\GBD\Backup"
    realizar_respaldo(user, password, tnsname, directory)

# RESTAURAR BASE DE DATOS
def actualizar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = f"ALTER USER {nombre_usuario} IDENTIFIED BY {nueva_contraseña}"
        cursor.execute(query)
        print("Contraseña actualizada exitosamente.")
    except Exception as e:
        print(f"Error al actualizar la contraseña: {e}")

def crear_usuario_si_no_existe(cursor, nombre_usuario, contraseña):
    try:
        query = f"SELECT COUNT(*) FROM all_users WHERE username = '{nombre_usuario.upper()}'"
        cursor.execute(query)
        usuario_existe = cursor.fetchone()[0]
        if usuario_existe == 0:
            crear_usuario_oracle(cursor, nombre_usuario, contraseña)
        else:
            print(f"El usuario {nombre_usuario} ya existe.")
    except Exception as e:
        print(f"Error al verificar/crear el usuario: {e}")

def listar_archivos_respaldo(directorio):
    try:
        archivos = [f for f in os.listdir(directorio) if f.endswith('.dmp')]
        if archivos:
            print("Archivos de respaldo disponibles:")
            for idx, archivo in enumerate(archivos, 1):
                print(f"{idx}. {archivo}")
            return archivos
        else:
            print("No se encontraron archivos de respaldo en el directorio especificado.")
            return []
    except Exception as e:
        print(f"Error al listar archivos de respaldo: {e}")
        return []

def obtener_esquema_original(user, password, tnsname, archivo_respaldo):
    try:
        sqlfile = "temp_sqlfile.sql"
        sqlfile_path = os.path.join(r"C:\app\alext\product\21c\admin\xe\dpdump", sqlfile)
        
        # Verificar la existencia del directorio
        if not os.path.exists(os.path.dirname(sqlfile_path)):
            print(f"Directorio {os.path.dirname(sqlfile_path)} no existe.")
            return None

        command = f"impdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={archivo_respaldo} sqlfile={sqlfile}"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)

        # Verificar la existencia del archivo
        if not os.path.isfile(sqlfile_path):
            print(f"No se pudo encontrar el archivo SQL generado en la ruta especificada: {sqlfile_path}")
            return None
        
        esquema_original = None
        with open(sqlfile_path, 'r') as file:
            lines = file.readlines()
            print("Contenido del archivo SQL:")
            for i, line in enumerate(lines):  # Leer todas las líneas
                print(f"{i + 1}: {line.strip()}")
                if "CREATE USER" in line or "CREATE TABLE" in line or "ALTER USER" in line:
                    if '"' in line:
                        esquema_original = line.split('"')[1]
                    else:
                        esquema_original = line.split()[2]
                    print(f"Esquema original determinado: {esquema_original}")
                    break
        
        if not esquema_original:
            print("No se pudo encontrar el esquema original en el archivo SQL.")
        return esquema_original
    except subprocess.CalledProcessError as e:
        print(f"Error al ejecutar impdp: {e}")
    except Exception as e:
        print(f"Error al obtener el esquema original: {e}")
    return None

def restaurar_base_datos(user, password, tnsname, archivo_respaldo, esquema_original, usuario_destino):
    try:
        command = f"impdp {user}/{password}@{tnsname} directory=DATA_PUMP_DIR dumpfile={archivo_respaldo} remap_schema={esquema_original}:{usuario_destino} table_exists_action=replace"
        print(f"Ejecutando comando: {command}")
        subprocess.run(command, shell=True, check=True)
        print(f"Restauración de la base de datos desde {archivo_respaldo} en el usuario {usuario_destino} completada exitosamente.")
    except subprocess.CalledProcessError as e:
        print(f"Error al restaurar la base de datos: {e}")
    except Exception as e:
        print(f"Error inesperado al restaurar la base de datos: {e}")

def opcion9(cursor):
    print("Ejecutando Opción 9...")
    
    directorio_respaldo = r"C:\GBD\Backup"
    
    archivos_respaldo = listar_archivos_respaldo(directorio_respaldo)
    if not archivos_respaldo:
        return
    
    try:
        idx_archivo = int(input("Seleccione el número del archivo de respaldo a utilizar: ")) - 1
        archivo_seleccionado = archivos_respaldo[idx_archivo]
    except (ValueError, IndexError):
        print("Selección no válida. Por favor, ingrese un número válido.")
        return
    
    usuarios = mostrar_usuarios(cursor)
    if not usuarios:
        return
    
    try:
        idx_usuario = int(input("Seleccione el número del usuario destino para la restauración: ")) - 1
        usuario_destino = usuarios[idx_usuario][0]
    except (ValueError, IndexError):
        print("Selección no válida. Por favor, ingrese un número válido.")
        return

    user = "system"
    password = "1234"
    tnsname = "xe"

    nueva_contraseña = "NuevaContraseña123"
    crear_usuario_si_no_existe(cursor, usuario_destino, nueva_contraseña)
    
    actualizar_contraseña_usuario(cursor, "alext", "1234")

    esquema_original = obtener_esquema_original(user, password, tnsname, archivo_seleccionado)
    if not esquema_original:
        print("No se pudo determinar el esquema original.")
        return

    restaurar_base_datos(user, password, tnsname, archivo_seleccionado, esquema_original, usuario_destino)


# GENERAR PDF
def obtener_datos_tabla(cursor, tabla, columnas):
    try:
        columnas_sql = ", ".join(columnas)
        query = f"SELECT {columnas_sql} FROM {tabla}"
        cursor.execute(query)
        return cursor.fetchall()
    except Exception as e:
        print(f"Error al obtener datos de la tabla {tabla}: {e}")
        return []

def leer_incrementar_contador(archivo_contador):
    try:
        with open(archivo_contador, "r") as file:
            contador = int(file.read().strip()) + 1
    except FileNotFoundError:
        contador = 1
    with open(archivo_contador, "w") as file:
        file.write(str(contador))
    return contador

def generar_pdf_con_datos(tabla, datos, columnas, output_dir):
    fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = os.path.join(output_dir, f"{tabla}_informe_{fecha_hora}.pdf")

    doc = SimpleDocTemplate(output_path, pagesize=letter)
    story = []
    
    data = [columnas]
    data.extend(datos)
    
    t = Table(data)
    
    t.setStyle(TableStyle([
       ('BACKGROUND', (0,0), (-1,0), colors.gray),
       ('TEXTCOLOR', (0,0), (-1,0), colors.whitesmoke),
       ('ALIGN', (0,0), (-1,-1), 'CENTER'),
       ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
       ('BOTTOMPADDING', (0,0), (-1,0), 12),
       ('BACKGROUND', (0,1), (-1,-1), colors.beige),
       ('GRID', (0,0), (-1,-1), 1, colors.black),
       ('BOX', (0,0), (-1,-1), 2, colors.black),
    ]))
    
    story.append(t)
    doc.build(story)
    print(f"Informe generado en: {output_path}")

def obtener_detalles_tablas(cursor, schema):
    try:
        print(f"Verificando tablas en el esquema: {schema.upper()}")
        cursor.execute("""
            SELECT table_name, column_name, data_type 
            FROM all_tab_columns 
            WHERE owner = :owner
            ORDER BY table_name, column_id
        """, {"owner": schema.upper()})
        result = cursor.fetchall()
        if not result:
            print("No se encontraron tablas.")
            return {}
        
        tablas = {}
        for row in result:
            if row[0] not in tablas:
                tablas[row[0]] = []
            tablas[row[0]].append((row[1], row[2]))
        return tablas
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")
        return {}

def generar_informe_completo(cursor, tablas_seleccionadas, join_condition, schema):
    from_clause = ", ".join([f"{schema}.{tabla}" for tabla in tablas_seleccionadas.keys()])
    select_clause = ", ".join([f"{schema}.{tabla}.{col}" for tabla, cols in tablas_seleccionadas.items() for col in cols])

    if join_condition:
        query = f"SELECT {select_clause} FROM {from_clause} WHERE {join_condition}"
    else:
        query = f"SELECT {select_clause} FROM {from_clause}"

    try:
        print(f"Ejecutando consulta: {query}")  # Añadir impresión de la consulta para depuración
        cursor.execute(query)
        datos = cursor.fetchall()
        columnas = [col for cols in tablas_seleccionadas.values() for col in cols]

        output_dir = "C:/GBD/Report"
        generar_pdf_con_datos("_y_".join(tablas_seleccionadas.keys()), datos, columnas, output_dir)
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")

def obtener_relaciones(cursor, tablas):
    if len(tablas) < 2:
        return ""  # No hay suficientes tablas para una unión

    condiciones = []
    tablas_str = ", ".join([f"'{tabla}'" for tabla in tablas])
    query = f"""
    SELECT a.table_name AS foreign_table, a.column_name AS foreign_column, 
           b.table_name AS primary_table, b.column_name AS primary_column
    FROM all_cons_columns a
    JOIN all_constraints c ON a.constraint_name = c.constraint_name
    JOIN all_cons_columns b ON c.r_constraint_name = b.constraint_name
    WHERE c.constraint_type = 'R' 
      AND a.table_name IN ({tablas_str})
      AND b.table_name IN ({tablas_str})
    """

    cursor.execute(query)
    results = cursor.fetchall()

    for res in results:
        cond = f"{res[0]}.{res[1]} = {res[2]}.{res[3]}"
        condiciones.append(cond)

    return " AND ".join(condiciones)

def opcion10(cursor):
    schema = 'alext'  # Cambiar por el esquema correcto en tu base de datos Oracle
    print("Ejecutando Opción 10...")
    tablas = obtener_detalles_tablas(cursor, schema)
    if not tablas:
        print("No se encontraron tablas disponibles.")
        return

    seleccion_tablas = {}
    while True:
        print("Tablas disponibles:")
        for idx, tabla in enumerate(tablas.keys(), 1):
            print(f"{idx}. {tabla}")
        
        idx_tabla = int(input("Seleccione el número de la tabla: ")) - 1
        if idx_tabla < 0 or idx_tabla >= len(tablas):
            print("Selección de tabla inválida.")
            continue
        tabla_seleccionada = list(tablas.keys())[idx_tabla]

        print("Columnas disponibles en", tabla_seleccionada, ":")
        for idx, col in enumerate(tablas[tabla_seleccionada], 1):
            print(f"{idx}. {col[0]} ({col[1]})")
        
        idxs_columnas = input("Seleccione los números de las columnas (separados por comas): ")
        columnas_seleccionadas = [tablas[tabla_seleccionada][int(i)-1][0] for i in idxs_columnas.split(",")]
        
        seleccion_tablas[tabla_seleccionada] = columnas_seleccionadas
        if input("¿Desea agregar otra tabla? (s/n): ").lower() != 's':
            break

    join_condition = obtener_relaciones(cursor, list(seleccion_tablas.keys()))
    generar_informe_completo(cursor, seleccion_tablas, join_condition, schema)

# CRUD
def generar_procedimientos_crud(tablas):
    procedimientos = []
    for tabla, columnas in tablas.items():
        nombre_tabla = tabla.lower()
        cols = [col[0].lower() for col in columnas]
        cols_str = ", ".join(cols)
        params_str = ", ".join([f"p_{col} {col[1]}" for col in columnas])
        
        # Procedimiento CREATE
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_create_{nombre_tabla}({params_str}) IS
        BEGIN
            INSERT INTO {nombre_tabla} ({cols_str})
            VALUES ({", ".join([f"p_{col}" for col in cols])});
            COMMIT;
        END sp_create_{nombre_tabla};
        """)

        # Procedimiento READ
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_read_{nombre_tabla} (p_id IN {columnas[0][1]}, result OUT SYS_REFCURSOR) IS
        BEGIN
            OPEN result FOR
            SELECT {cols_str}
            FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
        END sp_read_{nombre_tabla};
        """)

        # Procedimiento UPDATE
        set_clause = ", ".join([f"{col} = p_{col}" for col in cols[1:]])
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_update_{nombre_tabla} ({params_str}) IS
        BEGIN
            UPDATE {nombre_tabla}
            SET {set_clause}
            WHERE {cols[0]} = p_{cols[0]};
            COMMIT;
        END sp_update_{nombre_tabla};
        """)

        # Procedimiento DELETE
        procedimientos.append(f"""
        CREATE OR REPLACE PROCEDURE sp_delete_{nombre_tabla} (p_id IN {columnas[0][1]}) IS
        BEGIN
            DELETE FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
            COMMIT;
        END sp_delete_{nombre_tabla};
        """)
    return "\n".join(procedimientos)

def guardar_procedimientos_en_archivo(procedimientos, archivo_sql):
    with open(archivo_sql, "w") as file:
        file.write(procedimientos)
    print(f"Procedimientos almacenados generados en el archivo: {archivo_sql}")

def opcion11(cursor):
    print("Ejecutando opción 11...")
    schema = 'alext'  # Cambiar al esquema correspondiente
    tablas = obtener_detalles_tablas(cursor, schema)
    if tablas:
        procedimientos = generar_procedimientos_crud(tablas)
        guardar_procedimientos_en_archivo(procedimientos, "procedimientos_crud.sql")
    else:
        print("No se encontraron tablas en el esquema especificado.")

def aplicar_metadatos(cursor):
    try:
        query = """
        BEGIN
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN "ALEXT"."MUSEO"."NOMBRE" IS ''Nombre del museo''';
        END;
        """
        cursor.execute(query)
        print("Metadatos aplicados exitosamente.")
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Error al aplicar metadatos: {error.code} - {error.message}")

def funcion_de_generacion(cursor):
    try:
        # Verificar si el procedimiento existe y eliminarlo si es necesario
        query_verificar = """
        SELECT COUNT(*) 
        FROM all_objects 
        WHERE object_name = 'SP_GENERAR_DATOS' 
        AND object_type = 'PROCEDURE'
        AND owner = 'ALEXT'
        """
        cursor.execute(query_verificar)
        exists = cursor.fetchone()[0]
        if exists:
            cursor.execute('DROP PROCEDURE "ALEXT"."SP_GENERAR_DATOS"')

        # Crear el nuevo procedimiento
        query_crear = """
        CREATE OR REPLACE PROCEDURE "ALEXT"."SP_GENERAR_DATOS" AS
        BEGIN
            INSERT INTO "ALEXT"."MUSEO" (MUSEOID, NOMBRE, UBICACION) VALUES (4, 'Museo D', 'Ubicación D');
            COMMIT;
        END;
        """
        cursor.execute(query_crear)
        print("Función de generación creada exitosamente.")

        # Ejecutar el procedimiento
        cursor.execute('BEGIN "ALEXT"."SP_GENERAR_DATOS"; END;')
        print("Procedimiento SP_GENERAR_DATOS ejecutado exitosamente.")
    except cx_Oracle.DatabaseError as e:
        error, = e.args
        print(f"Error al ejecutar la función de generación: {error.code} - {error.message}")

def mostrar_datos_con_cursor(cursor):
    try:
        # Habilitar DBMS_OUTPUT
        cursor.callproc("DBMS_OUTPUT.ENABLE")

        # Definir el bloque PL/SQL
        plsql_block = """
        DECLARE
            CURSOR c_museo IS
                SELECT MuseoID, Nombre, Ubicacion FROM ALEXT.MUSEO;

            CURSOR c_artista IS
                SELECT ArtistaID, Nombre, Apellido, Nacionalidad FROM ALEXT.ARTISTA;

            CURSOR c_obra IS
                SELECT ObraID, Titulo, Tipo, Descripcion, FechaCreacion, MuseoID, ArtistaID FROM ALEXT.OBRADEARTE;

            CURSOR c_donante IS
                SELECT DonanteID, Nombre, Apellido FROM ALEXT.DONANTE;

        BEGIN
            -- Recorrer el cursor de museos
            FOR r_museo IN c_museo LOOP
                DBMS_OUTPUT.PUT_LINE('MuseoID: ' || r_museo.MuseoID || ', Nombre: ' || r_museo.Nombre || ', Ubicacion: ' || r_museo.Ubicacion);
            END LOOP;

            -- Recorrer el cursor de artistas
            FOR r_artista IN c_artista LOOP
                DBMS_OUTPUT.PUT_LINE('ArtistaID: ' || r_artista.ArtistaID || ', Nombre: ' || r_artista.Nombre || ', Apellido: ' || r_artista.Apellido || ', Nacionalidad: ' || r_artista.Nacionalidad);
            END LOOP;

            -- Recorrer el cursor de obras
            FOR r_obra IN c_obra LOOP
                DBMS_OUTPUT.PUT_LINE('ObraID: ' || r_obra.ObraID || ', Titulo: ' || r_obra.Titulo || ', Tipo: ' || r_obra.Tipo || ', Descripcion: ' || r_obra.Descripcion || ', FechaCreacion: ' || r_obra.FechaCreacion);
            END LOOP;

            -- Recorrer el cursor de donantes
            FOR r_donante IN c_donante LOOP
                DBMS_OUTPUT.PUT_LINE('DonanteID: ' || r_donante.DonanteID || ', Nombre: ' || r_donante.Nombre || ', Apellido: ' || r_donante.Apellido);
            END LOOP;
        END;
        """
        cursor.execute(plsql_block)

        # Buffer para capturar la salida
        buffer_size = 10000
        output = cursor.var(cx_Oracle.STRING)
        status_var = cursor.var(cx_Oracle.NUMBER)

        while True:
            cursor.callproc("DBMS_OUTPUT.GET_LINE", (output, status_var))
            if status_var.getvalue() != 0:
                break
            print(output.getvalue())

        print("Datos mostrados exitosamente.")
    except Exception as e:
        print(f"Error al mostrar los datos: {e}")

def listar_tablas(cursor):
    cursor.execute("SELECT table_name FROM all_tables WHERE owner = 'ALEXT'")
    tablas = [row[0] for row in cursor.fetchall()]
    return tablas

def listar_atributos(cursor, tabla):
    cursor.execute(f"SELECT column_name FROM all_tab_columns WHERE table_name = '{tabla}' AND owner = 'ALEXT'")
    atributos = [row[0] for row in cursor.fetchall()]
    return atributos

def cursor_dinamico(cursor):
    try:
        # Solicitar al usuario que ingrese las tablas a consultar
        tablas_input = input("Ingrese los nombres de las tablas a consultar, separadas por comas: ").strip()
        tablas = [tabla.strip() for tabla in tablas_input.split(',')]

        # Mostrar las tablas seleccionadas y solicitar los atributos de cada tabla
        atributos = []
        for tabla in tablas:
            print(f"Seleccione los atributos de la tabla {tabla} separados por comas (use alias para evitar conflictos):")
            atributos_input = input().strip()
            atributos.extend([atributo.strip() for atributo in atributos_input.split(',')])

        # Solicitar al usuario las condiciones de unión (opcional)
        condiciones_input = input("Ingrese las condiciones de unión entre las tablas, separadas por AND (opcional): ").strip()
        condiciones = [condicion.strip() for condicion in condiciones_input.split('AND')] if condiciones_input else []

        # Construir la cláusula FROM
        from_clause = ", ".join(tablas)

        # Construir la cláusula SELECT
        select_clause = ", ".join(atributos)

        # Construir la cláusula WHERE
        where_clause = " AND ".join(condiciones)

        # Habilitar DBMS_OUTPUT
        cursor.callproc("DBMS_OUTPUT.ENABLE")

        # Definir el bloque PL/SQL
        plsql_block = f"""
        DECLARE
            CURSOR c_dynamic IS
                SELECT {select_clause}
                FROM {from_clause}
                {"WHERE " + where_clause if where_clause else ""};
        BEGIN
            -- Recorrer el cursor dinámico
            FOR r IN c_dynamic LOOP
                DBMS_OUTPUT.PUT_LINE('Resultado: ' || r.{atributos[0].split(' ')[-1]} || ', ' || r.{atributos[1].split(' ')[-1]} || ', ' || r.{atributos[2].split(' ')[-1]} || ', ' || r.{atributos[3].split(' ')[-1]} || ', ' || r.{atributos[4].split(' ')[-1]});
            END LOOP;
        END;
        """

        # Ejecutar el bloque PL/SQL
        cursor.execute(plsql_block)

        # Buffer para capturar la salida
        buffer_size = 10000
        output = cursor.var(cx_Oracle.STRING)
        status_var = cursor.var(cx_Oracle.NUMBER)

        while True:
            cursor.callproc("DBMS_OUTPUT.GET_LINE", (output, status_var))
            if status_var.getvalue() != 0:
                break
            print(output.getvalue())

        print("Cursor dinámico ejecutado exitosamente.")
    except Exception as e:
        print(f"Error al ejecutar el cursor dinámico: {e}")
        
def cargar_y_ejecutar_cursor(cursor):
    try:
        # Ruta predefinida de archivos .txt
        directorio = r"C:\GBD\Cursors"

        # Listar los archivos .txt en el directorio
        archivos_txt = [f for f in os.listdir(directorio) if f.endswith('.txt')]
        if not archivos_txt:
            print("No se encontraron archivos .txt en el directorio especificado.")
            return

        # Mostrar los archivos disponibles
        print("Archivos disponibles:")
        for idx, archivo in enumerate(archivos_txt, start=1):
            print(f"{idx}. {archivo}")

        # Solicitar al usuario que seleccione un archivo
        seleccion = int(input("Seleccione el número del archivo a ejecutar: "))
        if seleccion < 1 or seleccion > len(archivos_txt):
            print("Selección no válida.")
            return

        # Leer el contenido del archivo seleccionado
        archivo_seleccionado = archivos_txt[seleccion - 1]
        ruta_archivo = os.path.join(directorio, archivo_seleccionado)
        with open(ruta_archivo, 'r') as file:
            contenido = file.read()

        # Verificar que el contenido contiene un cursor
        if "CURSOR" not in contenido.upper():
            print("El archivo seleccionado no contiene un cursor válido.")
            return

        # Habilitar DBMS_OUTPUT
        cursor.callproc("DBMS_OUTPUT.ENABLE")

        # Ejecutar el contenido del archivo como un bloque PL/SQL
        cursor.execute(contenido)

        # Buffer para capturar la salida
        buffer_size = 10000
        output = cursor.var(cx_Oracle.STRING)
        status_var = cursor.var(cx_Oracle.NUMBER)

        print("Resultados del cursor:")
        while True:
            cursor.callproc("DBMS_OUTPUT.GET_LINE", (output, status_var))
            if status_var.getvalue() != 0:
                break
            print(output.getvalue())

        print("Cursor ejecutado exitosamente desde el archivo:", archivo_seleccionado)
    except Exception as e:
        print(f"Error al ejecutar el cursor desde el archivo: {e}")

def ejecutar_consulta_hilo(dsn_tns, user, password, consulta, resultados):
    try:
        conexion = cx_Oracle.connect(user=user, password=password, dsn=dsn_tns)
        cursor = conexion.cursor()
        start_time = time.time()
        cursor.execute(consulta)
        if consulta.strip().upper().startswith("SELECT"):
            resultado = cursor.fetchall()
        else:
            conexion.commit()
            resultado = "Operación exitosa"
        end_time = time.time()
        elapsed_time = end_time - start_time
        resultados.append((consulta, resultado, elapsed_time))

        # Insertar en el historial de consultas
        insertar_historial(cursor, consulta, resultado)
        
        cursor.close()
        conexion.close()
    except Exception as e:
        resultados.append((consulta, str(e), None))

def insertar_historial(cursor, consulta, resultado):
    try:
        resultado_str = str(resultado) if isinstance(resultado, list) else resultado
        query = """
        INSERT INTO ALEXT.HISTORIAL_CONSULTAS (CONSULTA, RESULTADO)
        VALUES (:consulta, :resultado)
        """
        cursor.execute(query, consulta=consulta, resultado=resultado_str)
        cursor.connection.commit()
    except Exception as e:
        print(f"Error al insertar en el historial de consultas: {e}")

def aplicar_multiples_hilos(dsn_tns, user, password, consultas):
    try:
        hilos = []
        resultados = []
        
        for consulta in consultas:
            hilo = threading.Thread(target=ejecutar_consulta_hilo, args=(dsn_tns, user, password, consulta, resultados))
            hilos.append(hilo)
            hilo.start()
        
        for hilo in hilos:
            hilo.join()
        
        for consulta, resultado, elapsed_time in resultados:
            print(f"Consulta: {consulta}")
            if elapsed_time is not None:
                print(f"Resultado: {resultado}")
                print(f"Tiempo de ejecución: {elapsed_time:.4f} segundos")
            else:
                print(f"Error: {resultado}")
        print("Consultas ejecutadas en múltiples hilos exitosamente.")
    except Exception as e:
        print(f"Error al aplicar múltiples hilos: {e}")

def mostrar_historial_consultas(cursor):
    try:
        query = "SELECT * FROM ALEXT.HISTORIAL_CONSULTAS ORDER BY FECHA DESC"
        cursor.execute(query)
        historial = cursor.fetchall()
        if historial:
            print("Historial de consultas realizadas:")
            for registro in historial:
                print(registro)
        else:
            print("No hay historial de consultas disponible.")
    except Exception as e:
        print(f"Error al mostrar el historial de consultas: {e}")

def cambiar_estado_obras_prestadas(cursor):
    try:
        # Habilitar DBMS_OUTPUT
        cursor.callproc("DBMS_OUTPUT.ENABLE")

        # Definir el bloque PL/SQL con un cursor para recorrer todas las obras prestadas y devueltas
        plsql_block = """
        DECLARE
            CURSOR c_prestamos IS
                SELECT PrestamoID, ObraID, FechaDevolucion, PrestadorID 
                FROM ALEXT.PRESTAMO;

            v_prestamo_id ALEXT.PRESTAMO.PrestamoID%TYPE;
            v_obra_id ALEXT.PRESTAMO.ObraID%TYPE;
            v_fecha_devolucion ALEXT.PRESTAMO.FechaDevolucion%TYPE;
            v_prestador_id ALEXT.PRESTAMO.PrestadorID%TYPE;
            v_piso ALEXT.UBICACIONOBRA.Piso%TYPE;
            v_seccion ALEXT.UBICACIONOBRA.Seccion%TYPE;
            v_referencia ALEXT.UBICACIONOBRA.Referencia%TYPE;
            v_prestador_nombre ALEXT.PRESTADOR.Nombre%TYPE;
            v_prestador_apellido ALEXT.PRESTADOR.Apellido%TYPE;
        BEGIN
            OPEN c_prestamos;
            LOOP
                FETCH c_prestamos INTO v_prestamo_id, v_obra_id, v_fecha_devolucion, v_prestador_id;
                EXIT WHEN c_prestamos%NOTFOUND;

                -- Obtener detalles del prestador
                SELECT Nombre, Apellido INTO v_prestador_nombre, v_prestador_apellido
                FROM ALEXT.PRESTADOR
                WHERE PrestadorID = v_prestador_id;

                -- Obtener ubicación original de la obra
                SELECT piso, seccion, referencia INTO v_piso, v_seccion, v_referencia
                FROM ALEXT.UBICACIONOBRA u
                JOIN ALEXT.OBRADEARTE o ON u.ubicacionObraID = o.ubicacionObraID
                WHERE o.ObraID = v_obra_id;

                IF v_fecha_devolucion IS NULL THEN
                    UPDATE ALEXT.UBICACIONOBRA
                    SET piso = 'Prestado',
                        seccion = 'Prestado',
                        referencia = 'Prestado a ' || v_prestador_nombre || ' ' || v_prestador_apellido
                    WHERE ubicacionObraID = (
                        SELECT ubicacionObraID 
                        FROM ALEXT.OBRADEARTE 
                        WHERE ObraID = v_obra_id
                    );
                    
                    DBMS_OUTPUT.PUT_LINE('ObraID: ' || v_obra_id || ' prestada a: ' || v_prestador_nombre || ' ' || v_prestador_apellido);
                ELSE
                    UPDATE ALEXT.UBICACIONOBRA
                    SET piso = 'Por asignar',
                        seccion = 'Por asignar',
                        referencia = 'Devuelta por ' || v_prestador_nombre || ' ' || v_prestador_apellido
                    WHERE ubicacionObraID = (
                        SELECT ubicacionObraID 
                        FROM ALEXT.OBRADEARTE 
                        WHERE ObraID = v_obra_id
                    );

                    DBMS_OUTPUT.PUT_LINE('ObraID: ' || v_obra_id || ' devuelta por: ' || v_prestador_nombre || ' ' || v_prestador_apellido);
                END IF;
            END LOOP;
            CLOSE c_prestamos;
            COMMIT;
        END;
        """
        
        # Ejecutar el bloque PL/SQL
        cursor.execute(plsql_block)

        # Buffer para capturar la salida
        buffer_size = 10000
        output = cursor.var(cx_Oracle.STRING)
        status_var = cursor.var(cx_Oracle.NUMBER)

        while True:
            cursor.callproc("DBMS_OUTPUT.GET_LINE", (output, status_var))
            if status_var.getvalue() != 0:
                break
            print(output.getvalue())

        print("Estado de las obras prestadas y devueltas actualizado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el estado de las obras prestadas y devueltas: {e}")

def opcion12(cursor):
    print("Ejecutando Opción 12...")
    aplicar_metadatos(cursor)

def opcion13(cursor):
    print("Ejecutando Opción 13...")
    funcion_de_generacion(cursor)

def opcion14(cursor):
    print("Ejecutando Opción 14...")
    mostrar_datos_con_cursor(cursor)

def opcion15(cursor):
    print("Ejecutando Opción 15...")
    cursor_dinamico(cursor)

def opcion16(cursor):
    print("Ejecutando Opción 16...")
    cargar_y_ejecutar_cursor(cursor)

def opcion17(dsn_tns, user, password):
    print("Ejecutando Opción 17...")
    consultas = input("Ingrese las consultas a ejecutar, separadas por punto y coma: ").split(';')
    consultas = [consulta.strip() for consulta in consultas]
    aplicar_multiples_hilos(dsn_tns, user, password, consultas)

def opcion18(cursor):
    print("Ejecutando Opción 18...")
    mostrar_historial_consultas(cursor)

def opcion19(cursor):
    print("Ejecutando Opción 19...")
    cambiar_estado_obras_prestadas(cursor)

def main():
    dsn_tns = cx_Oracle.makedsn('localhost', '1521', service_name='xe')
    user = 'system'
    password = '1234'
    conexion = cx_Oracle.connect(user=user, password=password, dsn=dsn_tns)
    cursor = conexion.cursor()

    while True:
        mostrar_menu()
        opcion = input("Seleccione una opción: ")
        if opcion == '1':
            opcion1(cursor)
        elif opcion == '2':
            opcion2(cursor)
        elif opcion == '3':
            opcion3(cursor)
        elif opcion == '4':
            opcion4(cursor)
        elif opcion == '5':
            opcion5(cursor)
        elif opcion == '6':
            opcion6(cursor)
        elif opcion == '7':
            opcion7(cursor)
        elif opcion == '8':
            opcion8(cursor)
        elif opcion == '9':
            opcion9(cursor)
        elif opcion == '10':
            opcion10(cursor)
        elif opcion == '11':
            opcion11(cursor)
        elif opcion == '12':
            opcion12(cursor)
        elif opcion == '13':
            opcion13(cursor)
        elif opcion == '14':
            opcion14(cursor)
        elif opcion == '15':
            opcion15(cursor)
        elif opcion == '16':
            opcion16(cursor)
        elif opcion == '17':
            opcion17(dsn_tns, user, password)
        elif opcion == '18':
            opcion18(cursor)
        elif opcion == '19':
            opcion19(cursor)
        elif opcion == '20':
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Por favor, intenta de nuevo.")

    cursor.close()
    conexion.close()

if __name__ == '__main__':
    main()
