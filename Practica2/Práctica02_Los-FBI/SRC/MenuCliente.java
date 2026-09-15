/**
 * Menú de consola para la gestión de clientes.
 * Proporciona opciones para agregar, consultar, editar y
 * eliminar registros coordinando las operaciones con {@link GestorCliente}.
 * 
 */
public class MenuCliente {

    private Consola consola = new Consola();
    private GestorCliente gestorCliente = new GestorCliente("Cliente.csv");

    /**
     * Solicita una cadena de texto validando que no contenga números.
     * Utilizado para Nombres, Apellidos y Sexo.
     *
     * @param mensaje Texto para la solicitud.
     * @return Cadena válida sin dígitos.
     */
    private String leerSoloTexto(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje);
            if (entrada.matches("^[a-zA-ZáéíóúÁÉÍÓÚñÑ\\s]+$")) {
                return entrada;
            }
            System.out.println("Error: Este campo no debe contener números ni caracteres especiales.");
        }
    }

    /**
     * Solicita la CURP validando que tenga exactamente 18 caracteres.
     *
     * @param mensaje Texto para la solicitud.
     * @return CURP de 18 caracteres en mayúsculas.
     */
    private String leerCurp(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje).toUpperCase();
            if (entrada.matches("^[A-Za-z0-9]{18}$")) {
                return entrada;
            }
            System.out.println("Error: La CURP debe contener exactamente 18 caracteres (letras y números).");
        }
    }

    /**
     * Solicita el sexo del cliente permitiendo únicamente 'F' o 'M'.
     *
     * @param mensaje Texto para la solicitud.
     * @return 'F' o 'M' en mayúscula.
     */
    private String leerSexo(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje).toUpperCase();
            if (entrada.equals("F") || entrada.equals("M")) {
                return entrada;
            }
            System.out.println("Error: Ingrese únicamente 'F' para Femenino o 'M' para Masculino.");
        }
    }

    /**
     * Solicita la fecha de nacimiento en formato DD/MM/AAAA o YYYY-MM-DD.
     *
     * @param mensaje Texto para la solicitud.
     * @return Cadena con el formato de fecha válido.
     */
    private String leerFechaNacimiento(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje);
            // Valida tanto formato DD/MM/AAAA como AAAA-MM-DD
            if (entrada.matches("^(\\d{2}/\\d{2}/\\d{4}|\\d{4}-\\d{2}-\\d{2})$")) {
                return entrada;
            }
            System.out.println("Error: La fecha debe tener el formato DD/MM/AAAA (ej. 15/05/2003) o AAAA-MM-DD.");
        }
    }

    /**
     * Solicita números telefónicos permitiendo únicamente dígitos y el separador '|'.
     *
     * @param mensaje Texto para la solicitud.
     * @return Cadena válida de teléfonos.
     */
    private String leerTelefonos(String mensaje) {
        while (true) {
            String entrada = consola.leerString(mensaje);
            if (entrada.matches("^[0-9|]+$")) {
                return entrada;
            }
            System.out.println("Error: Ingrese únicamente dígitos numéricos (0-9) separados por '|'.");
        }
    }

    /**
     * Despliega el menú principal para la administración de clientes.
     */
    public void menuClientes() {
        int opcion = -1;
        while (opcion != 5) {
            System.out.println("\n--> GESTIÓN DE CLIENTES <--");
            System.out.println("1. Agregar Cliente");
            System.out.println("2. Consultar Cliente");
            System.out.println("3. Editar Cliente");
            System.out.println("4. Eliminar Cliente");
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
     * Captura la información de un nuevo cliente y construye el objeto
     * {@link Cliente} para realizar el registro.
     */
    private void menuAgregar() {
        System.out.println("\nProporcione los siguientes datos: ");
        String idCliente = consola.leerString("ID del Cliente: ");

        if (gestorCliente.buscarPorLlave(idCliente) != null) {
            System.out.println("Error: Ya existe un cliente registrado con el ID: " + idCliente);
            return;
        }

        String curp = leerCurp("CURP: ");
        String nombre = leerSoloTexto("Nombre: ");
        String apellidoPaterno = leerSoloTexto("Apellido Paterno: ");
        String apellidoMaterno = leerSoloTexto("Apellido Materno: ");
        String fechaNacimiento = leerFechaNacimiento("Fecha de Nacimiento (DD/MM/AAAA): ");
        String edad = String.valueOf(consola.leerInt("Edad: "));
        String sexo = leerSexo("Sexo (F/M): ");
        String correos = consola.leerString("Correos (separados por | si son varios): ");
        String telefonos = leerTelefonos("Teléfonos (separados por | si son varios): ");

        Cliente nuevoCliente = new Cliente(idCliente, curp, nombre, apellidoPaterno, apellidoMaterno,
                fechaNacimiento, edad, sexo, correos, telefonos);

        gestorCliente.agregar(nuevoCliente);
    }

    /**
     * Pide el ID de un cliente para obtener su información almacenada
     * y mostrarlo en pantalla.
     */
    private void menuConsultar() {
        String idCliente = consola.leerString("\nIndique el ID del Cliente a consultar: ");

        Cliente cliente = gestorCliente.buscarPorLlave(idCliente);

        if (cliente == null) {
            System.out.println("No se encontró el cliente de ID: " + idCliente);
            return;
        }

        System.out.println("\nDATOS DEL CLIENTE");
        System.out.println("ID: " + cliente.getIdCliente());
        System.out.println("CURP: " + cliente.getCurp());
        System.out.println("Nombre completo: " + cliente.getNombre() + " " + cliente.getApellidoPaterno() + " " + cliente.getApellidoMaterno());
        System.out.println("Fecha de Nacimiento: " + cliente.getFechaNacimiento() + " (" + cliente.getEdad() + " años)");
        System.out.println("Sexo: " + cliente.getSexo());
        System.out.println("Correos: " + cliente.getCorreos());
        System.out.println("Teléfonos: " + cliente.getTelefonos());
    }

    /**
     * Presenta las opciones disponibles para editar atributos
     * de un cliente existente.
     */
    private void menuEditar() {
        String idCliente = consola.leerString("\nProporcione el ID del Cliente a editar: ");

        Cliente cliOriginal = gestorCliente.buscarPorLlave(idCliente);

        if (cliOriginal == null) {
            System.out.println("No se encontró el cliente con ID: " + idCliente);
            return;
        }

        Cliente cliEditado = new Cliente(
                cliOriginal.getIdCliente(), cliOriginal.getCurp(), cliOriginal.getNombre(),
                cliOriginal.getApellidoPaterno(), cliOriginal.getApellidoMaterno(), cliOriginal.getFechaNacimiento(),
                cliOriginal.getEdad(), cliOriginal.getSexo(), cliOriginal.getCorreos(),
                cliOriginal.getTelefonos());

        int opcion = -1;
        while (opcion != 10) {
            System.out.println("\nEDITAR CLIENTE");
            System.out.println("1. Editar CURP (" + cliEditado.getCurp() + ")");
            System.out.println("2. Editar Nombre (" + cliEditado.getNombre() + ")");
            System.out.println("3. Editar Apellido Paterno (" + cliEditado.getApellidoPaterno() + ")");
            System.out.println("4. Editar Apellido Materno (" + cliEditado.getApellidoMaterno() + ")");
            System.out.println("5. Editar Fecha de Nacimiento (" + cliEditado.getFechaNacimiento() + ")");
            System.out.println("6. Editar Edad (" + cliEditado.getEdad() + ")");
            System.out.println("7. Editar Sexo (" + cliEditado.getSexo() + ")");
            System.out.println("8. Editar Correos (" + cliEditado.getCorreos() + ")");
            System.out.println("9. Editar Teléfonos (" + cliEditado.getTelefonos() + ")");
            System.out.println("10. Regresar");

            opcion = consola.leerInt("\nElige el campo que deseas modificar (Ingrese solo el número): ");

            switch (opcion) {
                case 1:
                    String nuevaCurp = leerCurp("\nIngresa la nueva CURP: ");
                    cliEditado.setCurp(nuevaCurp);
                    gestorCliente.editar(cliEditado);
                    break;
                case 2:
                    String nuevoNombre = leerSoloTexto("\nIngresa el nuevo nombre: ");
                    cliEditado.setNombre(nuevoNombre);
                    gestorCliente.editar(cliEditado);
                    break;
                case 3:
                    String nuevoApPat = leerSoloTexto("\nIngresa el nuevo apellido paterno: ");
                    cliEditado.setApellidoPaterno(nuevoApPat);
                    gestorCliente.editar(cliEditado);
                    break;
                case 4:
                    String nuevoApMat = leerSoloTexto("\nIngresa el nuevo apellido materno: ");
                    cliEditado.setApellidoMaterno(nuevoApMat);
                    gestorCliente.editar(cliEditado);
                    break;
                case 5:
                    String nuevaFechaNac = leerFechaNacimiento("\nIngresa la nueva fecha de nacimiento: ");
                    cliEditado.setFechaNacimiento(nuevaFechaNac);
                    gestorCliente.editar(cliEditado);
                    break;
                case 6:
                    String nuevaEdad = String.valueOf(consola.leerInt("\nIngresa la nueva edad: "));
                    cliEditado.setEdad(nuevaEdad);
                    gestorCliente.editar(cliEditado);
                    break;
                case 7:
                    String nuevoSexo = leerSexo("\nIngresa el nuevo sexo (F/M): ");
                    cliEditado.setSexo(nuevoSexo);
                    gestorCliente.editar(cliEditado);
                    break;
                case 8:
                    String nuevosCorreos = consola.leerString("\nIngresa los nuevos correos (separados por |): ");
                    cliEditado.setCorreos(nuevosCorreos);
                    gestorCliente.editar(cliEditado);
                    break;
                case 9:
                    String nuevosTelefonos = leerTelefonos("\nIngresa los nuevos teléfonos (separados por |): ");
                    cliEditado.setTelefonos(nuevosTelefonos);
                    gestorCliente.editar(cliEditado);
                    break;
                case 10:
                    return;
                default:
                    System.out.println("\nIngresa un número del 1-10");
            }
        }
    }

    /**
     * Solicita el ID del cliente a eliminar y procesa la eliminación
     * mediante la instancia de {@link GestorCliente}.
     */
    private void menuEliminar() {
        String idCliente = consola.leerString("Proporcione el ID del Cliente a eliminar: ");
        Cliente cli = gestorCliente.buscarPorLlave(idCliente);
        if (cli == null) {
            System.out.println("No se encontró el cliente con ID: " + idCliente);
            return;
        }
        gestorCliente.eliminar(idCliente);
    }
}