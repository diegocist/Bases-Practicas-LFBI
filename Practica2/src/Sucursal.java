public class Sucursal {
	private String idSucursal; // Agrego el atributo como llave primaria
	private String nombre;
	private String calle;
	private String numeroInt;
	private String numeroExt;
	private String colonia;
	private String estado;
	private String telefono;
	// Dividiré el atributo de horario
	private String horarioApertura;
	private String horarioCierre;

	// Constructor vacío
	public Sucursal() {
	}

	// Constructor completo
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

	// Getters
	public String getIdSucursal() {
		return idSucursal;
	}

	public String getNombre() {
		return nombre;
	}

	public String getCalle() {
		return calle;
	}

	public String getNumeroInt() {
		return numeroInt;
	}

	public String getNumeroExt() {
		return numeroExt;
	}

	public String getColonia() {
		return colonia;
	}

	public String getEstado() {
		return estado;
	}

	public String getTelefono() {
		return telefono;
	}

	public String getHorarioApertura() {
		return horarioApertura;
	}

	public String getHorarioCierre() {
		return horarioCierre;
	}

	// Setters (sin setIdSucursal al ser llave primaria)
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setCalle(String calle) {
		this.calle = calle;
	}

	public void setNumeroInt(String numeroInt) {
		this.numeroInt = numeroInt;
	}

	public void setNumeroExt(String numeroExt) {
		this.numeroExt = numeroExt;
	}

	public void setColonia(String colonia) {
		this.colonia = colonia;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public void setHorarioApertura(String horarioApertura) {
		this.horarioApertura = horarioApertura;
	}

	public void setHorarioCierre(String horarioCierre) {
		this.horarioCierre = horarioCierre;
	}

	// Deberiamos usar trim() por seguridad de evitar espacios?
	/**
	 * Convierte el objeto Sucursal a una línea separada por comas para pasarlo a
	 * CSV
	 */
	public String toCSV() {
		// Usamos String.format para unir cada variable separada por una coma
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
	 * Convierte una sucursal guardada en CSV a un objeto Sucursal
	 */
	public static Sucursal fromCSV(String lineaCSV) {
		String[] r = lineaCSV.split(",");
		if (r.length != 10) {
			throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
		}
		return new Sucursal(r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9]);
	}

}
