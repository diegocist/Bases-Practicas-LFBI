import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Clase encargada de administrar la persistencia en disco y las operaciones
 * Se permite crear, leer, actualizar y eliminar para los objetos de la clase {@link Cliente}.
 */
public class GestorCliente {
    /** Ruta del archivos CSV donde se almacenaran los registros. */
	private final String rutaArchivo;

    /**
	 * Constructor de la clase GestorCliente.
	 * Inicia la ruta del archivo y verifica que exista en el sistema de archivos.
	 * @param rutaArchivo Ruta relativa o absoluta del archivo CSV de clientes.
	 */
	public GestorCliente(String rutaArchivo) {
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
			if (!archivo.exists()) {
				archivo.createNewFile();
				try (BufferedWriter bw = new BufferedWriter(new FileWriter(archivo))) {
					bw.write("idCliente,curp,nombre,apellidoPaterno,apellidoMaterno,fechaNacimiento,edad,sexo,correos,telefonos");
					bw.newLine();
				}
				System.out.println("Archivo creado en la ruta: " + archivo.getAbsolutePath());
			}
		} catch (IOException e) {
			System.out.println("Error al encontrar o crear el archivo: " + e.getMessage());
		}
	}

	/**
	 * Agrega un nuevo cliente al archivo CSV.
	 * @param cli Objeto {@link Cliente} a registrar.
	 * @return {@code true} si el cliente se guardó con éxito; {@code false} si la llave ya existe o ocurrio algún error.
	 */
	public boolean agregar(Cliente cli) {
		if (buscarPorLlave(cli.getIdCliente()) != null) {
			System.out.println("Error: Ya existe un cliente registrado con esa llave (idCliente): " + cli.getIdCliente());
			return false;
		}

		try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo, true))) {
			bw.write(cli.toCSV());
			bw.newLine();
			System.out.println("El cliente se guardó correctamente.");
			return true;
		} catch (IOException e) {
			System.out.println("Error al escribir en el archivo: " + e.getMessage());
			return false;
		}
	}

	/**
	 * Busca un cliente en el archivo CSV mediante su llave primaria.
	 * 
	 * @param idCliente Llave primaria del cliente a consultar.
	 * @return Objeto {@link Cliente} si es encontrado, {@code null} si no se encuentra.
	 */
	public Cliente buscarPorLlave(String idCliente) {
		try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
			String linea;
			br.readLine(); // Omitir la primera línea que contiene los encabezados

			while ((linea = br.readLine()) != null) {
				if (linea.trim().isEmpty())
                    continue;
				String[] r = linea.split(",");
				if (r[0].trim().equalsIgnoreCase(idCliente.trim())) {
					return Cliente.fromCSV(linea);
				}
			}
		} catch (IOException e) {
			System.out.println("Error al leer el archivo: " + e.getMessage());
		}
		return null;
	}

	/**
	 * Recupera todos los registros de clientes almacenados en el archivo CSV.
	 * @return Una lista {@link List} de objetos {@link Cliente}.
	 */
	public List<Cliente> obtenerTodos() {
		List<Cliente> lista = new ArrayList<>();
		try (BufferedReader br = new BufferedReader(new FileReader(this.rutaArchivo))) {
			String linea;
			br.readLine(); // Omitir el encabezado

			while ((linea = br.readLine()) != null) {
				if (!linea.trim().isEmpty()) {
					lista.add(Cliente.fromCSV(linea));
				}
			}
		} catch (IOException e) {
			System.out.println("Error al leer el archivo: " + e.getMessage());
		}
		return lista;
	}

	/**
	 * Sobrescribe el archivo CSV con la lista de clientes proporcionada y mantiene el encabezado.
	 * @param clientes Lista {@link List} de objetos {@link Cliente} a guardar.
	 */
	private void reescribirArchivo(List<Cliente> clientes) {
		try (BufferedWriter bw = new BufferedWriter(new FileWriter(this.rutaArchivo))) {
			bw.write("idCliente,curp,nombre,apellidoPaterno,apellidoMaterno,fechaNacimiento,edad,sexo,correos,telefonos");
			bw.newLine();
			for (Cliente c : clientes) {
				bw.write(c.toCSV());
				bw.newLine();
			}
		} catch (IOException e) {
			System.out.println("Error al reescribir el archivo: " + e.getMessage());
		}
	}

	/**
	 * Edita la información de un cliente que ya existe buscando por su idCliente y actualiza la información.
	 * 
	 * @param idCliente Llave primaria del cliente a modificar
	 * @param curp Nueva CURP
	 * @param nombre Nuevo nombre
	 * @param apPat Nuevo apellido paterno
	 * @param apMat Nuevo apellido materno
	 * @param fechaNac Nueva fecha de nacimiento
	 * @param edad Nueva edad
	 * @param sexo Nuevo sexo
	 * @param correos Nuevos correos electrónicos
	 * @param telefonos Nuevos numeros de telefonos
	 * @return {@code true} si la edición fue exitosa; {@code false} si no se encontró el idCliente
	 */
	public boolean editar(String idCliente, String curp, String nombre, String apPat, String apMat,
						 String fechaNac, String edad, String sexo, String correos, String telefonos) {
		List<Cliente> clientes = obtenerTodos();
		boolean encontrado = false;

		for (Cliente c : clientes) {
			if (c.getIdCliente().equalsIgnoreCase(idCliente.trim())) {
				c.setCurp(curp);
				c.setNombre(nombre);
				c.setApellidoPaterno(apPat);
				c.setApellidoMaterno(apMat);
				c.setFechaNacimiento(fechaNac);
				c.setEdad(edad);
				c.setSexo(sexo);
				c.setCorreos(correos);
				c.setTelefonos(telefonos);
				encontrado = true;
				break;
			}
		}

		if (encontrado) {
			reescribirArchivo(clientes);
			System.out.println("Cliente editado con éxito.");
			return true;
		}
		System.out.println("No se encontró el cliente con ID: " + idCliente);
		return false;
	}

	/**
	 * Elimina un registro de un cliente del archivo CSV mediante su llave primaria.
	 * 
	 * @param idCliente Llave primaria del cliente a eliminar.
	 * @return {@code true} si se eliminó el registro; {@code false} si no se encontró el cliente.
	 */
	public boolean eliminar(String idCliente) {
		List<Cliente> clientes = obtenerTodos();
		boolean removido = clientes.removeIf(c -> c.getIdCliente().equalsIgnoreCase(idCliente.trim()));

		if (removido) {
			reescribirArchivo(clientes);
			System.out.println("Cliente eliminado con éxito.");
			return true;
		}
		System.out.println("No se encontró el cliente con ID: " + idCliente);
		return false;
	}
}