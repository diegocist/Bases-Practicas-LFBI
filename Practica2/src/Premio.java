public class Premio {
	private String idPremio; // Llave primaria
	private String nombre;
	private String categoria;
	private String rangoEdad;
	private double valorAproximado;
	private double puntosCanjeo;
	private int cantidadDisponible;

	// Constructor vacío
	public Premio() {
	}

	// Constructor completo
	public Premio(String idPremio, String nombre, String categoria, String rangoEdad, double valorAproximado,
			double puntosCanjeo, int cantidadDisponible) {
		this.idPremio = idPremio;
		this.nombre = nombre;
		this.categoria = categoria;
		this.rangoEdad = rangoEdad;
		this.valorAproximado = valorAproximado;
		this.puntosCanjeo = puntosCanjeo;
		this.cantidadDisponible = cantidadDisponible;
	}

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

	public String toCSV() {
		// Usamos String.format para unir cada variable separada por una coma
		return String.format("%s,%s,%s,%s,%s,%s,%s",
				this.idPremio,
				this.nombre,
				this.categoria,
                this.rangoEdad,
                this.valorAproximado,
                this.puntosCanjeo,
                this.cantidadDisponible);
	}

	/**
	 * Convierte una Premio guardada en CSV a un objeto Sucursal
	 */
	public static Premio fromCSV(String lineaCSV) {
		String[] r = lineaCSV.split(",");
		if (r.length != 7) {
			throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
		}
		return new Premio (r[0], r[1], r[2], r[3], Double.parseDouble(r[4]), Double.parseDouble(r[5]), Integer.parseInt(r[6]));
    }
}