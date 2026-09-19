/**
 * Menú de consola para gestionar sucursales (agregar, consultar, editar y
 * eliminar)
 * delegando las operaciones sobre los datos a {@link GestorSucursal}.
 */
public class MenuSucursal {

    private GestorSucursal gestorSucursal = new GestorSucursal("Sucursal.csv");
    private Consola consola = new Consola();

    /**
     * Muestra un mensaje al usuario y lee una línea de texto desde consola
     * asegurando que contenga únicamente números.
     *
     * @param mensaje texto para solicitar el dato.
     * @return la cadena numérica ingresada.
     */
    private String leerTelefono(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje); // Aprovechamos que ya valida vacíos y comas
            if (entrada.matches("\\d+")) { // Valida que sean puros dígitos numéricos
                return entrada;
            } else {
                System.out.println("Error: El teléfono solo debe contener números. Inténtalo de nuevo.");
            }
        }
    }

    /**
     * Menú principal de gestión de sucursales.
     * Redirige al submenú correspondiente según la opción elegida.
     */
    public void menuSucursales() {
        int opcion = -1;
        while (opcion != 5) {
            System.out.println("\n--> GESTIÓN DE SUCURSALES <--");
            System.out.println("1. Agregar Sucursal");
            System.out.println("2. Consultar Sucursal");
            System.out.println("3. Editar Sucursal");
            System.out.println("4. Eliminar Sucursal");
            System.out.println("5. Regresar");

            opcion = consola.leerInt("\nElige una opción: ");
            switch (opcion) {
                case 1:
                    menuAgregar();
                    break;
                case 2:
                    menuConsultar();
                    break;
                case 3:
                    menuEditar();
                    break;
                case 4:
                    menuEliminar();
                    break;
                case 5:
                    return;
                default:
                    System.out.println("\nIngresa un número del 1 al 5");
            }
        }
    }

    /**
     * Solicita al usuario los atributos de una nueva sucursal y construye el
     * objeto {@link Sucursal} correspondiente para guardarlo.
     */
    private void menuAgregar() {
        System.out.println("\nProporcione los siguientes datos: ");
        String idSucursal = consola.leerString("ID de la Sucursal: ");
        String nombre = consola.leerString("Nombre: ");
        String calle = consola.leerString("Calle: ");
        String numeroInt = consola.leerStringOpcional("Número interior (Presiona Enter si no tiene): ");
        String numeroExt = consola.leerString("Número exterior: ");
        String colonia = consola.leerString("Colonia: ");
        String estado = consola.leerString("Estado: ");
        String telefono = leerTelefono("Teléfono: ");
        String horarioApertura = consola.leerString("Horario de Apertura (ej. 7:00): ");
        String horarioCierre = consola.leerString("Horario de Cierre (ej. 19:00): ");

        Sucursal nuevaSucursal = new Sucursal(idSucursal, nombre, calle, numeroInt, numeroExt, colonia, estado,
                telefono,
                horarioApertura, horarioCierre);

        gestorSucursal.agregar(nuevaSucursal);
    }

    /**
     * Solicita al usuario el ID de una sucursal y muestra sus datos.
     * Si no se encuentra, informa al usuario.
     */
    private void menuConsultar() {
        String idSucursal = consola.leerString("\nProporcione el ID de la Sucursal a consultar: ");

        Sucursal sucOriginal = gestorSucursal.buscarPorLlave(idSucursal);

        if (sucOriginal == null) {
            System.out.println("No se encontró la sucursal con ID: " + idSucursal);
            return;
        }

        System.out.println("\nDATOS DE LA SUCURSAL");
        System.out.println("ID: " + sucOriginal.getIdSucursal());
        System.out.println("Nombre: " + sucOriginal.getNombre());
        System.out.println("Dirección: " + sucOriginal.getCalle() + " #" + sucOriginal.getNumeroExt() +
                " (Int. " + sucOriginal.getNumeroInt() + "), Col. " + sucOriginal.getColonia() +
                ", " + sucOriginal.getEstado());
        System.out.println("Teléfono: " + sucOriginal.getTelefono());
        System.out.println("Horario: " + sucOriginal.getHorarioApertura() + " a " + sucOriginal.getHorarioCierre());
    }

    /**
     * Solicita al usuario el ID de una sucursal existente y despliega un
     * submenú para permitir editar uno o varios de sus campos.
     */
    private void menuEditar() {
        String idSucursal = consola.leerString("\nProporcione el ID de la Sucursal a editar: ");

        Sucursal sucOriginal = gestorSucursal.buscarPorLlave(idSucursal);

        if (sucOriginal == null) {
            System.out.println("No se encontró la sucursal con ID: " + idSucursal);
            return;
        }

        Sucursal sucEditada = new Sucursal(
                sucOriginal.getIdSucursal(), sucOriginal.getNombre(), sucOriginal.getCalle(),
                sucOriginal.getNumeroInt(), sucOriginal.getNumeroExt(), sucOriginal.getColonia(),
                sucOriginal.getEstado(), sucOriginal.getTelefono(), sucOriginal.getHorarioApertura(),
                sucOriginal.getHorarioCierre());

        int opcion = -1;
        while (opcion != 10) {
            System.out.println("\nEDITAR SUCURSAL");
            System.out.println("1. Editar Nombre (Actual: " + sucEditada.getNombre() + ")");
            System.out.println("2. Editar Calle (Actual: " + sucEditada.getCalle() + ")");
            System.out.println("3. Editar Número Interior (Actual: " + sucEditada.getNumeroInt() + ")");
            System.out.println("4. Editar Número Exterior (Actual: " + sucEditada.getNumeroExt() + ")");
            System.out.println("5. Editar Colonia (Actual: " + sucEditada.getColonia() + ")");
            System.out.println("6. Editar Estado (Actual: " + sucEditada.getEstado() + ")");
            System.out.println("7. Editar Teléfono (Actual: " + sucEditada.getTelefono() + ")");
            System.out.println("8. Editar Horario de Apertura (Actual: " + sucEditada.getHorarioApertura() + ")");
            System.out.println("9. Editar Horario de Cierre (Actual: " + sucEditada.getHorarioCierre() + ")");
            System.out.println("10. Regresar");

            opcion = consola.leerInt("\nElige el campo que deseas modificar (Ingrese solo el número): ");

            switch (opcion) {
                case 1:
                    String nuevoNombre = consola.leerString("\nIngresa el nuevo nombre: ");
                    sucEditada.setNombre(nuevoNombre);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 2:
                    String nuevaCalle = consola.leerString("\nIngresa la nueva calle: ");
                    sucEditada.setCalle(nuevaCalle);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 3:
                    String nuevoNumInt = consola.leerStringOpcional(
                            "\nIngresa el nuevo número interior (Presiona Enter si no tiene): ");
                    sucEditada.setNumeroInt(nuevoNumInt);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 4:
                    String nuevoNumExt = consola.leerString("\nIngresa el nuevo número exterior: ");
                    sucEditada.setNumeroExt(nuevoNumExt);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 5:
                    String nuevaColonia = consola.leerString("\nIngresa la nueva colonia: ");
                    sucEditada.setColonia(nuevaColonia);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 6:
                    String nuevoEstado = consola.leerString("\nIngresa el nuevo estado: ");
                    sucEditada.setEstado(nuevoEstado);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 7:
                    String nuevoTelefono = leerTelefono("\nIngresa el nuevo teléfono: ");
                    sucEditada.setTelefono(nuevoTelefono);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 8:
                    String nuevoHorarioApertura = consola
                            .leerString("\nIngresa el nuevo horario de apertura (ej. 7:00): ");
                    sucEditada.setHorarioApertura(nuevoHorarioApertura);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 9:
                    String nuevoHorarioCierre = consola
                            .leerString("\nIngresa el nuevo horario de cierre (ej. 19:00): ");
                    sucEditada.setHorarioCierre(nuevoHorarioCierre);
                    gestorSucursal.editar(sucEditada);
                    break;
                case 10:
                    return;
                default:
                    System.out.println("\nIngresa un número del 1-10");
            }
        }
    }

    /**
     * Solicita al usuario el ID de una sucursal y la elimina delegando la
     * operación a {@link GestorSucursal}.
     */
    private void menuEliminar() {
        String idSucursal = consola.leerString("Proporcione el ID de la Sucursal a eliminar: ");
        Sucursal suc = gestorSucursal.buscarPorLlave(idSucursal);
        if (suc == null) {
            System.out.println("No se encontró la Sucursal con ID: " + idSucursal);
            return;
        }
        gestorSucursal.eliminar(idSucursal);
    }
}