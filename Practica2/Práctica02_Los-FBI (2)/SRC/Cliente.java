
/**
 * Clase que representa a la entidad Cliente en el sistema.
 * Contiene la información personal y de contacto del cliente, así como
 * los métodos para la conversión desde y hacia el formato CSV.
 */
public class Cliente {
	/** Llave primaria única del cliente */
	private String idCliente;

	/** Clave Única de Registro de Población */
	private String curp;

	/** Nombre(s) del cliente */
	private String nombre;

	/** Apellido paterno del cliente. */
	private String apellidoPaterno;

	/** Apellido materno del cliente. */
	private String apellidoMaterno;

	/** Fecha de nacimiento del cliente */
	private String fechaNacimiento;

	/** Edad del cliente */
	private String edad;

	/** Sexo del cliente (Masculino, Femenino o No binario). */
	private String sexo;

	/** Correos electrónicos del cliente (separados por |). */
	private String correos;

	/** Números telefónicos del cliente (separados por |). */
	private String telefonos;


	/**
     * Constructor vacio de la clase Cliente.
     */
	public Cliente() {
	}

	/**
     * Constructor completo para inicializar un cliente con todos sus datos.
     * 
     * @param idCliente Llave primaria única del cliente
     * @param curp CURP del cliente
     * @param nombre Nombre(s) del cliente
     * @param apellidoPaterno Apellido paterno
     * @param apellidoMaterno Apellido materno
     * @param fechaNacimiento Fecha de nacimiento
     * @param edad Edad del cliente
     * @param sexo Sexo del cliente
     * @param correos Lista de correos del cliente delimitados por |
     * @param telefonos Lista de teléfonos del cliente delimitados por |
     */
	public Cliente(String idCliente, String curp, String nombre, String apellidoPaterno, String apellidoMaterno,
			String fechaNacimiento, String edad, String sexo, String correos, String telefonos) {
		this.idCliente = idCliente;
		this.curp = curp;
		this.nombre = nombre;
		this.apellidoPaterno = apellidoPaterno;
		this.apellidoMaterno = apellidoMaterno;
		this.fechaNacimiento = fechaNacimiento;
		this.edad = edad;
		this.sexo = sexo;
		this.correos = correos;
		this.telefonos = telefonos;
	}

	/**
     * Obtiene el ID del cliente.
     * @return El identificador único del cliente.
     */
	public String getIdCliente() {
		return idCliente;
	}

	/**
     * Obtiene el CURP del cliente.
     * @return El CURP del cliente.
     */
	public String getCurp() {
		return curp;
	}

	/**
     * Obtiene el nombre de cliente
     * @return El nombre del cliente.
     */
	public String getNombre() {
		return nombre;
	}

	/**
     * Obtiene el apellidos paterno del cliente.
     * @return El apellido paterno del cliente.
     */
	public String getApellidoPaterno() {
		return apellidoPaterno;
	}

	/**
     * Obtiene el apellido materno cliente.
     * @return El apellido materno del cliente.
     */
	public String getApellidoMaterno() {
		return apellidoMaterno;
	}

	/**
     * Obtiene la fecha de nacimiento del cliente.
     * @return La fecha de nacimiento del cliente.
     */
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	/**
     * Obtiene la edad del cliente.
     * @return La edad del cliente.
     */
	public String getEdad() {
		return edad;
	}

	/**
     * Obtiene el sexo del cliente.
     * @return El sexo del cliente.
     */
	public String getSexo() {
		return sexo;
	}

	/**
     * Obtiene los correos del cliente.
     * @return  La cadena con los correos del cliente.
     */
	public String getCorreos() {
		return correos;
	}

	/**
     * Obtiene los telefonos del cliente.
     * @return  La cadena con los telefonos del cliente.
     */
	public String getTelefonos() {
		return telefonos;
	}

	/**
     * Establece la CURP del cliente.
     * @param curp La nueva CURP.
     */
	public void setCurp(String curp) {
		this.curp = curp;
	}

	/**
     * Establece el nombre del cliente.
     * @param nombre EL nuevo nombre.
     */
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	/**
     * Establece el apellido paterno del cliente.
     * @param apellidoPaterno El nuevo apellido paterno.
     */
	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	/**
     * Establece el apellido materno del cliente.
     * @param apellidoMaterno El nuevo apellido materno.
     */
	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}

	/**
     * Establece la fecha de nacimiento del cliente.
     * @param fechaNacimiento La nueva fecha de nacimiento.
     */
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	/**
     * Establece la edad del cliente.
     * @param edad La nueva edad.
     */
	public void setEdad(String edad) {
		this.edad = edad;
	}

	/**
     * Establece el sexo del cliente.
     * @param sexo El nuevo sexo.
     */
	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	/**
     * Establece los correos del cliente.
     * @param correos Los nuevos correos 
     */
	public void setCorreos(String correos) {
		this.correos = correos;
	}

	/**
     * Establece los telefonos del cliente.
     * @param telefonos Los nuevos telefonos.
     */
	public void setTelefonos(String telefonos) {
		this.telefonos = telefonos;
	}

	/**
     * Convierte el objeto Cliente a una cadena de texto para el archivo CSV.
     * @return Representación en formato CSV del cliente.
     */
	public String toCSV() {
		return String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
				this.idCliente,
                this.curp,
                this.nombre,
                this.apellidoPaterno,				
                this.apellidoMaterno,
                this.fechaNacimiento,
                this.edad,
                this.sexo,
                this.correos,
                this.telefonos);
	}

	/**
     * Crea un objeto Cliente a partir de un archivo CSV.
     * 
     * @param lineaCSV Cadena de texto en formato CSV con los atributos del cliente.
     * @return Una nueva instancia del objeto Cliente.
     * @throws IllegalArgumentException Si la linea del CSV no tiene el número de campos requeridos.
     */
	public static Cliente fromCSV(String lineaCSV) {
		String[] r = lineaCSV.split(",");
		if (r.length != 10) {
			throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
		}
		return new Cliente(r[0].trim(), r[1].trim(), r[2].trim(), r[3].trim(), r[4].trim(),
                           r[5].trim(), r[6].trim(), r[7].trim(), r[8].trim(), r[9].trim());
	}

}
