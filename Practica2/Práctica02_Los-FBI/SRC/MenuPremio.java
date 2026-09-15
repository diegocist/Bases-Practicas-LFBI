import java.util.Scanner;

/**
 * Menú de consola para gestionar premios (agregar, consultar,editar y eliminar) 
 * mediante interacción con el usuario a través de {@link Scanner}. 
 * Que delega las operaciones sobre los datos a {@link GestorPremio}.
 */
public class MenuPremio {

    private Consola consola = new Consola();
    private GestorPremio gestorPremio = new GestorPremio("Premios.csv");

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
        opcion = consola.leerInt("\nElige una opción: ");
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
        String idPremio = consola.leerString("\nID del premio: ");
        String nombre = consola.leerString("\nNombre: ");
        String categoria = consola.leerString("Categoría: ");
        String rangoEdad = consola.leerString("Rango de edad: ");
        double valorAproximado = consola.leerDouble("Valor aproximado: ");
        int puntosCanjeo = consola.leerInt("Puntos de canjeo: ");
        int cantidadDisponible = consola.leerInt("Cantidad disponible: ");

        Premio nuevoPremio = new Premio(idPremio, nombre, categoria, rangoEdad, valorAproximado, puntosCanjeo, cantidadDisponible);
        gestorPremio.agregar(nuevoPremio);

    }

    /**
     * Solicita al usuario el ID de un premio y si existe muestra sus datos. 
     * Si no se encuentra, informa al usuario.
     */
    private void menuConsultar() {
        String id = consola.leerString("\nID del premio a consultar: ");
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
        String id = consola.leerString("\nID del premio a editar: ");
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

            opcion = consola.leerInt("\nElige una opción: ");
            switch (opcion) {
                case 1:
                   String nuevoNombre =  consola.leerString("\nIngresa nuevo nombre: ");
                    premioEditado.setNombre(nuevoNombre);
                    gestorPremio.editar(premioEditado); break;
                case 2:                    
                    String nuevaCategoria =  consola.leerString("\nIngresa nueva categoria: ");
                    premioEditado.setCategoria(nuevaCategoria);
                    gestorPremio.editar(premioEditado); break;
                case 3:
                    String nuevoRangoDeEdad =  consola.leerString("\nIngresa nuevo Rango de edad: ");
                    premioEditado.setRangoEdad(nuevoRangoDeEdad);
                    gestorPremio.editar(premioEditado); break;
                case 4:
                    double nuevoValorAproximado =  consola.leerDouble("\nIngresa nuevo. Valor Aproximado: ");
                    premioEditado.setValorAproximado(nuevoValorAproximado);
                    gestorPremio.editar(premioEditado); break;
                case 5:
                    int nuevosPuntosDeCanjeo =  consola.leerInt("\nIngresa nuevos Puntos de canjeo: ");
                    premioEditado.setPuntosCanjeo(nuevosPuntosDeCanjeo);
                    gestorPremio.editar(premioEditado); break;
                case 6: 
                    int nuevaCantidadDisponible =  consola.leerInt("\nIngresa nueva Cantidad Disponible: ");
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
        String id = consola.leerString("\nID del premio a eliminar: ");
        Premio premio = gestorPremio.buscarPorLlave(id);
        if (premio == null) {
            System.out.println("No se encontró el premio con ID: " + id);
            return;
        } 
        gestorPremio.eliminar(id);
    }
}