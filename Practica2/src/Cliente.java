public class Cliente {
	private String idCliente; // Llave primaria
	private String curp;
	private String nombre;
	private String apellidoPaterno;
	private String apellidoMaterno;
	private String fechaNacimiento;
	private String edad;
	private String sexo; // Restricción a Masculino, Femenino o No binario
	private String correos; // Propongo la notacion: correo1|correo2|...
	private String telefonos; // Análogo a la notación de correos

	// Constructor vacío
	public Cliente() {
	}

	// Constructor completo
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

	// Getters
	public String getIdCliente() {
		return idCliente;
	}

	public String getCurp() {
		return curp;
	}

	public String getNombre() {
		return nombre;
	}

	public String getApellidoPaterno() {
		return apellidoPaterno;
	}

	public String getApellidoMaterno() {
		return apellidoMaterno;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public String getEdad() {
		return edad;
	}

	public String getSexo() {
		return sexo;
	}

	public String getCorreos() {
		return correos;
	}

	public String getTelefonos() {
		return telefonos;
	}

	// Setters (sin setIdCliente al ser llave primaria)
	public void setCurp(String curp) {
		this.curp = curp;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setApellidoPaterno(String apellidoPaterno) {
		this.apellidoPaterno = apellidoPaterno;
	}

	public void setApellidoMaterno(String apellidoMaterno) {
		this.apellidoMaterno = apellidoMaterno;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public void setEdad(String edad) {
		this.edad = edad;
	}

	public void setSexo(String sexo) {
		this.sexo = sexo;
	}

	public void setCorreos(String correos) {
		this.correos = correos;
	}

	public void setTelefonos(String telefonos) {
		this.telefonos = telefonos;
	}

public String toCSV() {
		return String.format("%s,%s,%s,%s,%s,%s,%s,%s,%s,%s",
				this.idCliente,
                this.curp,
                this.nombre,
                this.apellidoMaterno,
                this.apellidoPaterno,
                this.fechaNacimiento,
                this.edad,
                this.sexo,
                this.correos,
                this.telefonos);
	}

	/**
	 * Convierte una sucursal guardada en CSV a un objeto Sucursal
	 */
	public static Cliente fromCSV(String lineaCSV) {
		String[] r = lineaCSV.split(",");
		if (r.length != 10) {
			throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
		}
		return new Cliente(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9]);
	}

}
