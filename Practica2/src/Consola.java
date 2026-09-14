import java.util.Scanner;

/**
 * Clase utilitaria encargada de gestionar las entradas del usuario
 * por consola a prueba de errores.
 */
public class Consola {

    private Scanner scanner = new Scanner(System.in);

    /**
     * Muestra un mensaje al usuario y lee una línea de texto desde consola.
     * Es estricto: no acepta campos vacíos ni comas (,) para mantener la integridad
     * de los datos en los archivos csv.
     *
     * @param mensaje texto para solicitar el dato.
     * @return la cadena ingresada por el usuario limpia de espacios.
     */
    public String leerString(String mensaje) {
        while (true) {
            System.out.print(mensaje);
            String entrada = scanner.nextLine().trim();

            if (entrada.isEmpty()) {
                System.out.println("Error: El campo no puede estar vacío. Inténtalo de nuevo.");
            } else if (entrada.contains(",")) {
                System.out.println("Error: El texto no puede contener comas (,). Inténtalo de nuevo.");
            } else {
                return entrada;
            }
        }
    }

    /**
     * Muestra un mensaje al usuario y lee una línea de texto desde consola.
     * Es opcional: si está vacío devuelve "S/N", pero rechaza comas (,).
     *
     * @param mensaje texto para solicitar el dato.
     * @return la cadena ingresada o "S/N".
     */
    public String leerStringOpcional(String mensaje) {
        while (true) {
            System.out.print(mensaje);
            String entrada = scanner.nextLine().trim();

            if (entrada.isEmpty()) {
                return "S/N";
            } else if (entrada.contains(",")) {
                System.out.println("Error: El texto no puede contener comas (,). Inténtalo de nuevo.");
            } else {
                return entrada;
            }
        }
    }

    /**
     * Muestra un mensaje al usuario y lee un número entero desde consola.
     * Repite la petición en caso de recibir caracteres no válidos.
     *
     * @param mensaje texto para solicitar el dato.
     * @return el número entero validado.
     */
    public int leerInt(String mensaje) {
        while (true) {
            try {
                System.out.print(mensaje);
                return Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número entero.");
            }
        }
    }
}