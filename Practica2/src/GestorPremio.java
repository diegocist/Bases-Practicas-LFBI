import java.io.File;
import java.io.IOException;
import java.io.FileWriter;
import java.io.BufferedWriter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase encargada de gestionar los objetos {@link Premio}
 * en un archivo CSV. Permite agregar, consultar, editar y eliminar premios.
 */
public class GestorPremio {

    /** Ruta del archivos CSV donde se almacenaran los registros. */
    private final String rutaArchivo;

       
     /**
	 * Constructor de la clase GestorPremio.
	 * Inicia la ruta del archivo y verifica que exista en el sistema de archivos.
	 * @param rutaArchivo Ruta relativa o absoluta del archivo CSV de premios.
	 */
    public GestorPremio(String rutaArchivo) {
        this.rutaArchivo = rutaArchivo;
        verificarArchivo();
    }

    /**
	 * Verifica si el archivo CSV existe en la ruta especificada
	 * Si no existe, se crea e inserta el encabezado correspondiente.
	 */
    private void verificarArchivo() {
        try {
            File archivo = new File(this.rutaArchivo);

            if (!archivo.exists() || archivo.length() == 0) {
                archivo.createNewFile();

                try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
                    bw.write( "idPremio,nombre,categoria,rangoEdad,valorAproximado,puntosCanjeo,cantidadDisponible");
                    bw.newLine();
                }

                System.out.println("Archivo creando en la ruta: " + archivo.getAbsolutePath());
            }
        } catch (IOException e) { 
            System.out.println("Error al encontrar o crear el archivo: " + e.getMessage());
        }
    }


	/**
	 * Agrega un nuevo premio al archivo CSV.
	 * @param premio Objeto {@link Premio} a registrar.
	 */
    public boolean agregar(Premio premio) {
        if (buscarPorLlave(premio.getIdPremio()) != null) {
            System.out.println("\nYa existe un premio con ese Id, usa otro");
            return false;
        }
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo, true))) {
            bw.newLine();
            bw.write(premio.toCSV());
            bw.newLine();
            System.out.println("\nPremio guardado correctamente.");
            return true;
        } catch (IOException e) {
            System.out.println("\nError al escribir en el archivo: " + e.getMessage());
            return false;
        }
    }

	/**
	 * Busca un premio en el archivo CSV mediante su llave primaria.
	 * 
	 * @param idPRemio La llave primaria del premio a consultar.
	 * @return Objeto {@link Premio} si es encontrado, {@code null} si no se encuentra.
	 */
    public Premio buscarPorLlave(String idPremio) {
        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;

            br.readLine();

            while ((linea = br.readLine()) != null) {
                if (linea.trim().isEmpty())
                    continue; 
                String[] r = linea.split(",");
                if (r[0].trim().equals(idPremio.trim())) {
                    return Premio.fromCSV(linea);
                }
            }

        } catch (IOException e) {
            System.out.println("\nError al leer el archivo: " + e.getMessage());
        }
        return null;
    }

    /**
	 * Recupera todos los registros de premios almacenados en el archivo CSV.
	 * @return Una lista {@link List} de objetos {@link Premio}.
	 */
    public List<Premio> obtenerTodos() {
        List<Premio> listaPrem = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
            String linea;
            br.readLine();

            while ((linea = br.readLine()) != null) {
                if (!linea.trim().isEmpty()) { 
                    listaPrem.add(Premio.fromCSV(linea));
                }
            }

        } catch (IOException e) {
            System.out.println("\nError al leer el archivo: " + e.getMessage());
        }
        return listaPrem;
    }

    /**
	 * Sobrescribe el archivo CSV con la lista de premios.
	 * @param premios Lista {@link List} de objetos {@link Premio} a guardar.
	 */
	private void reescribirArchivo(List<Premio> listaPremios) {
		try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo))) {

			bw.write("idPremio,nombre,categoria,rangoEdad,valorAproximado,puntosCanjeo,cantidadDisponible");
			bw.newLine();
			for (Premio p : listaPremios) {
				bw.write(p.toCSV());
				bw.newLine();
			}

		} catch (IOException e) {
			System.out.println("\nNo se pudo actualizar el archivo: " + e.getMessage());
		}
	}
    /**
     * Edita un Premio existente en el archivo CSV mediante por su llave primaria(idPremio).
     * Si se encuentra, reemplaza el objeto completo y reescribe el archivo CSV.
     * @param premioEditado Objeto {@link Premio} con el idPremio del premio pero con datos actializados.
 * @return {@code true} si el premio fue editado correctamente y {@code false} si no se encontró el premio con ese idPremio.
 */
    public boolean editar(Premio premioEditado) {
        List<Premio> listaPremios = obtenerTodos();
        boolean encontrado = false;

        for (int i = 0; i < listaPremios.size(); i++) {
            if (listaPremios.get(i).getIdPremio().equalsIgnoreCase(premioEditado.getIdPremio().trim())) {
                listaPremios.set(i, premioEditado);
                encontrado = true;
             break;
            }
        }

        if (encontrado) {
            reescribirArchivo(listaPremios);
            System.out.println("\nPremio editado con éxito.");
            return true;
        }
        System.out.println("\nNo se encontró el premio con ID: " + premioEditado.getIdPremio());
        return false;
    }

	/**
	 * Elimina un registro de un premio del archivo CSV mediante su llave primaria.
	 * @param idPremio Llave primaria del premio a eliminar.
	 * @return {@code true} si se eliminó el registro; {@code false} si no se encontró el premio.
	 */
	public boolean eliminar(String idPremio) {
		List<Premio> premios = obtenerTodos();
		boolean removido = premios.removeIf(c -> c.getIdPremio().equalsIgnoreCase(idPremio.trim()));

		if (removido) {
			reescribirArchivo(premios);
			System.out.println("\nPremio eliminado con éxito.");
			return true;
		}
		System.out.println("\nNo se encontró el premio con ID: " + idPremio);
		return false;
	}
}
