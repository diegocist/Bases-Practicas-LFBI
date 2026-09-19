/**
 * Representa la entidad Sucursal del sistema.
 * Contiene los atributos de identificación, ubicación geográfica, contacto
 * y horarios de atención, así como métodos para su serialización en formato
 * CSV.
 */
public class Sucursal {

	/** Llave primaria de la sucursal. */
	private String idSucursal;

	/** Nombre de la sucursal. */
	private String nombre;

	/** Calle de la dirección física. */
	private String calle;

	/** Número interior de la dirección física. */
	private String numeroInt;

	/** Número exterior de la dirección física. */
	private String numeroExt;

	/** Colonia o asentamiento de la dirección física. */
	private String colonia;

	/** Estado o entidad federativa de la dirección física. */
	private String estado;

	/** Número telefónico de contacto. */
	private String telefono;

	/** Hora de inicio de atención al cliente. */
	private String horarioApertura;

	/** Hora de término de atención al cliente. */
	private String horarioCierre;

	/**
	 * Constructor vacio.
	 */
	public Sucursal() {
	}

	/**
	 * Constructor completo para inicializar todos los atributos de la sucursal.
	 *
	 * @param idSucursal      Llave primaria de la sucursal.
	 * @param nombre          Nombre de la sucursal.
	 * @param calle           Calle de la ubicación.
	 * @param numeroInt       Número interior.
	 * @param numeroExt       Número exterior.
	 * @param colonia         Colonia de la ubicación.
	 * @param estado          Estado o entidad federativa.
	 * @param telefono        Teléfono de contacto.
	 * @param horarioApertura Hora de apertura.
	 * @param horarioCierre   Hora de cierre.
	 */
	public Sucursal(String idSucursal, String nombre, String calle, String numeroInt, String numeroExt,
			String colonia, String estado, String telefono, String horarioApertura, String horarioCierre) {
		this.idSucursal = idSucursal;
		this.nombre = nombre;
		this.calle = calle;
		this.numeroInt = numeroInt;
		this.numeroExt = numeroExt;
		this.colonia = colonia;
		this.estado = estado;
		this.telefono = telefono;
		this.horarioApertura = horarioApertura;
		this.horarioCierre = horarioCierre;
	}

	/**
	 * Obtiene la llave primaria de la sucursal.
	 *
	 * @return Identificador único.
	 */
	public String getIdSucursal() {
		return idSucursal;
	}

	/**
	 * Obtiene el nombre de la sucursal.
	 *
	 * @return Nombre de la sucursal.
	 */
	public String getNombre() {
		return nombre;
	}

	/**
	 * Obtiene la calle de la sucursal.
	 *
	 * @return Calle de la ubicación.
	 */
	public String getCalle() {
		return calle;
	}

	/**
	 * Obtiene el número interior de la sucursal.
	 *
	 * @return Número interior.
	 */
	public String getNumeroInt() {
		return numeroInt;
	}

	/**
	 * Obtiene el número exterior de la sucursal.
	 *
	 * @return Número exterior.
	 */
	public String getNumeroExt() {
		return numeroExt;
	}

	/**
	 * Obtiene la colonia de la sucursal.
	 *
	 * @return Colonia de la ubicación.
	 */
	public String getColonia() {
		return colonia;
	}

	/**
	 * Obtiene el estado de la sucursal.
	 *
	 * @return Estado o entidad federativa.
	 */
	public String getEstado() {
		return estado;
	}

	/**
	 * Obtiene el teléfono de la sucursal.
	 *
	 * @return Número telefónico.
	 */
	public String getTelefono() {
		return telefono;
	}

	/**
	 * Obtiene el horario de apertura.
	 *
	 * @return Hora de apertura.
	 */
	public String getHorarioApertura() {
		return horarioApertura;
	}

	/**
	 * Obtiene el horario de cierre.
	 *
	 * @return Hora de cierre.
	 */
	public String getHorarioCierre() {
		return horarioCierre;
	}

	/**
	 * Establece el nombre de la sucursal.
	 *
	 * @param nombre Nuevo nombre.
	 */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	/**
	 * Establece la calle de la sucursal.
	 *
	 * @param calle Nueva calle.
	 */
	public void setCalle(String calle) {
		this.calle = calle;
	}

	/**
	 * Establece el número interior de la sucursal.
	 *
	 * @param numeroInt Nuevo número interior.
	 */
	public void setNumeroInt(String numeroInt) {
		this.numeroInt = numeroInt;
	}

	/**
	 * Establece el número exterior de la sucursal.
	 *
	 * @param numeroExt Nuevo número exterior.
	 */
	public void setNumeroExt(String numeroExt) {
		this.numeroExt = numeroExt;
	}

	/**
	 * Establece la colonia de la sucursal.
	 *
	 * @param colonia Nueva colonia.
	 */
	public void setColonia(String colonia) {
		this.colonia = colonia;
	}

	/**
	 * Establece el estado de la sucursal.
	 *
	 * @param estado Nuevo estado.
	 */
	public void setEstado(String estado) {
		this.estado = estado;
	}

	/**
	 * Establece el teléfono de contacto.
	 *
	 * @param telefono Nuevo teléfono.
	 */
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	/**
	 * Establece el horario de apertura.
	 *
	 * @param horarioApertura Nueva hora de apertura.
	 */
	public void setHorarioApertura(String horarioApertura) {
		this.horarioApertura = horarioApertura;
	}

	/**
	 * Establece el horario de cierre.
	 *
	 * @param horarioCierre Nueva hora de cierre.
	 */
	public void setHorarioCierre(String horarioCierre) {
		this.horarioCierre = horarioCierre;
	}

	/**
	 * Convierte el objeto Sucursal a una cadena en formato CSV separada por comas.
	 *
	 * @return Cadenas de atributos concatenados por comas.
	 */
	public String toCSV() {
		return String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
				this.idSucursal,
				this.nombre,
				this.calle,
				this.numeroInt,
				this.numeroExt,
				this.colonia,
				this.estado,
				this.telefono,
				this.horarioApertura,
				this.horarioCierre);
	}

	/**
	 * Construye una instancia de {@link Sucursal} a partir de una línea de texto
	 * CSV.
	 * Aplica la limpieza de espacios en blanco al inicio y al final de cada campo.
	 *
	 * @param lineaCSV Línea de texto con los valores separados por comas.
	 * @return Una nueva instancia de {@link Sucursal}.
	 * @throws IllegalArgumentException Si la línea no contiene exactamente los 10
	 *                                  atributos requeridos.
	 */
	public static Sucursal fromCSV(String lineaCSV) {
		String[] r = lineaCSV.split(",");
		if (r.length != 10) {
			throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
		}
		return new Sucursal(
				r[0].trim(),
				r[1].trim(),
				r[2].trim(),
				r[3].trim(),
				r[4].trim(),
				r[5].trim(),
				r[6].trim(),
				r[7].trim(),
				r[8].trim(),
				r[9].trim());
	}
}