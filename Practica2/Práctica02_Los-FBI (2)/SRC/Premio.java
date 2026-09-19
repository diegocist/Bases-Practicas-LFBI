/**
 * Representa un premio disponible en el centro de entretenimiento PuellaGame.
 * Contiene la información necesaria para su almacenamiento en un archivo CSV
 * y su recuperación mediante los métodos {@link #toCSV()} y {@link #fromCSV(String)}.
 *
 */
public class Premio {

	/** Llave primaria del Premio. */
    private String idPremio;

    /** Nombre del premio. */
    private String nombre;

    /** Categoría a la que pertenece el premio. */
    private String categoria;

    /** Rango de edad para los premios. */
    private String rangoEdad;

    /** Valor aproximado en pesos del premio. */
    private double valorAproximado;

    /** Puntos necesarios para canjear el premio. */
    private int puntosCanjeo;

    /** Unidades disponibles del premio. */
    private int cantidadDisponible;

    /**
     * Constructor vacío.
     */
    public Premio() {
    }

    /**
     * Constructor completo para inicializar todos los atributos del premio.
     *
     * @param idPremio           Llave primaria del premio.
     * @param nombre             Nombre del premio.
     * @param categoria          Categoría del premio.
     * @param rangoEdad          Rango de edad del premio.
     * @param valorAproximado    Valor aproximado en pesos.
     * @param puntosCanjeo       Puntos necesarios para canjear el premio.
     * @param cantidadDisponible Cantidad de unidades disponibles.
     */
    public Premio(String idPremio, String nombre, String categoria, String rangoEdad, double valorAproximado, int puntosCanjeo, int cantidadDisponible) {
        this.idPremio = idPremio;
        this.nombre = nombre;
        this.categoria = categoria;
        this.rangoEdad = rangoEdad;
        this.valorAproximado = valorAproximado;
        this.puntosCanjeo = puntosCanjeo;
        this.cantidadDisponible = cantidadDisponible;
    }

	/**
	 * Obtiene la llave primaria del premio.
	 * @return Identificador único.
	 */
    public String getIdPremio(){ 
        return idPremio;
    }

    /**
     * Obtiene el nombre del premio.
     *
     * @return Nombre del premio.
     */
    public String getNombre(){
        return nombre;
    }

    /**
	 * Obtiene la categoría del premio.
     *
     * @return Categoría del premio.
     */
    public String getCategoria(){
        return categoria;
    }

    /**
	 * Obtiene el rango de edad al que está dirigido el premio.
     *
     * @return Rango de edad del premio.
     */
    public String getRangoEdad(){
        return rangoEdad;
    }

    /**
	 * Obtiene el valor aproximado en pesos del premio.
     *
     * @return Valor aproximado en pesos del premio.
     */
    public double getValorAproximado(){ 
        return valorAproximado; 
    }

    /**
	 * Obtiene os puntos necesarios para canjear el premio.
     *
     * @return Puntos necesarios para canjear el premio.
     */
    public int getPuntosCanjeo(){ 
        return puntosCanjeo; 
    }

    /**
	 * Obtiene la cantidad de unidades disponibles del premio
     *
     * @return Cantidad de unidades disponibles del premio.
     */
    public int getCantidadDisponible(){ 
        return cantidadDisponible; 
    }

	/**
	 * Establece el nombre del premio.
	 *
	 * @param nombre Nuevo nombre.
	 */
    public void setNombre(String nombre){ 
        this.nombre = nombre; 
    }

    /**
	 * Establece la categoría del premio.
	 *
     * @param categoria Nueva categoría del premio.
     */
    public void setCategoria(String categoria){ 
        this.categoria = categoria; 
    }

    /**
	 * Establece el rango de edad del premio.
	 *
     * @param rangoEdad Nuevo rango de edad del premio.
     */
    public void setRangoEdad(String rangoEdad){ 
        this.rangoEdad = rangoEdad; 
    }

    /**
	 * Establece el precio de adquisición
	 *
     * @param valorAproximado Nuevo valor aproximado en pesos.
     */
    public void setValorAproximado(double valorAproximado){ 
        this.valorAproximado = valorAproximado; 
    }

    /**
	 * Establece el nombre del premio.
	 *
     * @param puntosCanjeo Nuevos puntos necesarios para el canjeo.
     */
    public void setPuntosCanjeo(int puntosCanjeo){ 
        this.puntosCanjeo = puntosCanjeo;
    }

    /**
     * @param cantidadDisponible Nueva cantidad de unidades disponibles.
     */
    public void setCantidadDisponible(int cantidadDisponible){ 
        this.cantidadDisponible = cantidadDisponible; 
    }

	/**
	 * Convierte el objeto Premio a una cadena en formato CSV separada por comas.
	 *
	 * @return Cadenas de atributos concatenados por comas.
	 */
    public String toCSV() {
        return String.format("%s,%s,%s,%s,%s,%s,%s",
                this.idPremio, this.nombre, this.categoria, this.rangoEdad,
                String.valueOf(this.valorAproximado), String.valueOf(this.puntosCanjeo),
                String.valueOf(this.cantidadDisponible));
    }


	/**
	 * Construye una instancia de {@link Premio} a partir de una línea de texto
	 * CSV.
	 * Aplica la limpieza de espacios en blanco al inicio y al final de cada campo.
	 *
	 * @param lineaCSV Línea de texto con los valores separados por comas.
	 * @return Una nueva instancia de {@link Premio}.
	 * @throws IllegalArgumentException Si la línea no contiene exactamente los 7 atributos requeridos.
	 */
    public static Premio fromCSV(String lineaCSV) {
        String[] r = lineaCSV.split(",");
        if (r.length != 7) {
            throw new IllegalArgumentException("La línea del CSV no tiene el número de campos requerido.");
        }
        return new Premio(r[0], r[1], r[2], r[3], Double.parseDouble(r[4]),
                Integer.parseInt(r[5]), Integer.parseInt(r[6]));
    }
}