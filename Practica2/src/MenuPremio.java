import java.util.Scanner;

public class MenuPremio {
    private Scanner scanner = new Scanner(System.in);  
    private GestorPremio gestorPremio = new GestorPremio("premios.csv");

    private String leerString(String mensaje) {
        System.out.print(mensaje);
        return scanner.nextLine().trim();

    }

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

    private double leerDouble(String precio) {
        while (true) {
            try {
                System.out.print(precio);
                return Double.parseDouble(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número");
            }
        }
    }

    private void menuPremios() {
        int opcion = -1;
        while (opcion != 5) {
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
                default: System.out.println("\nIngresa un número del 1-5");
            }
        }
    }


    private void menuAgregar() {
        String idPremio = leerString("ID del premio: ");
        String nombre = leerString("Nombre: ");
        String categoria = leerString("Categoría: ");
        String rangoEdad = leerString("Rango de edad: ");
        double valorAproximado = leerDouble("Valor aproximado: ");
        int puntosCanjeo = leerInt("Puntos de canjeo: ");
        int cantidadDisponible = leerInt("Cantidad disponible: ");

        Premio nuevoPremio = new Premio(idPremio, nombre, categoria, rangoEdad, valorAproximado, puntosCanjeo, cantidadDisponible);
        gestorPremio.agregar(nuevoPremio);

    }

    private void menuConsultar() {
        String id = leerString("ID del premio a consultar: ");
        Premio premio = gestorPremio.buscarPorLlave(id);
        if (premio != null) {
            System.out.println("ID: " + premio.getIdPremio());
            System.out.println("Nombre: " + premio.getNombre());
            System.out.println("Categoría: " + premio.getCategoria());
            System.out.println("Rango de Edad: " + premio.getRangoEdad());
            System.out.println("Valor Aproximado: " + premio.getValorAproximado());
            System.out.println("Puntos de canjeo: " + premio.getPuntosCanjeo());
            System.out.println("Cantidad disponible: " + premio.getCantidadDisponible());
        } else {
            System.out.println("No se encontró el premio");
        }
    }

    private void menuEditar() {
        String id = leerString("ID del premio a editar: ");
        Premio premioOriginal = gestorPremio.buscarPorLlave(id);
        if (premioOriginal == null) {
            System.out.println("No se encontró el premio con ID: " + id);
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
            System.out.println("\n1. Editar Nombre");
            System.out.println("2. Editar Categoría");
            System.out.println("3. Editar Rango de Edad");
            System.out.println("4. Editar Valor Aproximado");
            System.out.println("5. Editar Puntos de canjeo");
            System.out.println("6. Editar Cantidad disponible");
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

    private void menuEliminar() {
        String id = leerString("ID del premio a eliminar: ");
        gestorPremio.eliminar(id);
    }
}