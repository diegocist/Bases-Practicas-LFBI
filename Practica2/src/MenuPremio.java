import java.util.Scanner;

/**
 * Menú de consola para gestionar premios (agregar, consultar,editar y eliminar) 
 * mediante interacción con el usuario a través de {@link Scanner}. 
 * Que delega las operaciones sobre los datos a {@link GestorPremio}.
 */
public class MenuPremio {

    private Scanner scanner = new Scanner(System.in);  

    private GestorPremio gestorPremio = new GestorPremio("Premios.csv");

    /**
     * Muestra un mensaje al usuario y lee una línea de texto desde consola.
     * Es estricto: no acepta campos vacíos ni comas (,) para mantener la integridad
     * de los datos en los archivos csv.
     *
     * @param mensaje texto para solicitar el dato.
     * @return la cadena ingresada por el usuario limpia de espacios.
     */
    private String leerString(String mensaje) {
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
     * Muestra un mensaje al usuario y lee un número entero desde consola.
     * Repite la petición hasta que se ingrese un valor válido.
     *
     * @param mensaje texto ingresado el usuario
     * @return el número tipo int ingresado por el usuario
     */
    private int leerInt(String mensaje) {
        while (true) {
            try {
                System.out.print(mensaje);
                return Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número entero");
            }
        }
    }

    /**
     * Muestra un mensaje al usuario y lee un número decimal desde consola.
     * Repitr la petición hasta que se ingrese un valor válido.
     *
     * @param precio texto ingresado el usuario
     * @return el número tipo double ingresado por el usuario
     */

    private double leerDouble(String precio) {
        while (true) {
            try {
                System.out.print(precio);
                return Double.parseDouble(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número válido");
            }
        }
    }

    /**
     * Menú principal de gestión de premios.
     * Redirige al submenú correspondiente según la opción elegida.
     */
    public void menuPremios() {
        int opcion = -1;
        while (opcion != 5) {
        System.out.println("\n--> GESTIÓN DE PREMIOS <--");
        System.out.println("\n1. Agregar Premio");
        System.out.println("2. Consultar Premio");
        System.out.println("3. Editar Premio");
        System.out.println("4. Eliminar Premio");
        System.out.println("5. Regresar");       
        opcion = leerInt("\nElige una opción: ");
        switch (opcion) {
                case 1: menuAgregar(); break;
                case 2: menuConsultar(); break;
                case 3: menuEditar(); break;
                case 4: menuEliminar(); break;
                case 5: return;
                default: System.out.println("\nIngresa un número del 1-5");
            }
        }
    }

    /**
     * Solicita al usuario los atributos de un nuevo premioy construye el
     * objeto {@link Premio} correspondiente
     */
    private void menuAgregar() {
        System.out.println("\nProporcione los siguientes datos: ");
        String idPremio = leerString("\nID del premio: ");
        String nombre = leerString("\nNombre: ");
        String categoria = leerString("Categoría: ");
        String rangoEdad = leerString("Rango de edad: ");
        double valorAproximado = leerDouble("Valor aproximado: ");
        int puntosCanjeo = leerInt("Puntos de canjeo: ");
        int cantidadDisponible = leerInt("Cantidad disponible: ");

        Premio nuevoPremio = new Premio(idPremio, nombre, categoria, rangoEdad, valorAproximado, puntosCanjeo, cantidadDisponible);
        gestorPremio.agregar(nuevoPremio);

    }

    /**
     * Solicita al usuario el ID de un premio y si existe muestra sus datos. 
     * Si no se encuentra, informa al usuario.
     */
    private void menuConsultar() {
        String id = leerString("\nID del premio a consultar: ");
        Premio premio = gestorPremio.buscarPorLlave(id);
        if (premio == null) {
            System.out.println("\nNo se encontró el premio");
            return;
        }
            System.out.println("\nDATOS DEL PREMIO");
            System.out.println("ID: " + premio.getIdPremio());
            System.out.println("\nNombre: " + premio.getNombre());
            System.out.println("Categoría: " + premio.getCategoria());
            System.out.println("Rango de Edad: " + premio.getRangoEdad());
            System.out.println("Valor Aproximado: " + premio.getValorAproximado());
            System.out.println("Puntos de canjeo: " + premio.getPuntosCanjeo());
            System.out.println("Cantidad disponible: " + premio.getCantidadDisponible());
    }

    /**
     * Solicita al usuario el ID de un premio existente y despliega un
     * submenú, permite editar uno o varios de sus campos 
     */
    private void menuEditar() {
        String id = leerString("\nID del premio a editar: ");
        Premio premioOriginal = gestorPremio.buscarPorLlave(id);
        if (premioOriginal == null) {
            System.out.println("\nNo se encontró el premio con ID: " + id);
            return;
        }       
        Premio premioEditado = new Premio(premioOriginal.getIdPremio(),
                                             premioOriginal.getNombre(), 
                                             premioOriginal.getCategoria(), 
                                             premioOriginal.getRangoEdad(), 
                                             premioOriginal.getValorAproximado(), 
                                             premioOriginal.getPuntosCanjeo(), 
                                             premioOriginal.getCantidadDisponible());
        int opcion = -1;
        while (opcion != 7) {
            System.out.println("\nEDITAR PREMIO");
            System.out.println("\n1. Editar Nombre (Actual: " + premioEditado.getNombre() + ")");
            System.out.println("2. Editar Categoría (Actual: " + premioEditado.getCategoria() + ")");
            System.out.println("3. Editar Rango de Edad (Actual: " + premioEditado.getRangoEdad() + ")");
            System.out.println("4. Editar Valor Aproximado (Actual: " + premioEditado.getValorAproximado() + ")");
            System.out.println("5. Editar Puntos de canjeo (Actual: " + premioEditado.getPuntosCanjeo() + ")");
            System.out.println("6. Editar Cantidad disponible (Actual: " + premioEditado.getCantidadDisponible() + ")");
            System.out.println("7. Regresar");

            opcion = leerInt("\nElige una opción: ");
            switch (opcion) {
                case 1:
                   String nuevoNombre =  leerString("\nIngresa nuevo nombre: ");
                    premioEditado.setNombre(nuevoNombre);
                    gestorPremio.editar(premioEditado); break;
                case 2:                    
                    String nuevaCategoria =  leerString("\nIngresa nueva categoria: ");
                    premioEditado.setCategoria(nuevaCategoria);
                    gestorPremio.editar(premioEditado); break;
                case 3:
                    String nuevoRangoDeEdad =  leerString("\nIngresa nuevo Rango de edad: ");
                    premioEditado.setRangoEdad(nuevoRangoDeEdad);
                    gestorPremio.editar(premioEditado); break;
                case 4:
                    double nuevoValorAproximado =  leerDouble("\nIngresa nuevo. Valor Aproximado: ");
                    premioEditado.setValorAproximado(nuevoValorAproximado);
                    gestorPremio.editar(premioEditado); break;
                case 5:
                    int nuevosPuntosDeCanjeo =  leerInt("\nIngresa nuevos Puntos de canjeo: ");
                    premioEditado.setPuntosCanjeo(nuevosPuntosDeCanjeo);
                    gestorPremio.editar(premioEditado); break;
                case 6: 
                    int nuevaCantidadDisponible =  leerInt("\nIngresa nueva Cantidad Disponible: ");
                    premioEditado.setCantidadDisponible(nuevaCantidadDisponible);
                    gestorPremio.editar(premioEditado); break;
                case 7: return;
                default: 
                    System.out.println("\nIngresa un número del 1-7");
            }
        }
    }

    /**
     * Solicita al usuario el ID de un premio y lo elimina
     */
    private void menuEliminar() {
        String id = leerString("\nID del premio a eliminar: ");
        Premio premio = gestorPremio.buscarPorLlave(id);
        if (premio == null) {
            System.out.println("No se encontró el premio con ID: " + id);
            return;
        } 
        gestorPremio.eliminar(id);
    }
}