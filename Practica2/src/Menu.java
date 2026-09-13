import java.util.Scanner;

public class Menu {
    private Scanner scanner = new Scanner(System.in);
    
    public void mostrarMenuPrincipal() {
            System.out.println("████  █   █ █████ █     █      ███      ███   ███  █   █ █████ ");
            System.out.println("█   █ █   █ █     █     █     █   █    █     █   █ ██ ██ █    "); 
            System.out.println("████  █   █ ████  █     █     █████    █  ██ █████ █ █ █ ████  ");
            System.out.println("█     █   █ █     █     █     █   █    █   █ █   █ █   █ █    "); 
            System.out.println("█      ███  █████ █████ █████ █   █     ███  █   █ █   █ █████ ");
        int opcion = -1;
        while (opcion != 4) {
            System.out.println("\n1. Sucursales");
            System.out.println("2. Premios");
            System.out.println("3. Clientes");
            System.out.println("4. Salir");
            opcion = leerEntero("\nElige una opción: ");
            
            switch (opcion) {
                case 1: menuSucursales(); break;
                case 2: menuPremios(); break;
                case 3: menuClientes(); break;
                case 4: System.out.println("\nHasta luego :)"); break;
                default: System.out.println("\\nIngresa un número del 1-4");
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
        System.out.println("5. Volver al Inicio");
        opcion = leerEntero("\nElige una opción: ");
        switch (opcion) {
                case 1: //metodo para agregar un Premio   
                        break;
                case 2: //metodo para consultar un Premio     
    break;
                case 3: //metodo para editar un Premio     
    break;
                case 4: //metodo para eliminar un Premio 
    break;
                case 5: return;    
                default: System.out.println("\nIngresa un número del 1-5");
            }
        }
    }

    private void menuSucursales() {
        int opcion = -1;
        while (opcion != 5) {
            System.out.println("\n1. Agregar Sucursal");
            System.out.println("2. Consultar Sucursal");
            System.out.println("3. Editar Sucursal");
            System.out.println("4. Eliminar Sucursal");
            System.out.println("5. Volver al Inicio");
            opcion = leerEntero("\nElige una opción: ");
            switch (opcion) {
                case 1: //metodo para agregar una Sucursal
                break;
                case 2: //metodo para consultar una Sucursal
                break;
                case 3: //metodo para editar una Sucursal
                break;
                case 4: //metodo para eliminar una Sucursal
                break;
                case 5: return;
                default: System.out.println("ingresa un número del 1-5");
            }
        }
    }

    private void menuClientes() {
        int opcion = -1;
        while (opcion != 5) {
        System.out.println("\n1. Agregar Cliente");
        System.out.println("2. Consultar Cliente");
        System.out.println("3. Editar Cliente");
        System.out.println("4. Eliminar Cliente");
        System.out.println("5. Volver al Inicio");
        opcion = leerEntero("\nElige una opción: ");
        switch (opcion) {
                case 1: //metodo para agregar una Sucursal
                break;
                case 2: //metodo para consultar una Sucursal
                break;
                case 3: //metodo para editar una Sucursal
                break;
                case 4: //metodo para eliminar una Sucursal
                break;
                case 5: return;
                default: System.out.println("ingresa un número del 1-5");
            }
        }
    }
    
    private int leerEntero(String mensaje) {
        while (true) {
            try {
                System.out.print(mensaje);
                return Integer.parseInt(scanner.nextLine().trim());
            } catch (NumberFormatException e) {
                System.out.println("Ingresa un número entero");
            }
        }
    }
}