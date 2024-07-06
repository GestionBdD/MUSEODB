import psycopg2
import threading
import time

def mostrar_menu():
    print("\nMenu de Opciones:")
    print("1. Generacion de Disparadores de Auditoria")
    print("2. Ejecución de consultas en hilos")
    print("3. Mostrar historial de consultas")
    print("4. Salir")

def opcion1(cursor):
    print("Ejecutando Opción 1...")
    
    cursor.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
    tablas = cursor.fetchall()
    
    print("\nTablas disponibles en la base de datos:")
    for idx, tabla in enumerate(tablas):
        print(f"{idx + 1}. {tabla[0]}")
    
    seleccion = input("\nSeleccione las tablas para auditar (separadas por coma, o 'all' para todas): ")
    
    if seleccion.lower() == 'all':
        tablas_seleccionadas = [tabla[0] for tabla in tablas]
    else:
        try:
            indices = map(int, seleccion.split(','))
            tablas_seleccionadas = [tablas[idx - 1][0] for idx in indices]
        except ValueError:
            print("Selección inválida. Por favor, use números separados por comas.")
            return

    with open("auditoria_triggers.sql", "w", encoding="utf-8") as sql_file:
        for tabla in tablas_seleccionadas:
            if tabla.lower() != 'auditoria':
                funcion_sql = crear_funcion_trigger(tabla)
                trigger_sql = crear_trigger(tabla)
                sql_file.write(funcion_sql)
                sql_file.write(trigger_sql)
                cursor.execute(funcion_sql)
                cursor.execute(trigger_sql)
                
    print("\nDisparadores de auditoría creados exitosamente y guardados en 'auditoria_triggers.sql'.")

def crear_funcion_trigger(tabla):
    return f"""
    CREATE OR REPLACE FUNCTION audit_{tabla}() RETURNS TRIGGER AS $$
    BEGIN
        IF TG_OP = 'INSERT' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'INSERT', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'UPDATE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'UPDATE', row_to_json(NEW)::text);
            RETURN NEW;
        ELSIF TG_OP = 'DELETE' THEN
            INSERT INTO AUDITORIA (NOMBRE_TABLA, USUARIO_DB, ACCION, DESCRIPCION_CAMBIOS)
            VALUES ('{tabla}', SESSION_USER, 'DELETE', row_to_json(OLD)::text);
            RETURN OLD;
        END IF;
        RETURN NULL;
    END;
    $$ LANGUAGE plpgsql;
    """

def crear_trigger(tabla):
    trigger_name = f"{tabla}_audit_trigger"
    return f"""
    DROP TRIGGER IF EXISTS {trigger_name} ON {tabla};
    CREATE TRIGGER {trigger_name}
    AFTER INSERT OR UPDATE OR DELETE ON {tabla}
    FOR EACH ROW EXECUTE FUNCTION audit_{tabla}();
    """

# Función para ejecutar consultas en hilos
def ejecutar_consulta_hilo(dsn, user, password, consulta, resultados):
    try:
        conexion = psycopg2.connect(dsn=dsn, user=user, password=password)
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

# Función para insertar en el historial de consultas
def insertar_historial(cursor, consulta, resultado):
    try:
        resultado_str = str(resultado) if isinstance(resultado, list) else resultado
        query = """
        INSERT INTO historial_consultas (consulta, resultado)
        VALUES (%s, %s)
        """
        cursor.execute(query, (consulta, resultado_str))
        cursor.connection.commit()
    except Exception as e:
        print(f"Error al insertar en el historial de consultas: {e}")

# Función para aplicar múltiples hilos
def aplicar_multiples_hilos(dsn, user, password, consultas):
    try:
        hilos = []
        resultados = []
        
        for consulta in consultas:
            hilo = threading.Thread(target=ejecutar_consulta_hilo, args=(dsn, user, password, consulta, resultados))
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

# Función para mostrar el historial de consultas
def mostrar_historial_consultas(cursor):
    try:
        query = "SELECT * FROM historial_consultas ORDER BY fecha DESC"
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

# Opción para ejecutar consultas en hilos
def opcion_hilos(dsn, user, password):
    print("Ejecutando Opción de Hilos...")
    consultas = input("Ingrese las consultas a ejecutar, separadas por punto y coma: ").split(';')
    consultas = [consulta.strip() for consulta in consultas]
    aplicar_multiples_hilos(dsn, user, password, consultas)

# Opción para mostrar el historial de consultas
def opcion_historial(cursor):
    print("Ejecutando Opción de Historial...")
    mostrar_historial_consultas(cursor)

# Función principal sin cambios en la estructura
def main():
    database = "MUSEOGESTION"
    try:
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
            opcion = input("Selecciona una opción: ")
            if opcion == '1':
                opcion1(cursor)
            elif opcion == '2':
                dsn = f"dbname='{database}' user='postgres' password='123456' host='localhost' port='5432'"
                opcion_hilos(dsn, "postgres", "123456")
            elif opcion == '3':
                opcion_historial(cursor)
            elif opcion == '4':
                print("Saliendo del programa...")
                break
            else:
                print("Opción no válida. Por favor, intenta de nuevo.")
    except psycopg2.Error as e:
        print(f"Error en la conexión a la base de datos: {e}")
    finally:
        if 'cursor' in locals() and not cursor.closed:
            cursor.close()
        if 'conexion' in locals() and not conexion.closed:
            conexion.close()

if __name__ == '__main__':
    main()