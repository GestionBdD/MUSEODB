import psycopg2
from psycopg2 import connect, sql, Error
import subprocess
import os
from datetime import datetime
from reportlab.lib.pagesizes import letter
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle
from reportlab.lib import colors
from reportlab.pdfgen import canvas

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
    print("20. Salir")

    #CREAR USUARIOS
def crear_usuario_postgres(cursor, nombre_usuario, contraseña):
    try:
        query = sql.SQL("CREATE USER {nombre} WITH PASSWORD %s").format(nombre=sql.Identifier(nombre_usuario))
        cursor.execute(query, (contraseña,))
        print("Usuario creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el usuario: {e}")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    nombre_usuario = input("Ingrese el nombre del nuevo usuario de la base de datos: ")
    contraseña = input("Ingrese la contraseña para el nuevo usuario: ")
    crear_usuario_postgres(cursor, nombre_usuario, contraseña)

    #MOSTRAR USUARIOS
def mostrar_usuarios(cursor):
    try:
        query = """
        SELECT rolname FROM pg_roles
        WHERE rolcanlogin = TRUE
        AND rolname NOT IN ('pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_signal_backend')
        ORDER BY rolname;
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

    #MODIFICAR USUARIOS
def cambiar_nombre_usuario(cursor, nombre_actual, nuevo_nombre):
    try:
        query = sql.SQL("ALTER ROLE {old_name} RENAME TO {new_name}").format(
            old_name=sql.Identifier(nombre_actual),
            new_name=sql.Identifier(nuevo_nombre)
        )
        cursor.execute(query)
        print("Nombre de usuario cambiado exitosamente.")
    except Exception as e:
        print(f"Error al cambiar el nombre del usuario: {e}")

def cambiar_contraseña_usuario(cursor, nombre_usuario, nueva_contraseña):
    try:
        query = sql.SQL("ALTER ROLE {name} WITH PASSWORD %s").format(
            name=sql.Identifier(nombre_usuario)
        )
        cursor.execute(query, (nueva_contraseña,))
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

    #ELIMINAR USUARIOS
def eliminar_usuario_postgres(cursor, nombre_usuario):
    try:
        query = sql.SQL("DROP ROLE {name}").format(name=sql.Identifier(nombre_usuario))
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
                eliminar_usuario_postgres(cursor, nombre_usuario)
            else:
                print("Eliminación cancelada.")
        except ValueError:
            print("Por favor, ingrese un número válido.")
        except IndexError:
            print("Selección no válida. Por favor, elija un número de la lista.")
    else:
        print("No hay usuarios para eliminar.")

    #CREAR UN ROL
def crear_rol_postgres(cursor, nombre_rol):
    try:
        query = sql.SQL("CREATE ROLE {name}").format(name=sql.Identifier(nombre_rol))
        cursor.execute(query)
        print(f"Rol '{nombre_rol}' creado exitosamente.")
    except Exception as e:
        print(f"Error al crear el rol: {e}")


def opcion5(cursor):
    print("Ejecutando Opción 5...")
    nombre_rol = input("Ingrese el nombre del nuevo rol: ")
    crear_rol_postgres(cursor, nombre_rol)

    #MOSTRAR ROLES
def mostrar_roles(cursor):
    try:
        cursor.execute("SELECT rolname FROM pg_roles WHERE rolcanlogin = FALSE AND rolname NOT IN ('pg_monitor', 'pg_read_all_settings', 'pg_read_all_stats', 'pg_stat_scan_tables', 'pg_signal_backend')")
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

    #ASIGNAR UN ROL A UN USUARIO
def asignar_rol_a_usuario(cursor, nombre_usuario, nombre_rol):
    try:
        query = sql.SQL("GRANT {role} TO {user}").format(
            role=sql.Identifier(nombre_rol),
            user=sql.Identifier(nombre_usuario)
        )
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

    #RESPALDO DE BASE DE DATOS
def realizar_respaldo(host, database, user, password, output_dir):
    try:
        # Asegurarse de que el directorio de salida existe, si no, crearlo
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)
            print(f"Directorio {output_dir} creado.")
        
        # Generar nombre de archivo basado en la fecha y hora actual
        fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
        nombre_archivo = f"{database}_{fecha_hora}.dump"  # Cambiado de .sql a .dump
        output_path = os.path.join(output_dir, nombre_archivo)

        # Configurar las variables de entorno para la autenticación
        os.environ["PGHOST"] = host
        os.environ["PGDATABASE"] = database
        os.environ["PGUSER"] = user
        os.environ["PGPASSWORD"] = password

        # Ejecutar pg_dump para crear el respaldo en formato personalizado
        subprocess.run(["pg_dump", "-Fc", "-f", output_path], check=True, text=True)
        print(f"Respaldo realizado exitosamente en {output_path}")
    except Exception as e:
        print(f"Error al realizar el respaldo: {e}")

def opcion8(cursor):
    print("Ejecutando Opción 8...")
    host = "localhost"
    database = "MUSEOGESTION"
    user = "postgres"
    password = "123456"
    output_dir = "D:/Backups"  
    realizar_respaldo(host, database, user, password, output_dir)


def realizar_respaldo(host, database, user, password, output_dir):
    try:
        nombre_respaldo = f'respaldo.sql'
        ruta_respaldo = os.path.join(output_dir, nombre_respaldo)
        os.environ['PGPASSWORD'] = password
        comando_respaldo = [
            "D:/PostgreSQL/bin/pg_dump.exe",
            "-U", user,
            "-h", host,
            "-f", ruta_respaldo,
            database
        ]
        subprocess.run(comando_respaldo, check=True)
        print(f"Respaldo de la base de datos creado exitosamente en: {ruta_respaldo}")
    except Exception as e:
        print("Error al crear el respaldo:", e)
    finally:
        if 'PGPASSWORD' in os.environ:
            del os.environ['PGPASSWORD']

def opcion9(cursor):
    print("Ejecutando Opción 9...")
    host = "localhost"
    database = "MUSEOGESTION"
    user = "postgres"
    password = "123456"
    input_dir = "D:/Backups"  # Directorio donde se encuentra el respaldo
    nombre_respaldo = "respaldo.sql"
    ruta_respaldo = os.path.join(input_dir, nombre_respaldo)
    restaurar_base_datos(host, database, user, password, ruta_respaldo)

def restaurar_base_datos(host, database, user, password, ruta_respaldo):
    try:
        os.environ['PGPASSWORD'] = password
        comando_restaurar = [
            "D:/PostgreSQL/bin/psql.exe",
            "-U", user,
            "-h", host,
            "-d", database,
            "-f", ruta_respaldo
        ]
        subprocess.run(comando_restaurar, check=True)
        print("Base de datos restaurada exitosamente.")
    except Exception as e:
        print("Error al restaurar la base de datos:", e)
    finally:
        if 'PGPASSWORD' in os.environ:
            del os.environ['PGPASSWORD']

            
    #GENERAR PDF
def obtener_datos_tabla(cursor, tabla, columnas):
    try:
        columnas_sql = ", ".join(columnas)  # Crea una cadena de las columnas para la consulta SQL
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
    # Generar un nombre de archivo único basado en la fecha y hora actuales
    fecha_hora = datetime.now().strftime("%Y%m%d_%H%M%S")
    output_path = os.path.join(output_dir, f"{tabla}_informe_{fecha_hora}.pdf")

    doc = SimpleDocTemplate(output_path, pagesize=letter)
    story = []
    
    # Encabezados de la tabla
    data = [columnas]  # Añade los nombres de las columnas como encabezados
    
    # Agregar los datos de la tabla
    data.extend(datos)  # Añade los datos de cada fila en la base de datos
    
    # Crear la tabla con los datos
    t = Table(data)
    
    # Estilos de la tabla
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

def obtener_detalles_tablas(cursor, database):
    """Obtiene una lista de todas las tablas y sus columnas en la base de datos especificada."""
    cursor.execute("""
        SELECT table_name, column_name, data_type 
        FROM information_schema.columns 
        WHERE table_schema = 'public' AND table_catalog = %s
        ORDER BY table_name, ordinal_position;
    """, (database,))
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

def generar_informe_completo(cursor, tablas_seleccionadas, join_condition, database):
    from_clause = " NATURAL JOIN ".join(tablas_seleccionadas.keys())
    select_clause = ", ".join([f"{tabla}.{col}" for tabla, cols in tablas_seleccionadas.items() for col in cols])

    if join_condition:
        query = f"SELECT {select_clause} FROM {from_clause} WHERE {join_condition}"
    else:
        query = f"SELECT {select_clause} FROM {from_clause}"

    try:
        cursor.execute(query)
        datos = cursor.fetchall()
        columnas = [col for cols in tablas_seleccionadas.values() for col in cols]

        output_dir = r"C:\Users\mbarc\OneDrive\Escritorio\MUSEOGESTION\BD\informes"
        generar_pdf_con_datos("_y_".join(tablas_seleccionadas.keys()), datos, columnas, output_dir)
    except Exception as e:
        print(f"Error al ejecutar la consulta: {e}")


def obtener_relaciones(cursor, tablas):
    if len(tablas) < 2:
        return ""  

    condiciones = []
    query = """
    SELECT kcu.table_name AS foreign_table, 
           kcu.column_name AS foreign_column, 
           ccu.table_name AS primary_table, 
           ccu.column_name AS primary_column
    FROM information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu 
      ON tc.constraint_name = kcu.constraint_name
    JOIN information_schema.constraint_column_usage AS ccu 
      ON ccu.constraint_name = tc.constraint_name
    WHERE tc.constraint_type = 'FOREIGN KEY' AND 
          (kcu.table_name = ANY(%s) AND ccu.table_name = ANY(%s));
    """

    # Formateamos la lista como un array de texto de PostgreSQL.
    tablas_array = "{%s}" % ','.join(tablas)  # Crea un array literal de PostgreSQL
    cursor.execute(query, (tablas_array, tablas_array))
    results = cursor.fetchall()

    for res in results:
        cond = f"{res[0]}.{res[1]} = {res[2]}.{res[3]}"
        condiciones.append(cond)

    return " AND ".join(condiciones)

def opcion10(cursor):
    database = 'MUSEOGESTION'
    print("Ejecutando Opción 10...")
    tablas = obtener_detalles_tablas(cursor, database)
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

    # Generar la condición de unión automáticamente
    join_condition = obtener_relaciones(cursor, list(seleccion_tablas.keys()))
    generar_informe_completo(cursor, seleccion_tablas, join_condition, database)


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
        CREATE OR REPLACE FUNCTION sp_create_{nombre_tabla}({params_str}) RETURNS VOID AS $$
        BEGIN
            INSERT INTO {nombre_tabla} ({cols_str})
            VALUES ({", ".join([f"p_{col}" for col in cols])});
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        """)

        # Procedimiento READ
        procedimientos.append(f"""
        CREATE OR REPLACE FUNCTION sp_read_{nombre_tabla} (p_id IN {columnas[0][1]}) RETURNS SETOF {nombre_tabla} AS $$
        BEGIN
            RETURN QUERY
            SELECT *
            FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
        END;
        $$ LANGUAGE plpgsql;
        """)

        # Procedimiento UPDATE
        set_clause = ", ".join([f"{col} = p_{col}" for col in cols[1:]])
        procedimientos.append(f"""
        CREATE OR REPLACE FUNCTION sp_update_{nombre_tabla} ({params_str}) RETURNS VOID AS $$
        BEGIN
            UPDATE {nombre_tabla}
            SET {set_clause}
            WHERE {cols[0]} = p_{cols[0]};
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        """)

        # Procedimiento DELETE
        procedimientos.append(f"""
        CREATE OR REPLACE FUNCTION sp_delete_{nombre_tabla} (p_id IN {columnas[0][1]}) RETURNS VOID AS $$
        BEGIN
            DELETE FROM {nombre_tabla}
            WHERE {cols[0]} = p_id;
            COMMIT;
        END;
        $$ LANGUAGE plpgsql;
        """)
    return "\n".join(procedimientos)

def guardar_procedimientos_en_archivo(procedimientos, archivo_sql):
    with open(archivo_sql, "w") as file:
        file.write(procedimientos)
    print(f"Procedimientos almacenados generados en el archivo: {archivo_sql}")

def opcion11(cursor):
    print("Ejecutando opción 11...")
    schema = 'MUSEOGESTION'  # Cambiar al esquema correspondiente
    tablas = obtener_detalles_tablas(cursor, schema)
    if tablas:
        procedimientos = generar_procedimientos_crud(tablas)
        guardar_procedimientos_en_archivo(procedimientos, "procedimientos_crud.sql")
    else:
        print("No se encontraron tablas en el esquema especificado.")


def main():
    database = "MUSEOGESTION"
    conexion = psycopg2.connect(
        host="localhost",
        database=database,
        user="postgres",
        password="123456"
    )
    conexion.autocommit = True 
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
        elif opcion == '20':
            print("Saliendo del programa...")
            break
        else:
            print("Opción no válida. Por favor, intenta de nuevo.")

    cursor.close()
    conexion.close()

if __name__ == '__main__':
    main()