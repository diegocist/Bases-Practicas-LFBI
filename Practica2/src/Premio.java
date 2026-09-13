public class Premio {
	private String idPremio;
	private String nombre;
	private String categoria;
	private String rangoEdad;
	private double valorAproximado;
	private double puntosCanjeo;
	private int cantidadDisponible;

	// Getters
	public String getIdPremio() {
		return idPremio;
	}

	public String getNombre() {
		return nombre;
	}

	public String getCategoria() {
		return categoria;
	}

	public String getRangoEdad() {
		return rangoEdad;
	}

	public double getValorAproximado() {
		return valorAproximado;
	}

	public double getPuntosCanjeo() {
		return puntosCanjeo;
	}

	public int getCantidadDisponible() {
		return cantidadDisponible;
	}

	// Setters (sin setIdPremio al ser llave primaria)
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public void setRangoEdad(String rangoEdad) {
		this.rangoEdad = rangoEdad;
	}

	public void setValorAproximado(double valorAproximado) {
		this.valorAproximado = valorAproximado;
	}

	public void setPuntosCanjeo(double puntosCanjeo) {
		this.puntosCanjeo = puntosCanjeo;
	}

	public void setCantidadDisponible(int cantidadDisponible) {
		this.cantidadDisponible = cantidadDisponible;
	}
}