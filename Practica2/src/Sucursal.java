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
}
